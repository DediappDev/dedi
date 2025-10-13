# DEDI Chat → dedim.com.tr: Unified Implementation Guide

**🎉 PROJECT COMPLETED - All 3 Stages Successfully Implemented (October 9, 2025)**

**Complete implementation guide consolidating all documentation for native phone OTP authentication and dedim.com.tr migration.**

**🔄 NEXT PHASE: DEDI Rebranding - Testflight branding first, then comprehensive refactoring**

## ✅ ACHIEVEMENT SUMMARY

**All core objectives have been successfully completed:**
- ✅ **Stage 1**: Domain centralization to `*.dedim.com.tr`
- ✅ **Stage 2**: Native login flow with 4 screens implemented
- ✅ **Stage 3**: SMS provider refactor (Octopush → MultiProvider)

**See `docs/MIGRATION_ACHIEVEMENTS.md` for detailed achievement record.**

**Locations:**
- Backend: `/Users/liberyus/development/dedi-server` (ToM-server)
- Frontend: `/Users/liberyus/development/dedi` (Flutter client)

---

## Table of Contents
1. [Current System Analysis](#1-current-system-analysis)
2. [Domain Migration Strategy](#2-domain-migration-strategy)
3. [OTP Implementation Strategy](#3-otp-implementation-strategy)
4. [Multi-Provider SMS Strategy](#4-multi-provider-sms-strategy)
5. [API Endpoint Specifications](#5-api-endpoint-specifications)
6. [Session Management](#6-session-management)
7. [Flutter Client Implementation](#7-flutter-client-implementation)
8. [Push Notification Migration](#8-push-notification-migration)
9. [Testing & Deployment](#9-testing--deployment)
10. [Implementation Checklist](#10-implementation-checklist)

---

## 1. Current System Analysis

### Backend Infrastructure

**ToM-server Monorepo (12 packages):**
```
packages/
├── matrix-identity-server/     # Has SMS infra (Octopush currently)
├── matrix-client-server/       # Client-Server API
├── tom-server/                 # Main orchestration
├── matrix-invite/              # Invitation web UI
└── ... (8 more utility packages)
```

**Current State:**
- ✅ Matrix Identity v2 API endpoints exist
- ✅ SMS infrastructure present (Octopush)
- ❌ NO simplified `/otp/*` endpoints for mobile
- ❌ NO multi-provider SMS fallback

### Frontend Infrastructure

**Current Flow:**
```
Login → WebView (sign-up.twake.app) → SSO → Matrix token → Rooms
```

**Target Flow:**
```
Splash → [Onboarding?] → Phone Input → OTP Verify → Matrix Init → Rooms
```

---

## 2. Domain Migration Strategy

### Migration Map

| Service | Current | Target |
|---------|---------|--------|
| Matrix homeserver | matrix.twake.app | matrix.dedim.com.tr |
| Identity server | identity.twake.app | identity.dedim.com.tr |
| Push gateway | push.twake.app | notification.dedim.com.tr |
| Registration | sign-up.twake.app | sign-up.dedim.com.tr |

**Implementation:**
1. Update all configs to use dedim.com.tr
2. Add CI validation (grep for twake.app)
3. Configure DNS and SSL

---

## 3. OTP Implementation Strategy

### Plan B: Thin Glue Layer

**Why:**
- Matrix Identity v2 too complex for mobile
- Multiple round trips required
- No JWT session management

**Solution:**
Create `packages/msisdn-auth/` with 3 endpoints:
- POST `/otp/request` - Send OTP
- POST `/otp/verify` - Verify OTP, return JWT
- POST `/otp/matrix-token` - Exchange JWT for Matrix token

---

## 4. Multi-Provider SMS Strategy

### Provider Priority

```bash
SMS_PROVIDERS=turkcell,netgsm,iletimerkezi,twilio
```

**Providers:**
1. **Turkcell MesajÜssü v2** (Primary)
2. **NetGSM** (Secondary)
3. **İletiMerkezi** (Tertiary)
4. **Twilio** (International fallback)

**Fallback Logic:**
- Try providers in priority order
- Only fallback on transient errors (503, timeout)
- Permanent errors (invalid credentials) stop immediately

---

## 5. API Endpoint Specifications

### POST /otp/request

**Request:**
```json
{
  "phone": "+905551234567"
}
```

**Response (200):**
```json
{
  "status": "sent",
  "expires_in": 300,
  "dev_otp": "123456"  // Development only
}
```

**Errors:**
- 400: Invalid phone format
- 429: Rate limited (3/hour)
- 500: SMS provider error

---

### POST /otp/verify

**Request:**
```json
{
  "phone": "+905551234567",
  "code": "123456"
}
```

**Response (200):**
```json
{
  "access_token": "eyJhbGc...",  // JWT (15 min)
  "token_type": "Bearer",
  "expires_in": 900,
  "user_id": "@905551234567:dedim.com.tr",
  "mxid": "@905551234567:dedim.com.tr",
  "phone": "+905551234567",
  "created_at": "2025-10-06T12:00:00Z"
}
```

**Errors:**
- 400: Invalid/expired OTP
- 429: Too many attempts (3 max)

---

### POST /otp/matrix-token

**Request:**
```json
{
  "jwt_token": "eyJhbGc...",
  "phone": "+905551234567"
}
```

**Headers:**
```
Authorization: Bearer eyJhbGc...
```

**Response (200):**
```json
{
  "access_token": "syt_...",  // Matrix token
  "user_id": "@905551234567:dedim.com.tr",
  "mxid": "@905551234567:dedim.com.tr",
  "device_id": "DEDIANDROID123",
  "device_name": "Dedi Mobile",
  "homeserver": "https://matrix.dedim.com.tr",
  "expires_in": null
}
```

---

## 6. Session Management

### OTP Session (Redis)

**Structure:**
```typescript
interface OTPSession {
  id: string;              // UUID
  phone: string;           // E.164
  otp: string;             // 6 digits
  expires_at: number;      // Unix timestamp
  attempts: number;        // Failed attempts (max 3)
  validated: boolean;
  created_at: number;
}
```

**Storage:**
- Key: `otp:session:{phone}`
- TTL: 5 minutes
- Auto-cleanup on expiry

### JWT Token (Client In-Memory)

**Structure:**
```json
{
  "phone": "+905551234567",
  "mxid": "@905551234567:dedim.com.tr",
  "session_id": "uuid",
  "iat": 1234567890,
  "exp": 1234568790  // 15 min
}
```

**Lifecycle:**
- Generated after OTP verification
- Stored client-side in memory only
- Used once for Matrix token exchange
- Server validates via JWT signature (stateless)

### Matrix Access Token (Matrix SDK)

**Handled by Matrix SDK:**
- Storage in Hive (encrypted)
- Automatic refresh
- Device management
- Session persistence

---

## 7. Flutter Client Implementation

### Application Startup Flow

**Entry Point: `lib/main.dart`**

The Flutter application follows a structured 8-step startup process:

```dart
void main() async {
  // 8-step initialization process
}
```

**Startup Sequence:**

1. **Flutter Binding Initialization**
   ```dart
   WidgetsFlutterBinding.ensureInitialized();
   ```
   - Required for background push notifications
   - Initializes Flutter's internal components early

2. **Platform Configuration**
   ```dart
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
   MediaKit.ensureInitialized();
   GoRouter.optionURLReflectsImperativeAPIs = true;
   ```
   - Portrait-only orientation
   - Media kit for video/audio playback
   - GoRouter URL reflection settings

3. **Database Initialization (Hive)**
   ```dart
   if (PlatformInfos.isLinux) {
     Hive.init((await getApplicationSupportDirectory()).path);
   } else {
     await Hive.initFlutter();
   }
   ```
   - Linux: Custom directory path
   - Other platforms: Flutter default directory

4. **Dependency Injection Setup**
   ```dart
   GetItInitializer().setUp();
   ```
   - Central service registration system
   - All dependencies and services registered here

5. **Matrix Client Loading**
   ```dart
   final clients = await ClientManager.getClients();
   final firstClient = clients.firstOrNull;
   firstClient?.isSupportDeleteCollections = !PlatformInfos.isWeb;
   await firstClient?.roomsLoading;
   await firstClient?.accountDataLoading;
   ```
   - Load registered Matrix clients
   - Preload first client for performance
   - Enable collection deletion (except web)
   - Load rooms and account data

6. **Background/Foreground Mode Detection**
   ```dart
   if (PlatformInfos.isAndroid && 
       AppLifecycleState.detached == WidgetsBinding.instance.lifecycleState) {
     // Background mode: Only process push notifications
     BackgroundPush.clientOnly(clients.first);
     WidgetsBinding.instance.addObserver(AppStarter(clients));
     return; // No GUI startup
   }
   ```
   - Android background mode: Push notification processing only
   - Foreground mode: Full GUI startup

7. **Web Platform Configuration**
   ```dart
   if (PlatformInfos.isWeb) {
     CozyConfigManager().injectCozyScript(AppConfig.cozyExternalBridgeVersion);
   }
   ```
   - Web-specific Cozy script injection

8. **GUI Startup**
   ```dart
   await startGui(clients);
   ```
   - Calls `startGui()` function to initialize the user interface

**GUI Startup Process (`startGui()` function):**

```dart
Future<void> startGui(List<Client> clients) async {
  // 1. App Lock PIN Check (Mobile only)
  String? pin;
  if (PlatformInfos.isMobile) {
    pin = await const FlutterSecureStorage().read(key: SettingKeys.appLockKey);
  }

  // 2. Application Launch
  runApp(
    PlatformInfos.isMobile
        ? AppLock(
            builder: (args) => TwakeApp(clients: clients),
            lockScreen: const LockScreen(),
            enabled: pin?.isNotEmpty ?? false,
          )
        : TwakeApp(clients: clients),
  );
}
```

**Two Launch Paths:**
- **Mobile + App Lock:** `AppLock` → `TwakeApp`
- **Other Cases:** Direct `TwakeApp`

**Background Mode Handler (`AppStarter` class):**

```dart
class AppStarter with WidgetsBindingObserver {
  // Monitors Android background-to-foreground transitions
  // Starts GUI when app is no longer detached
  // Ensures GUI starts only once (guiStarted flag)
}
```

**Application Flow Diagram:**

```
main() 
├── Flutter bindings initialization
├── Platform configuration
├── Hive database initialization
├── GetIt dependency injection setup
├── Matrix clients loading & preparation
├── Background/Foreground mode detection
│   ├── Background mode → BackgroundPush + AppStarter
│   └── Foreground mode → startGui()
├── Web platform configuration (if web)
└── startGui()
    ├── App lock PIN check (mobile)
    └── runApp()
        ├── AppLock + TwakeApp (mobile + PIN exists)
        └── TwakeApp (other cases)
```

### Dependencies

```yaml
dependencies:
  # Phone validation
  libphonenumber: ^2.0.2
  
  # OTP input
  pin_code_text_field: ^1.8.0
  
  # Optional: SMS auto-read
  # sms_autofill: ^2.3.0
```

### Phone Input Screen

```dart
// lib/pages/phone_auth/phone_input_page.dart
class PhoneInputPage extends StatefulWidget {
  @override
  _PhoneInputPageState createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  
  Future<void> _sendOTP() async {
    setState(() => _isLoading = true);
    
    try {
      final phone = _phoneController.text.replaceAll(' ', '');
      
      final response = await http.post(
        Uri.parse('${AppConfig.homeserver}/otp/request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        context.push('/otp-verify', extra: {
          'phone': phone,
          'dev_otp': data['dev_otp'],
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Telefon Numarası',
                hintText: '+90 5XX XXX XX XX',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendOTP,
              child: Text('Kod Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### OTP Verification Screen

```dart
// lib/pages/phone_auth/otp_verification_page.dart
class OTPVerificationPage extends StatefulWidget {
  final String phone;
  final String? devOTP;
  
  const OTPVerificationPage({
    required this.phone,
    this.devOTP,
  });
  
  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _otpController = TextEditingController();
  bool _isVerifying = false;
  
  Future<void> _verifyOTP() async {
    setState(() => _isVerifying = true);
    
    try {
      // 1. Verify OTP
      final verifyResponse = await http.post(
        Uri.parse('${AppConfig.homeserver}/otp/verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': widget.phone,
          'code': _otpController.text,
        }),
      );
      
      final verifyData = jsonDecode(verifyResponse.body);
      final jwtToken = verifyData['access_token'];
      
      // 2. Exchange for Matrix token
      final matrixResponse = await http.post(
        Uri.parse('${AppConfig.homeserver}/otp/matrix-token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          'jwt_token': jwtToken,
          'phone': widget.phone,
        }),
      );
      
      final matrixData = jsonDecode(matrixResponse.body);
      
      // 3. Initialize Matrix client
      await Matrix.of(context).client.init(
        newToken: matrixData['access_token'],
        newUserID: matrixData['user_id'],
        newDeviceID: matrixData['device_id'],
        newHomeserver: Uri.parse(matrixData['homeserver']),
      );
      
      // 4. Navigate to rooms
      context.go('/rooms');
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Doğrulama hatası: $e')),
      );
    } finally {
      setState(() => _isVerifying = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doğrulama Kodu')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.phone} numarasına gönderilen kodu girin'),
            SizedBox(height: 24),
            PinCodeTextField(
              controller: _otpController,
              pinBoxWidth: 50,
              pinBoxHeight: 60,
              maxLength: 6,
              onDone: (_) => _verifyOTP(),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isVerifying ? null : _verifyOTP,
              child: Text('Doğrula'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 8. Push Notification Migration

### Current: Firebase push gateway + legacy push.twake.app integration

### Target: Matrix Push Gateway (Sygnal) hosted at `notification.dedim.com.tr`

**Sygnal Deployment (Docker example):**
```bash
docker run -d \
  --name sygnal \
  -p 5000:5000 \
  -v $(pwd)/sygnal.yaml:/etc/sygnal.yaml:ro \
  matrixdotorg/sygnal:latest
```

**Minimal `sygnal.yaml`:**
```yaml
server:
  listen: 0.0.0.0
  port: 5000

apps:
  com.dedi.flutter:
    type: fcm
    api_key: YOUR_FCM_SERVER_KEY
    platform_application_id: dedi-chat
    trusted_senders:
      - https://matrix.dedim.com.tr
```

**Expose the Matrix push endpoint:** terminate TLS (nginx/ingress) at `https://notification.dedim.com.tr/_matrix/push/v1/notify` and proxy to Sygnal's `/notify` on port 5000.

**Synapse configuration (`homeserver.yaml`):**
```yaml
push:
  enabled: true
  include_content: true
  gateways:
    - app_name: com.dedi.flutter
      type: http
      url: https://notification.dedim.com.tr/_matrix/push/v1/notify
      data:
        format: event_id_only
```

**Flutter Client Updates:** keep `AppConfig.pushNotificationsGatewayUrl` pointing at the Sygnal endpoint, ensure FCM/APNs credentials are valid, and preserve UnifiedPush as a fallback for non-Google builds.

---

## 9. Testing & Deployment

### Backend Testing

```bash
# Start ToM-server
cd dedi-server
npm install
npm run build
npm start

# Test OTP request
curl -X POST http://localhost:8090/otp/request \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567"}'

# Test OTP verify
curl -X POST http://localhost:8090/otp/verify \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567", "code": "123456"}'
```

### Frontend Testing

```bash
# Run Flutter app
cd dedi
flutter pub get
flutter run -d chrome

# Test flow:
# 1. Enter phone number
# 2. Receive OTP (check dev_otp in response)
# 3. Enter OTP
# 4. Verify navigation to rooms
```

### Environment Setup

**Backend `.env`:**
```bash
# Redis
REDIS_URL=redis://localhost:6379

# SMS Providers
SMS_PROVIDERS=turkcell,netgsm,twilio
TURKCELL_API_KEY=your_key
TURKCELL_SENDER_ID=DEDI
NETGSM_USER=your_username
NETGSM_PASSWORD=your_password
TWILIO_ACCOUNT_SID=your_sid
TWILIO_AUTH_TOKEN=your_token

# JWT
JWT_SECRET=your_secret_key

# Matrix
HOMESERVER_URL=https://matrix.dedim.com.tr
SYNAPSE_ADMIN_TOKEN=your_admin_token
```

**Frontend `config.json`:**
```json
{
  "homeserver": "https://matrix.dedim.com.tr",
  "default_homeserver": "matrix.dedim.com.tr",
  "push_gateway": "https://notification.dedim.com.tr"
}
```

---

## 10. Implementation Checklist ✅ COMPLETED

### Phase 1: Backend Foundation ✅ COMPLETED
- [x] Create `packages/msisdn-auth/` structure
- [x] Implement OTPGenerator utility
- [x] Implement SessionManager (Mock for development)
- [x] Implement POST /otp/request endpoint
- [x] Implement POST /otp/verify endpoint
- [x] Implement POST /otp/matrix-token endpoint
- [x] Add rate limiting middleware
- [x] Setup development backend

### Phase 2: Multi-Provider SMS ✅ COMPLETED
- [x] Remove Octopush from matrix-identity-server
- [x] Create SMSProvider interface
- [x] Implement TurkcellProvider (MesajÜssü v2)
- [x] Implement NetGSMProvider
- [x] Implement IletiMerkeziProvider
- [x] Implement TwilioProvider
- [x] Create MultiProviderSMS orchestrator
- [x] Add provider configuration
- [x] Implement TurkTelekomProvider (scaffold)

### Phase 3: Flutter Client ✅ COMPLETED
- [x] Remove WebView login code
- [x] Create phone_input_page.dart
- [x] Create otp_verification_page.dart
- [x] Create splash_screen.dart
- [x] Create onboarding_screen.dart
- [x] Implement phone validation
- [x] Implement OTP API calls
- [x] Implement Matrix token exchange
- [x] Update navigation routes
- [x] Add error handling
- [x] Add SharedPreferences persistence

### Phase 4: Domain Migration ✅ COMPLETED
- [x] Update all config files to dedim.com.tr
- [x] Update client environment configuration
- [x] Update server domain references
- [x] Add CI validation for domain names
- [x] Update documentation

### Phase 5: Push Notifications (OPTIONAL)
- [ ] Deploy Sygnal push gateway
- [ ] Update push gateway URL to Sygnal endpoint
- [ ] Audit/remove Firebase-only push dependencies once Sygnal path is stable
- [ ] Implement Sygnal-backed client push integration
- [ ] Test push notifications

### Phase 6: Testing & Polish ✅ COMPLETED
- [x] Write backend mock endpoints
- [x] Write integration structure
- [x] Test SMS provider abstraction
- [x] Test OTP flow end-to-end (mock)
- [x] Test Matrix integration
- [x] Test client navigation flow
- [x] Documentation update
- [x] Comprehensive achievement recording

### Phase 7: Deployment ✅ READY
- [x] Package structure ready for production
- [x] Environment-based configuration
- [x] Docker compose updated
- [x] CI validation in place
- [x] Comprehensive documentation
- [x] Error handling and logging

---

## Repository Information

### ToM-server (48+ packages ecosystem)

**Core Projects:**
1. twake-on-matrix - Flutter client
2. ToM-server - Backend (12 internal packages)

**Internal Packages:**
- @twake/matrix-identity-server
- @twake/matrix-client-server
- @twake/tom-server
- @twake/matrix-invite
- +8 more utility packages

**Client Libraries (14+):**
- matrix-dart-sdk
- flutter_openssl_crypto
- linagora-design-flutter
- +11 more packages

---

## Key Technical Decisions

### 1. Why Thin Glue Layer?
- Matrix Identity v2 too complex for mobile
- Need JWT session management
- Simplify mobile integration

### 2. Why Multi-Provider SMS?
- Reliability through redundancy
- Cost optimization
- Support Turkish and international numbers

### 3. Why JWT Tokens?
- Stateless server-side validation
- Short-lived (15 min)
- Single-use for Matrix exchange

### 4. Why Redis for Sessions?
- Built-in TTL support
- Fast in-memory operations
- Simple key-value structure

### 5. Why Remove WebView?
- Better UX (native UI)
- Faster performance
- Better accessibility
- Platform consistency

---

## Security Considerations

### Rate Limiting
- OTP request: 3 per phone per hour
- OTP verify: 3 attempts per session
- Matrix token: 10 per JWT per minute

### OTP Security
- 6-digit cryptographically random
- 5-minute expiration
- Single-use only
- Phone validation (E.164)

### JWT Security
- HS256/RS256 signing
- 15-minute expiration
- Phone number in claims
- Stateless validation

### SMS Security
- TLS for API calls
- Secure credential storage
- Provider failover
- Message templates

---

## Troubleshooting

### Common Issues

**OTP not received:**
- Check SMS provider status
- Verify phone number format
- Check provider credentials
- Review rate limiting

**JWT validation failed:**
- Check JWT_SECRET matches
- Verify token not expired
- Check phone number matches

**Matrix init failed:**
- Verify homeserver URL
- Check Synapse admin token
- Ensure user created successfully

**Redis connection error:**
- Verify REDIS_URL correct
- Check Redis server running
- Review network/firewall

---

## Documentation References

- Matrix Identity Service API v2: https://spec.matrix.org/v1.11/identity-service-api/
- Matrix Client-Server API: https://spec.matrix.org/v1.11/client-server-api/
- ToM-server Docs: https://linagora.github.io/ToM-server/
- Ecosystem Research: See original docs for 48+ repository details

---

## Contact & Support

**Project Locations:**
- Backend: `/Users/liberyus/development/dedi-server`
- Frontend: `/Users/liberyus/development/dedi`
- Docs: `/Users/liberyus/development/dedi/docs/`

**Key Files:**
- Implementation Plan: `IMPLEMENTATION_PLAN.md`
- This Guide: `UNIFIED_IMPLEMENTATION_GUIDE.md`

---

*Last Updated: October 2025*
*Consolidates: COMPLETE PHONE AUTH GUIDE, GÖREV, STATUS UPDATE, and Ecosystem Research*
