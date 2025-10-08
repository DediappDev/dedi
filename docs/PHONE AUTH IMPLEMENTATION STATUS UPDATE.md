
```markdown
# PHONE AUTH IMPLEMENTATION STATUS UPDATE

## ✅ WHAT WE HAVE:

### 1. Client Side (dedi - Flutter app)
Location: `/Users/liberyus/development/dedi`

- ✅ **Complete documentation** in `login_flow/` directory
- ✅ **API specification** in `login_flow/api_specs/otp_endpoints.md`
- ✅ **Code examples** ready to use
- ✅ **Implementation guides** step-by-step
- ❌ **Native phone login NOT implemented yet** (still using WebView)

### 2. Server Side (dedi-server - ToM-server fork)
Location: `/Users/liberyus/development/dedi-server`

Structure:
```
dedi-server/
├── packages/
│   ├── tom-server/              # Main server
│   ├── matrix-identity-server/  # Identity service
│   ├── matrix-client-server/    # Client API
│   └── ...other packages...
└── landing/                      # Remix landing page (NOT signup app)
```

**BACKEND STATUS:**
- ❌ NO `/otp/request` endpoint
- ❌ NO `/otp/verify` endpoint  
- ❌ NO `/otp/matrix-token` endpoint
- ❌ Phone auth system NOT implemented

## 🎯 YOUR TASK:

**BUILD the phone auth backend from scratch** following the API spec in:
`/Users/liberyus/development/dedi/login_flow/api_specs/otp_endpoints.md`

## 📋 IMPLEMENTATION PLAN:

### Phase 1: Create OTP Service Package

Create new package: `/Users/liberyus/development/dedi-server/packages/otp-auth/`

**Files to create:**
```
packages/otp-auth/
├── package.json
├── tsconfig.json
├── src/
│   ├── index.ts
│   ├── routes.ts              # Express routes
│   ├── controllers/
│   │   ├── requestOTP.ts      # POST /otp/request
│   │   ├── verifyOTP.ts       # POST /otp/verify
│   │   └── matrixToken.ts     # POST /otp/matrix-token
│   ├── services/
│   │   ├── SMSService.ts      # SMS provider integration
│   │   ├── OTPGenerator.ts    # OTP generation
│   │   ├── SessionManager.ts  # OTP session storage
│   │   └── MatrixClient.ts    # Matrix integration
│   ├── models/
│   │   ├── OTPSession.ts
│   │   └── User.ts
│   └── validators/
│       └── phoneNumber.ts
└── README.md
```

### Phase 2: Implement API Endpoints

Follow EXACTLY the API spec in `otp_endpoints.md`:

**1. POST /otp/request**
- Validate phone number (E.164 format)
- Generate 6-digit OTP
- Send SMS (use Twilio/mock for dev)
- Store session in Redis
- Return with dev_otp in development

**2. POST /otp/verify**
- Validate OTP code
- Generate JWT token
- Create or get Matrix user ID
- Return JWT + user info

**3. POST /otp/matrix-token**
- Validate JWT
- Exchange for Matrix access token
- Create Matrix device
- Return Matrix credentials

### Phase 3: Integration

**Update tom-server:**
`/Users/liberyus/development/dedi-server/packages/tom-server/src/index.ts`

```typescript
import otpAuthRouter from '@twake/otp-auth';

// Add routes
app.use('/otp', otpAuthRouter);
```

**Add dependencies:**
`/Users/liberyus/development/dedi-server/package.json`

```json
{
  "dependencies": {
    "twilio": "^4.19.0",      // SMS provider
    "ioredis": "^5.3.2",       // Session storage
    "jsonwebtoken": "^9.0.2",  // JWT tokens
    "libphonenumber-js": "^1.10.51"  // Phone validation
  }
}
```

## 🗂️ AVAILABLE RESOURCES:

### Documentation:
- `/Users/liberyus/development/dedi/login_flow/README.md`
- `/Users/liberyus/development/dedi/login_flow/api_specs/otp_endpoints.md`
- `/Users/liberyus/development/dedi/login_flow/docs/`
- `/Users/liberyus/development/dedi/login_flow/implementation_guides/`

### Existing code to reference:
- Matrix integration: `/Users/liberyus/development/dedi-server/packages/matrix-identity-server/`
- Auth patterns: `/Users/liberyus/development/dedi-server/packages/matrix-client-server/`
- Config parsing: `/Users/liberyus/development/dedi-server/packages/config-parser/`

### Dependencies directory:
- `/Users/liberyus/development/deps/` (for cloning additional repos if needed)

## 🚀 START IMPLEMENTATION:

1. **Create the otp-auth package structure**
2. **Implement the 3 endpoints** according to spec
3. **Add SMS provider** (Twilio or mock for dev)
4. **Integrate with tom-server**
5. **Test with cURL**
6. **Document any configuration needed**

## 📝 NOTES:

- Use TypeScript for consistency
- Follow existing package patterns in `packages/`
- Use Redis for OTP session storage
- In development, return actual OTP in response (dev_otp field)
- Use existing @twake/* packages for config, logging, etc.
- Matrix integration: use packages/matrix-client-server patterns

## ✅ SUCCESS CRITERIA:

Backend working when you can:
```bash
# 1. Request OTP
curl -X POST http://localhost:8090/otp/request \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567"}'
# → Returns: {"status": "sent", "dev_otp": "123456"}

# 2. Verify OTP
curl -X POST http://localhost:8090/otp/verify \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567", "code": "123456"}'
# → Returns: {"access_token": "...", "user_id": "@..."}

# 3. Get Matrix token
curl -X POST http://localhost:8090/otp/matrix-token \
  -H "Authorization: Bearer <jwt_token>" \
  -d '{"jwt_token": "...", "phone": "+905551234567"}'
# → Returns: {"access_token": "...", "device_id": "..."}
```

Now you can proceed with implementation! All specs and documentation are local.
```

