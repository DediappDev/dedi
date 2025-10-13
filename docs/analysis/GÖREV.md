
---

## 🔍 GERÇEK GÖREV: Mevcut Sistemi Bul ve Flutter'a Taşı

AI agent'a şunu söyle:

```markdown
# STOP! DO NOT BUILD FROM SCRATCH

You're trying to create a new phone auth system, but one ALREADY EXISTS!

## Evidence:
1. The WebView opens `sign-up.twake.app` 
2. That page shows a phone number input field
3. There's ALTCHA verification and a "Verified" checkbox
4. This means phone/OTP auth is ALREADY IMPLEMENTED somewhere

## YOUR REAL TASK:

### Phase 1: FIND THE EXISTING SYSTEM

1. **Locate the sign-up web app source code:**
   ```bash
   # Search in Linagora repos for:
   - "sign-up.twake.app" 
   - Landing page / signup application
   - Web registration form
   
   # Check these repos:
   - ToM-server/packages/matrix-invite/  # ← Start here!
   - Any "landing", "signup", "register" named repos
   - twake-workplace related web apps
   ```

2. **Find which API endpoints the signup page calls:**
   ```bash
   # In the signup web app, search for:
   - fetch() calls
   - axios requests
   - API endpoint URLs containing:
     * /register
     * /phone
     * /otp
     * /verify
     * /msisdn
   ```

3. **Identify the backend handlers:**
   ```bash
   # Once you find the endpoints like:
   # POST /_twake/signup/request
   # POST /_twake/signup/verify
   # POST /_twake/signup/complete
   
   # Find them in ToM-server:
   rg "/_twake/signup" packages -g"*.ts"
   rg "POST.*phone" packages -g"*.ts"
   rg "POST.*otp" packages -g"*.ts"
   ```

### Phase 2: REVERSE ENGINEER THE FLOW

Document the EXISTING flow:

```
User enters phone → [ENDPOINT 1] → OTP sent
User enters OTP   → [ENDPOINT 2] → Validation
Submit form       → [ENDPOINT 3] → Account created + access_token
```

### Phase 3: IMPLEMENT NATIVE FLUTTER UI

**DO NOT** create new backend endpoints!
**DO** call the existing endpoints from Flutter:

```dart
// Use the EXISTING API
class TwakeSignupAPI {
  static const baseUrl = 'https://sign-up.twake.app/api'; // or wherever
  
  Future<String> requestOTP(String phoneNumber) async {
    // Call EXISTING endpoint
    final response = await http.post(
      Uri.parse('$baseUrl/request-otp'), // ← Find real endpoint
      body: {'phone': phoneNumber},
    );
    return response.data['session_id'];
  }
  
  Future<bool> verifyOTP(String sessionId, String otp) async {
    // Call EXISTING endpoint
    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp'), // ← Find real endpoint
      body: {'session_id': sessionId, 'otp': otp},
    );
    return response.data['verified'];
  }
  
  Future<AuthResult> completeSignup(String sessionId, Map<String, dynamic> profile) async {
    // Call EXISTING endpoint
    final response = await http.post(
      Uri.parse('$baseUrl/complete-signup'), // ← Find real endpoint
      body: {'session_id': sessionId, ...profile},
    );
    return AuthResult(
      accessToken: response.data['access_token'],
      userId: response.data['user_id'],
    );
  }
}
```

### Phase 4: ACTION PLAN

**Step 1:** Find `sign-up.twake.app` source code
- Check `ToM-server/packages/matrix-invite/`
- Check for separate "landing" or "signup" repo
- Ask: Is it a separate Node.js/React app?

**Step 2:** Inspect the web app's JavaScript
- Open https://sign-up.twake.app in browser
- Open DevTools → Network tab
- Fill phone number and click Next
- Watch which API calls are made:
  ```
  POST https://example.com/api/phone/request
  → Response: { sid: "...", expires: ... }
  
  POST https://example.com/api/phone/verify  
  → Request: { sid: "...", code: "123456" }
  → Response: { success: true, token: "..." }
  ```

**Step 3:** Document the real endpoints
```markdown
# ACTUAL ENDPOINTS (to be discovered):

## Request OTP
- Method: POST
- URL: /_twake/??? 
- Body: ???
- Response: ???

