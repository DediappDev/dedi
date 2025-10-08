# Detailed Authentication Flow Diagrams

## 📋 Overview

This document provides comprehensive flow diagrams for the Matrix authentication system, including sequence diagrams, state transitions, and error handling flows.

## 🔄 Main Authentication Sequence

```mermaid
sequenceDiagram
    participant User
    participant PhoneUI as Phone Input Screen
    participant Backend as Authentication API
    participant OtpUI as OTP Verify Screen
    participant MatrixAPI as Matrix Homeserver
    participant Storage as Secure Storage
    participant ChatUI as Chat Interface

    Note over User,ChatUI: Phase 1: Phone Number Collection
    User->>PhoneUI: Enter phone number
    PhoneUI->>PhoneUI: Validate format (+90XXXXXXXXXX)
    PhoneUI->>Backend: POST /otp/request {phone}
    Backend->>Backend: Generate 6-digit OTP
    Backend->>User: Send SMS with OTP code
    Backend->>PhoneUI: 200 OK {status: "sent", dev_otp?: "123456"}
    PhoneUI->>OtpUI: Navigate with phone number

    Note over User,ChatUI: Phase 2: OTP Verification
    User->>OtpUI: Enter 6-digit OTP code
    OtpUI->>OtpUI: Auto-verify when complete
    OtpUI->>Backend: POST /otp/verify {phone, code}
    Backend->>Backend: Validate OTP code
    Backend->>OtpUI: 200 OK {access_token: JWT, mxid, user_id}

    Note over User,ChatUI: Phase 3: Matrix Credential Exchange
    OtpUI->>Backend: POST /otp/matrix-token {jwt_token, phone}
    Backend->>MatrixAPI: Register/login user with credentials
    MatrixAPI->>Backend: Matrix access token + device info
    Backend->>OtpUI: 200 OK {access_token: Matrix, mxid, device_id, homeserver}

    Note over User,ChatUI: Phase 4: Matrix Client Initialization
    OtpUI->>Storage: Store authentication state
    OtpUI->>OtpUI: Initialize Matrix client with credentials
    OtpUI->>MatrixAPI: Connect and verify session
    MatrixAPI->>OtpUI: Session confirmed
    OtpUI->>ChatUI: Navigate to chat interface

    Note over User,ChatUI: Phase 5: Session Establishment
    ChatUI->>MatrixAPI: Start initial sync
    MatrixAPI->>ChatUI: Room list and messages
    ChatUI->>User: Show chat interface
```

## 📱 Platform-Specific Flows

### Mobile App Flow

```mermaid
flowchart TD
    A[App Launch] --> B{Check Auth State}
    B -->|Authenticated| C[Restore Matrix Clients]
    B -->|Not Authenticated| D[Show Phone Input]

    C --> E{Client Restoration}
    E -->|Success| F[Navigate to Chat List]
    E -->|Failed| D

    D --> G[User Enters Phone]
    G --> H[Send OTP Request]
    H --> I{Request Success?}
    I -->|No| J[Show Error Message]
    I -->|Yes| K[Navigate to OTP Screen]

    K --> L[User Enters OTP]
    L --> M[Verify OTP]
    M --> N{OTP Valid?}
    N -->|No| O[Show Error, Stay on Screen]
    N -->|Yes| P[Exchange for Matrix Token]

    P --> Q{Matrix Token Success?}
    Q -->|No| R[Show Error with Retry]
    Q -->|Yes| S[Initialize Matrix Client]

    S --> T{Client Init Success?}
    T -->|No| U[Show Error, Retry Option]
    T -->|Yes| V[Save Auth State]

    V --> W[Start Background Sync]
    W --> F

    J --> D
    O --> L
    R --> P
    U --> S
```

### Web App Flow

```mermaid
flowchart TD
    A[Web App Load] --> B[Check Local Storage]
    B --> C{Auth Data Present?}
    C -->|No| D[Show Phone Input]
    C -->|Yes| E[Attempt Client Restore]

    E --> F{Restore Success?}
    F -->|Yes| G[Navigate to Chat]
    F -->|No| H[Clear Invalid Data]
    H --> D

    D --> I[Phone Input Form]
    I --> J[Submit Phone Number]
    J --> K{CORS Check}
    K -->|Failed| L[Show CORS Error]
    K -->|Success| M[Send OTP via XMLHttpRequest]

    M --> N{OTP Request Success?}
    N -->|No| O[Show Network Error]
    N -->|Yes| P[Show OTP Input]

    P --> Q[6-Digit OTP Input]
    Q --> R[Auto-submit on Complete]
    R --> S[Verify OTP via XHR]

    S --> T{Verification Success?}
    T -->|No| U[Show Error Message]
    T -->|Yes| V[Request Matrix Token]

    V --> W{Matrix Token Success?}
    W -->|No| X[Show Error with Retry]
    W -->|Yes| Y[Initialize Matrix Client]

    Y --> Z{Client Success?}
    Z -->|No| AA[Show Connection Error]
    Z -->|Yes| BB[Save to Local Storage]

    BB --> CC[Start Matrix Sync]
    CC --> G

    L --> D
    O --> D
    U --> Q
    X --> V
    AA --> Y
```

