
```markdown
# COMPLETE PHONE AUTH IMPLEMENTATION GUIDE FOR TWAKE CHAT
## From Scratch: ToM-Server Backend + Flutter Native Client
For detailed information
(/Users/liberyus/development/dedi/docs/Twake Chat ve ToM-server Ekosistem Araştırması.md)

ToM-server is in the following directory:
(/Users/liberyus/development/dedi-server)
(github.com/linagora/ToM-server)

Dedi is (Twake Chat) in the following directory:
(/Users/liberyus/development/dedi)
(github.com/linagora/twake-on-matrix)

## EXECUTIVE SUMMARY

You are CORRECT - phone/MSISDN authentication **DOES NOT EXIST** in current ToM-server 
public repository. The current implementation only has:
- ✅ Generic SMS sender for authenticated users (POST /_twake/sms)
- ✅ 3PID binding/lookup for already-registered users
- ❌ NO unauthenticated OTP request/verify endpoints
- ❌ NO MSISDN-based initial authentication flow

We need to BUILD IT FROM SCRATCH. Here's the complete implementation plan:

---

## PART 1: BACKEND IMPLEMENTATION (ToM-Server)

### 1.1 NEW PACKAGE: @twake/msisdn-auth

Create a new package in ToM-server for phone authentication:
(/Users/liberyus/development/dedi-server)
```
ToM-server/
└── packages/
    └── msisdn-auth/           # NEW PACKAGE
        ├── package.json
        ├── tsconfig.json
        ├── src/
        │   ├── index.ts
        │   ├── routes.ts      # Express router with endpoints
        │   ├── controllers/
        │   │   ├── requestOTP.ts
        │   │   ├── verifyOTP.ts
        │   │   ├── phoneLogin.ts
        │   │   └── bindPhone.ts
        │   ├── services/
        │   │   ├── SMSService.ts        # SMS provider abstraction
        │   │   ├── OTPGenerator.ts      # OTP generation logic
        │   │   └── SessionManager.ts    # OTP session storage
        │   ├── models/
        │   │   ├── OTPSession.ts        # Session data structure
        │   │   └── PhoneUser.ts         # Phone-to-Matrix-ID mapping
        │   └── validators/
        │       └── phoneNumber.ts       # E.164 phone validation
        └── README.md
```

### 1.2 ENDPOINT SPECIFICATIONS

Implement these 4 endpoints in `packages/msisdn-auth/src/routes.ts`:

#### Endpoint 1: Request OTP
```typescript
/**
 * POST /_twake/auth/phone/request
 * Request OTP code for phone number
 * PUBLIC ENDPOINT (no auth required)
 */

// Request Schema
interface RequestOTPRequest {
  phone_number: string;      // E.164 format: "+905551234567"
  country_code?: string;     // Optional: "TR", "US", etc.
  client_secret: string;     // Client-generated UUID for session
  send_attempt?: number;     // Default: 1
}

// Response Schema
interface RequestOTPResponse {
  sid: string;              // Session ID (UUID)
  expires_at: number;       // Unix timestamp (current + 5 minutes)
  send_attempt: number;     // Echo back
}