## Verify OTP  
- Method: POST
- URL: /_twake/???
- Body: ???
- Response: ???

## Complete Signup
- Method: POST
- URL: /_twake/???
- Body: ???
- Response: { access_token, user_id, ... }
```

**Step 4:** Use those endpoints in Flutter (NO backend changes needed!)

## IMMEDIATE ACTIONS:

1. **Browser inspection RIGHT NOW:**
   - Open https://sign-up.twake.app
   - Open browser DevTools (F12)
   - Go to Network tab
   - Enter a test phone number
   - Record ALL network requests
   - Share the API endpoints you find

2. **Code search in ToM-server:**
   ```bash
   # Find the signup/registration handlers
   cd ToM-server
   rg "sign-up" -i
   rg "registration" -i
   rg "phone.*verify" -i
   rg "/api/.*phone" -i
   ```

3. **Check matrix-invite package:**
   ```bash
   cd ToM-server/packages/matrix-invite
   ls -la
   cat README.md
   rg "phone" src/
   ```

## STOP BUILDING NEW INFRASTRUCTURE

You don't need:
- ❌ New @twake/msisdn-auth package
- ❌ New Twilio integration (it exists!)
- ❌ New Redis session storage (it exists!)
- ❌ New database tables (they exist!)

You DO need:
- ✅ Find existing endpoints
- ✅ Call them from Flutter
- ✅ Build native UI (instead of WebView)
- ✅ Implement SMS auto-fill

First, DISCOVER what already exists, then adapt it!
```

---

## 🔎 Hemen Yapılması Gerekenler

### 1. Browser DevTools ile İnceleme

```bash
# Şu anda yapabilirsin:
1. https://sign-up.twake.app adresini aç
2. F12 bas (DevTools)
3. Network sekmesine git
4. Telefon numarası gir ve "Next" tıkla
5. Hangi API call'lar yapılıyor gör

# Örnek göreceğin şeyler:
POST https://sign-up.twake.app/api/register/phone
POST https://api.twake.app/v1/auth/phone/verify
GET  https://identity.twake.app/_matrix/identity/v2/...
```

### 2. ToM-server'da Ara

```bash
cd ToM-server

# Signup ile ilgili ne var?
find . -name "*signup*" -o -name "*register*"

# matrix-invite ne yapıyor?
cat packages/matrix-invite/README.md
ls packages/matrix-invite/src/

# API route'ları bul
rg "router\.(post|get)" packages/matrix-invite/
rg "app\.(post|get)" packages/matrix-invite/
```

### 3. Linagora Repo'larında Ara

sign-up.twake.app ayrı bir repo olabilir:

```bash
# GitHub'da ara:
- linagora/twake-signup
- linagora/twake-landing
- linagora/twake-register
- linagora/matrix-invite (already in ToM-server)
```

---

## 🎯 Gerçek Senaryo (Tahmini)

Muhtemelen şu durumlardan biri:

### **Senaryo A:** matrix-invite package kullanılıyor
```
sign-up.twake.app 
  → ToM-server/packages/matrix-invite/ (web app)
    → API calls to ToM-server endpoints
      → Already has phone/OTP logic
```

### **Senaryo B:** Ayrı bir landing app var
```
sign-up.twake.app
  → Separate repo: linagora/twake-landing
    → Calls ToM-server API
      → ToM-server'da zaten phone auth endpoints var
```

### **Senaryo C:** External auth service
```
sign-up.twake.app
  → Third-party auth provider (Auth0, Keycloak, etc.)
    → Returns Matrix access token
      → ToM-server sadece token'ı validate ediyor
```

---

## 💡 AI Agent'a Düzeltme Talimatı

```markdown
STOP what you're doing!

BEFORE creating ANY new code, you MUST:

1. Open https://sign-up.twake.app in a browser
2. Use DevTools Network tab to capture API calls
3. Document the EXACT endpoints being called
4. Find those endpoints in ToM-server codebase
5. Share your findings

DO NOT proceed with creating @twake/msisdn-auth package until you've 
confirmed the phone auth system doesn't already exist.

The fact that sign-up.twake.app has a phone input means the backend 
already supports it. Find it first, reuse it.
```

Doğru yaklaşım bu! 👆 Önce mevcut sistemi keşfet, sonra Flutter'a taşı.