## 🔒 Security Flow Diagram

```mermaid
sequenceDiagram
    participant Client
    participant AuthAPI as Auth Backend
    participant MatrixHS as Matrix Homeserver
    participant SMS as SMS Provider

    Note over Client,SMS: Security Checkpoints

    Client->>AuthAPI: 1. Phone validation request
    AuthAPI->>AuthAPI: Rate limit check (max 3/hour)
    AuthAPI->>AuthAPI: Phone format validation
    AuthAPI->>SMS: Generate secure OTP (6 digits)
    SMS->>Client: SMS delivery

    Client->>AuthAPI: 2. OTP verification
    AuthAPI->>AuthAPI: Rate limit check (max 5 attempts)
    AuthAPI->>AuthAPI: OTP expiry check (5 minutes)
    AuthAPI->>AuthAPI: Validate OTP code
    AuthAPI->>AuthAPI: Generate JWT token (RS256)
    AuthAPI->>Client: JWT with expiry (1 hour)

    Client->>AuthAPI: 3. Matrix token exchange
    AuthAPI->>AuthAPI: Validate JWT signature
    AuthAPI->>AuthAPI: Check JWT expiry
    AuthAPI->>AuthAPI: Verify phone number claim
    AuthAPI->>MatrixHS: Create/login Matrix user
    MatrixHS->>AuthAPI: Matrix access token + device
    AuthAPI->>Client: Matrix credentials

    Client->>Client: 4. Secure storage
    Client->>Client: Store tokens in keychain/keystore
    Client->>MatrixHS: Initialize secure connection
    MatrixHS->>Client: E2E encryption setup
```

## 🔄 State Transition Diagram

```mermaid
stateDiagram-v2
    [*] --> AppLaunch

    AppLaunch --> CheckingAuth: App starts
    CheckingAuth --> Authenticated: Valid session found
    CheckingAuth --> Unauthenticated: No valid session

    Unauthenticated --> PhoneInput: Show login screen
    PhoneInput --> RequestingOTP: User submits phone
    RequestingOTP --> PhoneInput: Request failed
    RequestingOTP --> OTPPending: OTP sent successfully

    OTPPending --> OTPInput: Show OTP screen
    OTPInput --> VerifyingOTP: User submits OTP
    VerifyingOTP --> OTPInput: Invalid OTP
    VerifyingOTP --> ExchangingToken: Valid OTP

    ExchangingToken --> OTPInput: Exchange failed
    ExchangingToken --> InitializingMatrix: Token received

    InitializingMatrix --> ExchangingToken: Init failed
    InitializingMatrix --> SavingState: Client ready

    SavingState --> Authenticated: State saved

    Authenticated --> Syncing: Start Matrix sync
    Syncing --> Ready: Sync complete
    Ready --> [*]: App running

    Ready --> Unauthenticated: Logout
    Ready --> CheckingAuth: App restart

    state RequestingOTP {
        [*] --> ValidatingPhone
        ValidatingPhone --> SendingRequest
        SendingRequest --> [*]
    }

    state VerifyingOTP {
        [*] --> ValidatingCode
        ValidatingCode --> CheckingRateLimit
        CheckingRateLimit --> AuthenticatingUser
        AuthenticatingUser --> [*]
    }

    state InitializingMatrix {
        [*] --> CreatingClient
        CreatingClient --> ConnectingHomeserver
        ConnectingHomeserver --> VerifyingSession
        VerifyingSession --> [*]
    }
```

## ❌ Error Handling Flow

```mermaid
flowchart TD
    A[Error Occurs] --> B{Error Type?}

    B -->|Network Error| C[Check Connectivity]
    B -->|Authentication Error| D[Check Credentials]
    B -->|Matrix Error| E[Check Homeserver]
    B -->|Validation Error| F[Show User Feedback]
    B -->|Unknown Error| G[Log and Report]

    C --> H{Connection Available?}
    H -->|Yes| I[Retry Request]
    H -->|No| J[Show Offline Message]

    D --> K{Token Expired?}
    K -->|Yes| L[Redirect to Login]
    K -->|No| M[Show Auth Error]

    E --> N{Homeserver Reachable?}
    N -->|Yes| O[Check Client State]
    N -->|No| P[Try Fallback Server]

    F --> Q[Validate Input Again]
    G --> R[Send Error Report]

    I --> S{Retry Successful?}
    S -->|Yes| T[Continue Flow]
    S -->|No| U[Show Persistent Error]

    J --> V[Enable Offline Mode]
    L --> W[Clear Auth State]
    M --> X[Offer Retry Option]
    O --> Y[Reinitialize Client]
    P --> Z{Fallback Works?}
    Z -->|Yes| AA[Update Config]
    Z -->|No| BB[Show Server Error]

    Q --> CC[Re-submit Form]
    R --> DD[Show Generic Error]

    U --> EE[Log Error Details]
    V --> FF[Cache for Later Sync]
    W --> GG[Return to Login]
    X --> HH[Allow Manual Retry]
    Y --> II[Resume Operations]
    AA --> JJ[Continue with Fallback]
    BB --> KK[Contact Support Option]
    CC --> LL[Validate and Process]
    DD --> MM[Offer Help/Support]
```