// Implementation in packages/msisdn-auth/src/controllers/requestOTP.ts
export async function requestOTP(req: Request, res: Response) {
  const { phone_number, client_secret, send_attempt = 1 } = req.body;
  
  // 1. Validate phone number (E.164 format)
  if (!isValidE164(phone_number)) {
    return res.status(400).json({ 
      errcode: 'M_INVALID_PARAM',
      error: 'Invalid phone number format. Use E.164: +[country][number]'
    });
  }
  
  // 2. Rate limiting (max 3 attempts per phone per hour)
  const attempts = await rateLimiter.checkPhone(phone_number);
  if (attempts >= 3) {
    return res.status(429).json({
      errcode: 'M_LIMIT_EXCEEDED',
      error: 'Too many requests. Try again in 1 hour.',
      retry_after_ms: 3600000
    });
  }
  
  // 3. Generate OTP (6 digits)
  const otp = OTPGenerator.generate(); // "123456"
  
  // 4. Create session
  const sid = uuidv4();
  const expiresAt = Date.now() + (5 * 60 * 1000); // 5 minutes
  
  await SessionManager.create({
    sid,
    phone_number,
    client_secret,
    otp,
    expires_at: expiresAt,
    attempts: 0,
    validated: false
  });
  
  // 5. Send SMS via provider
  try {
    await SMSService.send(phone_number, `Your Twake Chat code: ${otp}`);
  } catch (error) {
    logger.error('SMS send failed:', error);
    return res.status(500).json({
      errcode: 'M_UNKNOWN',
      error: 'Failed to send SMS. Please try again.'
    });
  }
  
  // 6. Return session ID
  return res.status(200).json({
    sid,
    expires_at: expiresAt,
    send_attempt
  });
}
```

#### Endpoint 2: Verify OTP
```typescript
/**
 * POST /_twake/auth/phone/verify
 * Verify OTP code
 * PUBLIC ENDPOINT
 */

interface VerifyOTPRequest {
  sid: string;              // Session ID from request step
  client_secret: string;    // Must match request
  token: string;            // OTP code from SMS
}

interface VerifyOTPResponse {
  success: boolean;
  validated_at?: number;    // Unix timestamp
  validation_token?: string; // Token for login exchange
}

export async function verifyOTP(req: Request, res: Response) {
  const { sid, client_secret, token } = req.body;
  
  // 1. Retrieve session
  const session = await SessionManager.get(sid);
  
  if (!session) {
    return res.status(404).json({
      errcode: 'M_SESSION_NOT_FOUND',
      error: 'Invalid or expired session'
    });
  }
  
  // 2. Validate client_secret
  if (session.client_secret !== client_secret) {
    return res.status(403).json({
      errcode: 'M_FORBIDDEN',
      error: 'Client secret mismatch'
    });
  }
  
  // 3. Check expiration
  if (Date.now() > session.expires_at) {
    await SessionManager.delete(sid);
    return res.status(401).json({
      errcode: 'M_SESSION_EXPIRED',
      error: 'OTP expired. Request a new code.'
    });
  }
  
  // 4. Check attempts (max 3)
  if (session.attempts >= 3) {
    await SessionManager.delete(sid);
    return res.status(429).json({
      errcode: 'M_LIMIT_EXCEEDED',
      error: 'Too many failed attempts. Request a new code.'
    });
  }
  
  // 5. Verify OTP
  if (session.otp !== token) {
    await SessionManager.incrementAttempts(sid);
    return res.status(401).json({
      errcode: 'M_INVALID_TOKEN',
      error: 'Invalid verification code',
      attempts_remaining: 3 - (session.attempts + 1)
    });
  }
  
  // 6. Mark as validated
  const validatedAt = Date.now();
  const validationToken = uuidv4(); // Token for login exchange
  
  await SessionManager.update(sid, {
    validated: true,
    validated_at: validatedAt,
    validation_token: validationToken
  });
  
  return res.status(200).json({
    success: true,
    validated_at: validatedAt,
    validation_token: validationToken
  });
}
```

#### Endpoint 3: Exchange for Matrix Access Token
```typescript
/**
 * POST /_twake/auth/phone/login
 * Exchange validated phone for Matrix access token
 * PUBLIC ENDPOINT
 */

interface PhoneLoginRequest {
  sid: string;              // Session ID
  validation_token: string; // From verify response
  device_display_name?: string;
}

interface PhoneLoginResponse {
  user_id: string;          // "@+905551234567:twake.app"
  access_token: string;     // Matrix access token
  device_id: string;        // Device ID
  home_server: string;      // "twake.app"
  well_known?: object;      // .well-known/matrix/client
}

