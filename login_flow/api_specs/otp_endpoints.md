# OTP API Endpoints Specification

## 📋 Overview

This document specifies the backend API endpoints required for the OTP-based authentication system. These endpoints handle phone number verification and token exchange for Matrix integration.

## 🔌 Base Configuration

```
Base URL: https://api.yourapp.com
Content-Type: application/json
Accept: application/json
```

## 📞 1. Send OTP Request

### Endpoint
```
POST /otp/request
```

### Description
Sends a 6-digit OTP code to the provided phone number via SMS.

### Request Headers
```http
Content-Type: application/json
Accept: application/json
```

### Request Body
```json
{
  "phone": "+905551234567"
}
```

### Request Parameters
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| phone | string | Yes | Phone number in international format (E.164) |

### Success Response (200 OK)
```json
{
  "status": "sent",
  "message": "OTP code sent successfully",
  "expires_in": 300,
  "dev_otp": "123456"
}
```

### Development Response Fields
| Field | Type | Description |
|-------|------|-------------|
| status | string | Always "sent" on success |
| message | string | Human-readable status message |
| expires_in | number | OTP expiration time in seconds (5 minutes) |
| dev_otp | string | **Development only** - The actual OTP code for testing |

### Error Responses

#### 400 Bad Request - Invalid Phone Number
```json
{
  "error": "INVALID_PHONE",
  "message": "Invalid phone number format",
  "details": {
    "phone": "Phone number must be in international format"
  }
}
```

#### 429 Too Many Requests - Rate Limited
```json
{
  "error": "RATE_LIMITED",
  "message": "Too many OTP requests. Please wait before requesting again.",
  "retry_after": 60
}
```

#### 500 Internal Server Error
```json
{
  "error": "SMS_PROVIDER_ERROR",
  "message": "Failed to send SMS. Please try again later."
}
```

### Example cURL Request
```bash
curl -X POST https://api.yourapp.com/otp/request \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567"}'
```

---

## ✅ 2. Verify OTP Code

### Endpoint
```
POST /otp/verify
```

### Description
Verifies the OTP code and returns JWT authentication token along with Matrix user information.

### Request Headers
```http
Content-Type: application/json
Accept: application/json
```

### Request Body
```json
{
  "phone": "+905551234567",
  "code": "123456"
}
```

### Request Parameters
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| phone | string | Yes | Phone number used for OTP request |
| code | string | Yes | 6-digit OTP code received via SMS |

### Success Response (200 OK)
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "user_id": "@user123:dedi.useitsoon.com",
  "mxid": "@user123:dedi.useitsoon.com",
  "phone": "+905551234567",
  "created_at": "2024-01-15T10:30:00Z"
}
```

### Response Fields
| Field | Type | Description |
|-------|------|-------------|
| access_token | string | JWT token for backend authentication |
| token_type | string | Always "Bearer" |
| expires_in | number | Token expiration time in seconds |
| user_id | string | Matrix user ID (MXID) |
| mxid | string | Matrix user ID (same as user_id) |
| phone | string | Verified phone number |
| created_at | string | Account creation timestamp (ISO 8601) |

### Error Responses

#### 400 Bad Request - Invalid OTP
```json
{
  "error": "INVALID_OTP",
  "message": "Invalid or expired OTP code",
  "attempts_remaining": 2
}
```

#### 400 Bad Request - OTP Expired
```json
{
  "error": "OTP_EXPIRED",
  "message": "OTP code has expired. Please request a new one."
}
```

#### 429 Too Many Requests - Too Many Attempts
```json
{
  "error": "TOO_MANY_ATTEMPTS",
  "message": "Too many failed attempts. Account temporarily locked.",
  "locked_until": "2024-01-15T10:45:00Z"
}
```

### Example cURL Request
```bash
curl -X POST https://api.yourapp.com/otp/verify \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567", "code": "123456"}'
```

---

## 🔐 3. Exchange JWT for Matrix Token

### Endpoint
```
POST /otp/matrix-token
```

### Description
Exchanges the JWT token for Matrix server credentials including access token and device information.

### Request Headers
```http
Content-Type: application/json
Accept: application/json
Authorization: Bearer <jwt_token>
```

### Request Body
```json
{
  "jwt_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "phone": "+905551234567"
}
```

### Request Parameters
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| jwt_token | string | Yes | JWT token from OTP verification |
| phone | string | Yes | Phone number for additional verification |

### Success Response (200 OK)
```json
{
  "access_token": "syt_dXNlcjEyMw_YWxsb3dlZA_YWNjZXNzX3Rva2Vu",
  "user_id": "@user123:dedi.useitsoon.com",
  "mxid": "@user123:dedi.useitsoon.com",
  "device_id": "DEDIANDROID123",
  "device_name": "Dedi Mobile App",
  "homeserver": "https://dedi.useitsoon.com",
  "expires_in": null
}
```

### Response Fields
| Field | Type | Description |
|-------|------|-------------|
| access_token | string | Matrix server access token |
| user_id | string | Matrix user ID (MXID) |
| mxid | string | Matrix user ID (same as user_id) |
| device_id | string | Unique device identifier for Matrix |
| device_name | string | Human-readable device name |
| homeserver | string | Matrix homeserver URL |
| expires_in | null | Matrix tokens typically don't expire |

### Error Responses

#### 401 Unauthorized - Invalid JWT
```json
{
  "error": "INVALID_TOKEN",
  "message": "Invalid or expired JWT token"
}
```

#### 403 Forbidden - Matrix Account Creation Failed
```json
{
  "error": "MATRIX_ACCOUNT_ERROR",
  "message": "Failed to create or access Matrix account",
  "details": {
    "matrix_error": "M_USER_IN_USE"
  }
}
```

#### 503 Service Unavailable - Matrix Server Error
```json
{
  "error": "MATRIX_SERVER_ERROR",
  "message": "Matrix homeserver is temporarily unavailable"
}
```

### Example cURL Request
```bash
curl -X POST https://api.yourapp.com/otp/matrix-token \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." \
  -d '{"jwt_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", "phone": "+905551234567"}'