## 🔄 Retry Logic Flow

```mermaid
sequenceDiagram
    participant Client
    participant RetryManager
    participant API
    participant UI

    Client->>RetryManager: Request with retry config
    RetryManager->>API: Initial request
    API->>RetryManager: Error response

    loop Retry Attempts
        RetryManager->>RetryManager: Calculate backoff delay
        RetryManager->>UI: Show retry indicator
        RetryManager->>RetryManager: Wait (exponential backoff)
        RetryManager->>API: Retry request

        alt Success
            API->>RetryManager: Success response
            RetryManager->>Client: Return success
            RetryManager->>UI: Hide retry indicator
        else Retryable Error
            API->>RetryManager: Retryable error
            Note over RetryManager: Continue retry loop
        else Non-retryable Error
            API->>RetryManager: Fatal error
            RetryManager->>Client: Return error
            RetryManager->>UI: Show error message
            break
        end
    end

    RetryManager->>Client: Max retries exceeded
    RetryManager->>UI: Show final error
```

## 📊 Performance Monitoring Flow

```mermaid
flowchart TD
    A[User Action] --> B[Start Performance Timer]
    B --> C[Execute Operation]
    C --> D[Record Metrics]

    D --> E{Operation Type?}
    E -->|Network Request| F[Log Request Time]
    E -->|UI Render| G[Log Render Time]
    E -->|Database Operation| H[Log Query Time]
    E -->|Authentication| I[Log Auth Flow Time]

    F --> J[Check Network Thresholds]
    G --> K[Check UI Performance]
    H --> L[Check DB Performance]
    I --> M[Check Auth Performance]

    J --> N{Exceeds Threshold?}
    K --> N
    L --> N
    M --> N

    N -->|Yes| O[Log Performance Warning]
    N -->|No| P[Normal Operation]

    O --> Q[Send Analytics Event]
    P --> R[Continue Operation]

    Q --> S[Store Metrics for Analysis]
    R --> T[End Performance Timer]
    S --> T

    T --> U[Metrics Dashboard Update]
```

## 🔧 Development Flow

```mermaid
flowchart LR
    A[Development] --> B{Environment?}

    B -->|Development| C[Use Dev OTP]
    B -->|Staging| D[Use Real SMS]
    B -->|Production| E[Full Security]

    C --> F[Auto-fill OTP: 123456]
    D --> G[Test SMS Provider]
    E --> H[Production SMS Provider]

    F --> I[Mock Backend Responses]
    G --> J[Staging Backend]
    H --> K[Production Backend]

    I --> L[Local Matrix Homeserver]
    J --> M[Staging Matrix Server]
    K --> N[Production Matrix Server]

    L --> O[Debug Logging Enabled]
    M --> P[Limited Logging]
    N --> Q[Production Logging]

    O --> R[Development Features]
    P --> S[Testing Features]
    Q --> T[Production Features]

    R --> U[Hot Reload Support]
    S --> V[Integration Testing]
    T --> W[Performance Monitoring]
```

## 📱 Multi-Platform Considerations

```mermaid
flowchart TD
    A[Platform Detection] --> B{Platform Type?}

    B -->|Android| C[Android Specific Setup]
    B -->|iOS| D[iOS Specific Setup]
    B -->|Web| E[Web Specific Setup]
    B -->|Desktop| F[Desktop Specific Setup]

    C --> G[Android Keystore]
    C --> H[Firebase Messaging]
    C --> I[Android Auto-fill]

    D --> J[iOS Keychain]
    D --> K[APNs Integration]
    D --> L[iOS Auto-fill]

    E --> M[LocalStorage Fallback]
    E --> N[Web Push API]
    E --> O[CORS Handling]

    F --> P[Desktop Secure Storage]
    F --> Q[Desktop Notifications]
    F --> R[Multi-window Support]

    G --> S[Common Auth Flow]
    H --> S
    I --> S
    J --> S
    K --> S
    L --> S
    M --> S
    N --> S
    O --> S
    P --> S
    Q --> S
    R --> S

    S --> T[Matrix Client Initialization]
    T --> U[Platform-Optimized UI]
```

These diagrams provide a comprehensive visual representation of the authentication flow, helping developers understand the system architecture and implement the solution correctly.