export async function phoneLogin(req: Request, res: Response) {
  const { sid, validation_token, device_display_name } = req.body;
  
  // 1. Retrieve validated session
  const session = await SessionManager.get(sid);
  
  if (!session || !session.validated) {
    return res.status(401).json({
      errcode: 'M_UNAUTHORIZED',
      error: 'Session not validated. Verify OTP first.'
    });
  }
  
  if (session.validation_token !== validation_token) {
    return res.status(403).json({
      errcode: 'M_FORBIDDEN',
      error: 'Invalid validation token'
    });
  }
  
  // 2. Create or retrieve Matrix user
  const phoneNumber = session.phone_number;
  let matrixUserId = await db.getMatrixIdByPhone(phoneNumber);
  
  if (!matrixUserId) {
    // Auto-register new user
    // Format: @+905551234567:twake.app (phone as localpart)
    const localpart = phoneNumber.replace('+', '');
    matrixUserId = `@${localpart}:${config.serverName}`;
    
    // Create Matrix account via Synapse Admin API
    const registrationResult = await synapseAdmin.register({
      username: localpart,
      displayname: phoneNumber,
      admin: false
    });
    
    // Store mapping
    await db.linkPhoneToMatrix(phoneNumber, matrixUserId);
  }
  
  // 3. Issue Matrix access token
  const loginResult = await matrixClient.login({
    type: 'm.login.token',
    token: session.validation_token, // Use validation_token as login token
    device_display_name: device_display_name || 'Twake Chat'
  });
  
  // 4. Cleanup session
  await SessionManager.delete(sid);
  
  return res.status(200).json({
    user_id: matrixUserId,
    access_token: loginResult.access_token,
    device_id: loginResult.device_id,
    home_server: config.serverName,
    well_known: {
      'm.homeserver': { base_url: config.homeserverUrl }
    }
  });
}
```

#### Endpoint 4: Check Validation Status (Optional)
```typescript
/**
 * GET /_twake/auth/phone/status/:sid
 * Check if OTP has been validated (for polling)
 */

export async function checkStatus(req: Request, res: Response) {
  const { sid } = req.params;
  const session = await SessionManager.get(sid);
  
  if (!session) {
    return res.status(404).json({ validated: false });
  }
  
  return res.status(200).json({
    validated: session.validated,
    validated_at: session.validated_at,
    expires_at: session.expires_at
  });
}
```

### 1.3 SMS SERVICE IMPLEMENTATION

Create `packages/msisdn-auth/src/services/SMSService.ts`:

```typescript
import twilio from 'twilio';

interface SMSConfig {
  provider: 'twilio' | 'messagebird' | 'vonage';
  apiKey: string;
  apiSecret: string;
  senderId: string;
}

export class SMSService {
  private client: any;
  private config: SMSConfig;
  
  constructor(config: SMSConfig) {
    this.config = config;
    
    // Initialize based on provider
    if (config.provider === 'twilio') {
      this.client = twilio(config.apiKey, config.apiSecret);
    }
    // Add other providers...
  }
  
  async send(phoneNumber: string, message: string): Promise<void> {
    if (this.config.provider === 'twilio') {
      await this.client.messages.create({
        body: message,
        from: this.config.senderId,
        to: phoneNumber
      });
    }
    // Add other providers...
  }
}

// Singleton export
export default new SMSService({
  provider: process.env.SMS_PROVIDER as any,
  apiKey: process.env.SMS_API_KEY!,
  apiSecret: process.env.SMS_API_SECRET!,
  senderId: process.env.SMS_SENDER_ID!
});
```

### 1.4 SESSION MANAGER (Redis/PostgreSQL)

Create `packages/msisdn-auth/src/services/SessionManager.ts`:

```typescript
import { Redis } from 'ioredis';

interface OTPSession {
  sid: string;
  phone_number: string;
  client_secret: string;
  otp: string;
  expires_at: number;
  attempts: number;
  validated: boolean;
  validated_at?: number;
  validation_token?: string;
}

class SessionManager {
  private redis: Redis;
  
  constructor() {
    this.redis = new Redis(process.env.REDIS_URL);
  }
  