```

---

## 🔄 4. Token Refresh (Optional)

### Endpoint
```
POST /auth/refresh
```

### Description
Refreshes an expired JWT token using a refresh token.

### Request Headers
```http
Content-Type: application/json
Accept: application/json
Authorization: Bearer <expired_jwt_token>
```

### Request Body
```json
{
  "refresh_token": "refresh_token_here"
}
```

### Success Response (200 OK)
```json
{
  "access_token": "new_jwt_token_here",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "new_refresh_token_here"
}
```

---

## 🛡️ Security Considerations

### Rate Limiting
- **OTP Request**: Maximum 3 requests per phone number per hour
- **OTP Verification**: Maximum 5 attempts per OTP code
- **Matrix Token**: Maximum 10 requests per JWT token per minute

### OTP Security
- OTP codes expire after 5 minutes
- Codes are single-use only
- Minimum 6 digits, generated cryptographically
- Phone number verification required

### JWT Token Security
- Tokens expire after 1 hour
- Include phone number in claims for verification
- Use secure signing algorithm (RS256 recommended)
- Include rate limiting headers

### CORS Configuration
For web applications, ensure proper CORS headers:
```http
Access-Control-Allow-Origin: https://yourdomain.com
Access-Control-Allow-Methods: POST, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization
Access-Control-Max-Age: 86400
```

---

## 📊 Response Headers

### Standard Headers
All responses should include:
```http
Content-Type: application/json
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640995200
```

### Error Headers
Error responses should include:
```http
X-Request-ID: uuid-for-debugging
X-Error-Code: SPECIFIC_ERROR_CODE
```

---

## 🧪 Testing Endpoints

### Development Environment
```bash
# Test OTP request
curl -X POST http://localhost:3000/otp/request \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567"}'

# Test OTP verification
curl -X POST http://localhost:3000/otp/verify \
  -H "Content-Type: application/json" \
  -d '{"phone": "+905551234567", "code": "123456"}'
```

### Mock Responses
For testing, you can use these mock responses:

```javascript
// Mock OTP request
{
  "status": "sent",
  "message": "OTP code sent successfully",
  "expires_in": 300,
  "dev_otp": "123456"
}

// Mock OTP verification
{
  "access_token": "mock_jwt_token",
  "token_type": "Bearer",
  "expires_in": 3600,
  "user_id": "@testuser:dedi.useitsoon.com",
  "mxid": "@testuser:dedi.useitsoon.com",
  "phone": "+905551234567",
  "created_at": "2024-01-15T10:30:00Z"
}
```

---

## 📋 Implementation Checklist

### Backend Requirements
- [ ] SMS provider integration (Twilio, AWS SNS, etc.)
- [ ] JWT token generation and validation
- [ ] Matrix homeserver integration
- [ ] Rate limiting implementation
- [ ] Database for user accounts and OTP tracking
- [ ] Error handling and logging
- [ ] CORS configuration for web support

### Security Requirements
- [ ] Input validation and sanitization
- [ ] Rate limiting on all endpoints
- [ ] Secure OTP generation
- [ ] JWT token security
- [ ] HTTPS enforcement
- [ ] Request/response logging
- [ ] IP-based rate limiting

### Monitoring Requirements
- [ ] API response time monitoring
- [ ] Error rate tracking
- [ ] SMS delivery rate monitoring
- [ ] Matrix integration health checks
- [ ] Security event logging

---

This API specification provides a complete backend interface for implementing secure OTP-based authentication with Matrix integration. Follow the security guidelines and implement proper error handling for a production-ready system.