  async create(session: OTPSession): Promise<void> {
    const key = `otp:session:${session.sid}`;
    await this.redis.setex(
      key,
      300, // 5 minutes TTL
      JSON.stringify(session)
    );
  }
  
  async get(sid: string): Promise<OTPSession | null> {
    const key = `otp:session:${sid}`;
    const data = await this.redis.get(key);
    return data ? JSON.parse(data) : null;
  }
  
  async update(sid: string, updates: Partial<OTPSession>): Promise<void> {
    const session = await this.get(sid);
    if (!session) throw new Error('Session not found');
    
    const updated = { ...session, ...updates };
    await this.create(updated);
  }
  
  async delete(sid: string): Promise<void> {
    await this.redis.del(`otp:session:${sid}`);
  }
  
  async incrementAttempts(sid: string): Promise<void> {
    const session = await this.get(sid);
    if (session) {
      await this.update(sid, { attempts: session.attempts + 1 });
    }
  }
}

export default new SessionManager();
```

### 1.5 CONFIGURATION

Add to `ToM-server/config/default.json`:

```json
{
  "msisdn_auth": {
    "enabled": true,
    "otp_length": 6,
    "otp_expiry_seconds": 300,
    "max_attempts": 3,
    "rate_limit": {
      "max_requests_per_phone_per_hour": 3,
      "max_requests_per_ip_per_hour": 10
    },
    "sms": {
      "provider": "twilio",
      "api_key": "${SMS_API_KEY}",
      "api_secret": "${SMS_API_SECRET}",
      "sender_id": "${SMS_SENDER_ID}",
      "message_template": "Your Twake Chat verification code: {{otp}}"
    },
    "auto_register": true,
    "username_format": "phone"
  }
}
```

Environment variables in `.env`:
```bash
SMS_PROVIDER=twilio
SMS_API_KEY=your_twilio_account_sid
SMS_API_SECRET=your_twilio_auth_token
SMS_SENDER_ID=+15551234567
REDIS_URL=redis://localhost:6379
```

### 1.6 ROUTER REGISTRATION

Add to `packages/tom-server/src/index.ts`:

```typescript
import msisdnAuthRouter from '@twake/msisdn-auth';

// ... existing code ...

app.use('/_twake/auth/phone', msisdnAuthRouter);
```

---

## PART 2: FLUTTER CLIENT IMPLEMENTATION

### 2.1 REMOVE WEBVIEW, ADD NATIVE PHONE INPUT

Replace in `lib/pages/login/login.dart`:

**BEFORE (current WebView approach):**
```dart
// This is what exists now - DELETE THIS
void _openSignUp() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => WebViewScreen(
        url: 'https://sign-up.twake.app',
      ),
    ),
  );
}
```

**AFTER (new native implementation):**

File: `lib/pages/login/phone_login_page.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> 
    with CodeAutoFill {
  
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  
  String? _sessionId;
  String? _validationToken;
  bool _isRequestingOTP = false;
  bool _isVerifyingOTP = false;
  bool _otpSent = false;
  
  @override
  void initState() {
    super.initState();
    // Listen for SMS auto-fill
    listenForCode();
  }
  
  @override
  void dispose() {
    cancel();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }
  
  // SMS auto-fill callback
  @override
  void codeUpdated() {
    setState(() {
      _otpController.text = code ?? '';
    });
    // Auto-verify when code filled
    if (code?.length == 6) {
      _verifyOTP();
    }
  }
  
  Future<void> _requestOTP() async {
    setState(() => _isRequestingOTP = true);
    
    try {
      final phoneNumber = _phoneController.text;
      
      // Validate phone number format
      final plugin = PhoneNumberUtil();
      final parsed = await plugin.parse(phoneNumber);
      final e164 = await plugin.format(parsed.phoneNumber!, 'E164');
      
      // Call ToM-server API
      final response = await http.post(
        Uri.parse('${Config.homeserverUrl}/_twake/auth/phone/request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_number': e164,
          'client_secret': Uuid().v4(),
          'send_attempt': 1,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _sessionId = data['sid'];
          _otpSent = true;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP sent to $phoneNumber')),
        );
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to send OTP');
      }
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isRequestingOTP = false);
    }
  }
  
  Future<void> _verifyOTP() async {
    setState(() => _isVerifyingOTP = true);
    
    try {
      final response = await http.post(
        Uri.parse('${Config.homeserverUrl}/_twake/auth/phone/verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sid': _sessionId,
          'client_secret': _clientSecret, // Store this from request
          'token': _otpController.text,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['success']) {
          _validationToken = data['validation_token'];
          await _exchangeForAccessToken();
        }
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Invalid OTP');
      }
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isVerifyingOTP = false);
    }
  }
  
  Future<void> _exchangeForAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse('${Config.homeserverUrl}/_twake/auth/phone/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sid': _sessionId,
          'validation_token': _validationToken,
          'device_display_name': 'Twake Chat Flutter',
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Initialize Matrix client with access token
        await Matrix.of(context).client.init(
          newToken: data['access_token'],
          newUserID: data['user_id'],
          newDeviceID: data['device_id'],
          newHomeserver: Uri.parse(data['home_server']),
        );
        
        // Navigate to rooms
        Navigator.of(context).pushReplacementNamed('/rooms');
      }
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in with Phone')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: !_otpSent
            ? _buildPhoneInput()
            : _buildOTPInput(),
      ),
    );
  }
  
  Widget _buildPhoneInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your phone number',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Please enter your phone number.'),
        SizedBox(height: 32),
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Phone number',
            prefixText: '+',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isRequestingOTP ? null : _requestOTP,
          child: _isRequestingOTP
              ? CircularProgressIndicator()
              : Text('Send OTP'),
        ),
      ],
    );
  }
  
  Widget _buildOTPInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Enter verification code',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('We sent a code to ${_phoneController.text}'),
        SizedBox(height: 32),
        PinFieldAutoFill(
          controller: _otpController,
          codeLength: 6,
          onCodeSubmitted: (code) => _verifyOTP(),
          decoration: UnderlineDecoration(
            textStyle: TextStyle(fontSize: 20),
            colorBuilder: FixedColorBuilder(Colors.blue),
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isVerifyingOTP ? null : _verifyOTP,
          child: _isVerifyingOTP
              ? CircularProgressIndicator()
              : Text('Verify'),
        ),
        TextButton(
          onPressed: () => setState(() => _otpSent = false),
          child: Text('Change phone number'),
        ),
      ],
    );
  }
}
```

### 2.2 PUBSPEC.YAML DEPENDENCIES

Add to `pubspec.yaml`:

```yaml
dependencies:
  # ... existing dependencies ...
  
  # Phone number validation
  phone_number: ^1.0.0
  
  # SMS auto-fill (Android & iOS)
  sms_autofill: ^2.3.0
  
  # OTP input UI
  pin_code_fields: ^8.0.1
```

### 2.3 PLATFORM-SPECIFIC CONFIGURATIONS

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<!-- SMS auto-read permission -->
<uses-permission android:name="android.permission.RECEIVE_SMS"/>
<uses-permission android:name="android.permission.READ_SMS"/>

<!-- SMS Retriever API (no permission required) -->
<receiver android:name="com.google.android.gms.auth.api.phone.SmsRetriever$SmsRetrieverBroadcastReceiver"
          android:exported="true">
  <intent-filter>
    <action android:name="com.google.android.gms.auth.api.phone.SMS_RETRIEVED"/>
  </intent-filter>
</receiver>
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<!-- No special permissions needed for iOS SMS autofill -->
<!-- It uses Associated Domains for autofill -->
```

### 2.4 UPDATE LOGIN.DART

Replace buttons in `lib/pages/login/login.dart`:

```dart
// REMOVE these buttons:
// - "Create Twake ID" button
// - "Sign in" button (the web view ones)

// ADD this single button:
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhoneLoginPage(),
      ),
    );
  },
  child: Text('Continue with Phone Number'),
),

// Keep existing:
// - "Use your company server" button
```

---

## PART 3: COMPLETE FLOW DIAGRAM

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         PHONE AUTH COMPLETE FLOW                         │
└─────────────────────────────────────────────────────────────────────────┘

User Action          Flutter Client              ToM-Server          SMS Provider
─────────────────────────────────────────────────────────────────────────────

1. Opens app
                     Shows splash screen
                            │
                     Shows login options
                            │
2. Taps "Phone"      Navigate to
                     PhoneLoginPage
                            │
3. Enters phone      Validate E.164 format
   +905551234567            │
                            │
4. Taps "Send OTP"   POST /_twake/auth/      Generate OTP: 123456
                     phone/request                  │
                     {                        Store in Redis
                       phone_number,          (5 min TTL)
                       client_secret                │
                     }                              │
                            │                 POST to Twilio ───────>
                            │                       API
                            │                       │              Send SMS to
                     ◄──────sid────────      Return sid            +905551234567
                     expires_at                     │              "Your code:
                            │                       │               123456"
                     Show OTP input                 │                   │
                     screen                         │                   │
                            │                       │                   │
5. SMS arrives       sms_autofill plugin            │              SMS delivered
                     auto-reads SMS                 │                   │
                            │                       │                   │
                     Extract "123456"               │                   │
                     Fill OTP input                 │                   │
                            │                       │                   │
6. Auto-submit       POST /_twake/auth/       Validate OTP
   (or manual)       phone/verify             (123456 == 123456?)
                     {                              │
                       sid,                   Mark validated
                       client_secret,         Generate validation_token
                       token: "123456"              │
                     }                              │
                            │                       │
                     ◄──success────────      Return success
                     validation_token         validation_token
                            │                       │
7. Exchange token    POST /_twake/auth/       Check Matrix DB:
                     phone/login              Phone registered?
                     {                              │
                       sid,                    NO → Auto-register
                       validation_token        User: @905551234567
                     }                              │
                            │                 Call Synapse Admin API
                            │                 Create account
                            │                       │
                            │                 Generate access_token
                            │                       │
                     ◄──access_token───────   Return credentials
                     user_id                        │
                     device_id                      │
                            │                       │
8. Initialize        Matrix.client.init()     Session established
   Matrix client     with access_token              │
                            │                       │
                     Navigate to /rooms        Ready for chat
                            │
                     ✓ Authentication
                       complete
```

---

## PART 4: IMPLEMENTATION CHECKLIST

### Backend Tasks (ToM-Server)

- [ ] 1. Create new package `@twake/msisdn-auth`
- [ ] 2. Implement `requestOTP` controller
- [ ] 3. Implement `verifyOTP` controller
- [ ] 4. Implement `phoneLogin` controller
- [ ] 5. Create `SMSService` with Twilio integration
- [ ] 6. Create `SessionManager` with Redis
- [ ] 7. Create `OTPGenerator` utility
- [ ] 8. Add phone number validator (E.164)
- [ ] 9. Add rate limiting middleware
- [ ] 10. Register routes in `tom-server/src/index.ts`
- [ ] 11. Add configuration to `config/default.json`
- [ ] 12. Create database migration for phone-to-user mapping
- [ ] 13. Add Synapse Admin API client for auto-registration
- [ ] 14. Write unit tests for all controllers
- [ ] 15. Write integration tests for full flow
- [ ] 16. Update OpenAPI spec with new endpoints
- [ ] 17. Deploy Redis instance
- [ ] 18. Configure Twilio account & get credentials

### Frontend Tasks (Flutter)

- [ ] 1. Create `phone_login_page.dart`
- [ ] 2. Add `phone_number` dependency
- [ ] 3. Add `sms_autofill` dependency
- [ ] 4. Add `pin_code_fields` dependency
- [ ] 5. Update `login.dart` to remove WebView buttons
- [ ] 6. Add "Continue with Phone" button
- [ ] 7. Implement phone number input UI
- [ ] 8. Implement OTP input UI with auto-fill
- [ ] 9. Create API client methods for phone auth
- [ ] 10. Add error handling & retry logic
- [ ] 11. Add loading states & progress indicators
- [ ] 12. Update Android manifest for SMS permissions
- [ ] 13. Test SMS auto-fill on Android
- [ ] 14. Test SMS auto-fill on iOS
- [ ] 15. Add analytics events (phone_login_start, phone_login_complete)
- [ ] 16. Update navigation flow to skip WebView
- [ ] 17. Add "Resend OTP" functionality
- [ ] 18. Add "Edit phone number" functionality

---

## PART 5: TESTING INSTRUCTIONS

### Backend Testing

```bash
# 1. Start ToM-server with new package
cd ToM-server
npm install
npm run build
npm start

# 2. Test request OTP
curl -X POST http://localhost:8090/_twake/auth/phone/request \
  -H "Content-Type: application/json" \
  -d '{
    "phone_number": "+905551234567",
    "client_secret": "test-secret-123"
  }'

# Expected response:
# {
#   "sid": "uuid-here",
#   "expires_at": 1234567890,
#   "send_attempt": 1
# }

# 3. Check SMS delivery in Twilio logs

# 4. Test verify OTP
curl -X POST http://localhost:8090/_twake/auth/phone/verify \
  -H "Content-Type: application/json" \
  -d '{
    "sid": "uuid-from-step-2",
    "client_secret": "test-secret-123",
    "token": "123456"
  }'

# Expected response:
# {
#   "success": true,
#   "validated_at": 1234567890,
#   "validation_token": "another-uuid"
# }

# 5. Test login
curl -X POST http://localhost:8090/_twake/auth/phone/login \
  -H "Content-Type: application/json" \
  -d '{
    "sid": "uuid-from-step-2",
    "validation_token": "uuid-from-step-4"
  }'

# Expected response:
# {
#   "user_id": "@905551234567:twake.app",
#   "access_token": "matrix-token-here",
#   "device_id": "device-id-here",
#   "home_server": "twake.app"
# }
```

### Flutter Testing

```bash
# 1. Update dependencies
flutter pub get

# 2. Run on Android
flutter run -d android

# 3. Test flow:
#    - Enter phone number
#    - Tap "Send OTP"
#    - Wait for SMS (should auto-fill)
#    - Verify OTP auto-submits
#    - Check navigation to /rooms

# 4. Test error cases:
#    - Invalid phone number
#    - Wrong OTP code
#    - Expired session
#    - Network errors
```

---

## PART 6: DEPLOYMENT CONSIDERATIONS

### Environment Variables

```bash
# ToM-Server .env
SMS_PROVIDER=twilio
SMS_API_KEY=AC1234567890abcdef
SMS_API_SECRET=your_auth_token_here
SMS_SENDER_ID=+15551234567
REDIS_URL=redis://localhost:6379
SYNAPSE_ADMIN_TOKEN=your_synapse_admin_token
HOMESERVER_URL=https://matrix.twake.app
```

### Infrastructure Requirements

- **Redis** for session storage (5-minute TTL)
- **Twilio account** (or MessageBird/Vonage)
- **Synapse homeserver** with admin API enabled
- **PostgreSQL** for phone-to-user mapping persistence

---

## SUMMARY FOR AI AGENT

**YOUR TASK:**

1. **CREATE** new package `@twake/msisdn-auth` in ToM-server with 4 endpoints
2. **IMPLEMENT** OTP generation, SMS sending, session management
3. **INTEGRATE** with Twilio (or chosen SMS provider)
4. **AUTO-REGISTER** Matrix users with phone number as username
5. **BUILD** Flutter native phone input page (no WebView)
6. **IMPLEMENT** SMS auto-fill for Android & iOS
7. **REPLACE** current WebView login flow with native flow

**NO EXISTING CODE** - you're building from scratch. Follow the specifications above exactly.

The current ToM-server has NO phone auth - you must add it completely.
```