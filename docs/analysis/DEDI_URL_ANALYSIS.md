# DEDI Project - Complete URL Analysis

## Executive Summary

This document provides a comprehensive analysis of all URLs, domains, endpoints, and network addresses used by the Dedi project (formerly Twake Chat). The analysis covers both the Flutter client (`dedi-secure`) and the Node.js server (`dediserver`) components.

## Domain Migration Status

**✅ COMPLETED**: The project has successfully migrated from `twake.app` to `dedim.com.tr` infrastructure.

### Domain Mapping
| Service | Old Domain | New Domain | Status |
|---------|------------|------------|--------|
| Matrix homeserver | `matrix.twake.app` | `matrix.dedim.com.tr` | ✅ Migrated |
| Identity server | `identity.twake.app` | `identity.dedim.com.tr` | ✅ Migrated |
| Chat web | `chat.twake.app` | `chat.dedim.com.tr` | ✅ Migrated |
| Registration/QR | `sign-up.twake.app` | `sign-up.dedim.com.tr` | ✅ Migrated |
| Push gateway | `push.twake.app` | `notification.dedim.com.tr` | ✅ Migrated |
| Policy/support | `twake.app/*` | `dedim.com.tr/*` | ✅ Migrated |

---

## 1. Matrix Federation URLs

### Core Matrix Protocol Endpoints
- **Matrix homeserver**: `https://matrix.dedim.com.tr`
- **Identity server**: `https://identity.dedim.com.tr`
- **Push gateway**: `https://notification.dedim.com.tr/_matrix/push/v1/notify`

### Matrix API Endpoints
- **Client API**: `/_matrix/client/v3/*`
- **Federation API**: `/_matrix/federation/v1/*`
- **Identity API**: `/_matrix/identity/v2/*`
- **Push API**: `/_matrix/push/v1/notify`
- **Well-known endpoints**:
  - `/.well-known/matrix/client`
  - `/.well-known/matrix/server`

### Matrix Authentication Endpoints
- **SSO redirect**: `/_matrix/client/r0/login/sso/redirect`
- **Login endpoint**: `/_matrix/client/r0/login`
- **Token validation**: `/_matrix/identity/v2/validate/msisdn/requestToken`
- **OTP submission**: `/_matrix/identity/v2/validate/msisdn/submitToken`
- **3PID binding**: `/_matrix/identity/v2/3pid/bind`
- **3PID lookup**: `/_matrix/identity/v2/3pid/getValidated3pid`

---

## 2. Authentication & SSO URLs

### OAuth/OIDC Endpoints
- **Authorization**: `https://accounts.example.com/oauth2/auth`
- **Token**: `https://accounts.example.com/oauth2/token`
- **UserInfo**: `https://accounts.example.com/userinfo`
- **JWKS**: `https://accounts.example.com/.well-known/jwks.json`

### SAML Endpoints
- **Metadata**: `https://our_idp/metadata.xml`
- **ACS**: `https://<server>:<port>/_synapse/client/saml2/authn_response`
- **Metadata endpoint**: `https://<server>:<port>/_synapse/client/saml2/metadata.xml`

### CAS Endpoints
- **Server URL**: `https://cas-server.com`

---

## 3. Custom API Endpoints

### DEDI-Specific Endpoints
- **App API**: `/_dedi/app/v1/*`
- **Identity API**: `/_dedi/identity/v1/*`
- **General API**: `/_dedi/v1/*`

### Legacy Twake Endpoints (Deprecated)
- **App API**: `/_twake/app/v1/*` (deprecated)
- **Identity API**: `/_twake/identity/v1/*` (deprecated)
- **General API**: `/_twake/v1/*` (deprecated)

### OTP Authentication Endpoints
- **Request OTP**: `POST /otp/request`
- **Verify OTP**: `POST /otp/verify`
- **Matrix token exchange**: `POST /otp/matrix-token`

---

## 4. SMS Provider URLs

### Turkish SMS Providers
- **Turkcell MesajÜssü v2**: `https://api.mesajussu.turkcell.com.tr`
  - Login: `POST /integration/v2/login`
- **NetGSM**: `https://api.netgsm.com.tr/sms/send/get`
- **İletiMerkezi**: `https://api.iletimerkezi.com/v1/send-sms/get/`
- **TurkTelekom**: (Configuration available)

### International SMS Providers
- **Twilio**: Standard REST API (if configured)
- **Reference**: `https://www.twilio.com/docs/sms/api`

---

## 5. Public Domain URLs

### Main Website
- **Homepage**: `https://dedim.com.tr`
- **Privacy Policy**: `https://dedim.com.tr/en/privacy/`
- **Support**: `https://dedim.com.tr/support`

### Registration & Downloads
- **Registration**: `https://sign-up.dedim.com.tr/`
- **QR Code Download**: `https://sign-up.dedim.com.tr/download/chat`

### Chat Web Interface
- **Web Chat**: `https://chat.dedim.com.tr`

---

## 6. Development & Testing URLs

### Local Development
- **Localhost Matrix**: `http://localhost:8008`
- **Localhost OTP**: `http://localhost:8090`
- **Localhost Redis**: `redis://localhost:6379`
- **Localhost API**: `http://localhost:3000`

### Environment-Specific URLs
- **Development API**: `https://dev-api.dedim.com.tr`
- **Development Matrix**: `https://dev-matrix.dedim.com.tr`
- **TestFlight API**: `https://testflight-api.dedim.com.tr`
- **TestFlight Matrix**: `https://testflight-matrix.dedim.com.tr`
- **Production API**: `https://api.dedim.com.tr`
- **Production Matrix**: `https://matrix.dedim.com.tr`

---

## 7. External Service URLs

### GitHub & Source Code
- **Main Repository**: `https://github.com/dediapp/dedi`
- **Upstream Repository**: `https://github.com/linagora/twake-on-matrix`
- **SMS Reference**: `https://github.com/kdrulgr/turkcell-mesajussu-php-sms-api.git`
- **İletiMerkezi Reference**: `https://github.com/dediapp/iletimerkezi-1.git`
- **SMS Quick Reference**: `https://github.com/dediapp/smsQuick.git`

### Documentation & References
- **Matrix Identity API**: `https://spec.matrix.org/v1.11/identity-service-api/`
- **Matrix Client-Server API**: `https://spec.matrix.org/v1.11/client-server-api/`
- **ToM-server Docs**: `https://linagora.github.io/ToM-server/`
- **Flutter Documentation**: `https://docs.flutter.dev/`
- **Dart Documentation**: `https://dart.dev/guides`

### Community & Support
- **Flutter Community**: `https://flutter.dev/community`
- **Dart Community**: `https://dart.dev/community`

---

## 8. Docker & Infrastructure URLs

### Docker Services
- **Nginx Proxy**: `http://localhost:80`, `https://localhost:443`
- **Ntfy**: `http://localhost:8080`
- **Ntfy (alternative)**: `http://localhost:8081`

### Database & Cache
- **Redis**: `redis://localhost:6379`
- **PostgreSQL**: `postgresql://localhost:5432`

---

## 9. WebSocket & Real-time URLs

### WebSocket Endpoints
- **Matrix Sync**: `wss://matrix.dedim.com.tr/_matrix/client/r0/sync`
- **Federation**: `wss://matrix.dedim.com.tr/_matrix/federation/v1/send`

---

## 10. Mobile App Deep Links

### App-specific URLs
- **Login deep link**: `dedi://login`
- **Matrix invite links**: `https://matrix.to/#/`

---

## 11. Configuration Files with URLs

### Key Configuration Files
- `lib/config/environment.dart` - Main environment configuration
- `config.json` - Application configuration
- `config.sample.json` - Sample configuration
- `integration_test/synapse/data/homeserver.yaml` - Synapse configuration
- `integration_test/dendrite/data/dendrite.yaml` - Dendrite configuration

---

## 12. Environment Variables

### API Configuration
- `DEDI_API_BASE_URL=https://api.dedim.com.tr`
- `DEDI_HOMESERVER_URL=https://matrix.dedim.com.tr`
- `API_BASE_URL` (environment-specific)
- `HOMESERVER_URL` (environment-specific)

### SMS Configuration
- `TURKCELL_BASE_URL=https://api.mesajussu.turkcell.com.tr`
- `NETGSM_URL=https://api.netgsm.com.tr/sms/send/get`
- `ILETIMERKEZI_URL=https://api.iletimerkezi.com/v1/send-sms/get/`

### Database Configuration
- `REDIS_URL=redis://localhost:6379`

---

## 13. Security & SSL

### Certificate Paths
- **TLS Certificate**: `/data/localhost.tls.crt`
- **TLS Private Key**: `/data/localhost.tls.key`
- **Signing Key**: `/data/localhost.signing.key`

### Trusted Key Servers
- **Matrix.org**: `https://matrix.org`

---

## 14. Monitoring & Metrics

### Metrics Endpoints
- **Prometheus**: `/_synapse/metrics`
- **Health Check**: `/_synapse/health`

---

## 15. File Locations

### Configuration Files
- **Main config**: `/Users/liberyus/development/dedi/config.json`
- **Environment**: `/Users/liberyus/development/dedi/lib/config/environment.dart`
- **Synapse config**: `/Users/liberyus/development/dedi/integration_test/synapse/data/homeserver.yaml`

### Documentation Files
- **Implementation Guide**: `/Users/liberyus/development/dedi/docs/UNIFIED_IMPLEMENTATION_GUIDE.md`
- **Migration Plan**: `/Users/liberyus/development/dedi/docs/IMPLEMENTATION_PLAN.md`
- **API Migration**: `/Users/liberyus/development/dedi/API_MIGRATION_GUIDE.md`

---

## Summary

The Dedi project uses a comprehensive set of URLs across multiple domains and services:

- **Primary Domain**: `dedim.com.tr` (migrated from `twake.app`)
- **Matrix Protocol**: Full Matrix federation support with custom endpoints
- **SMS Integration**: Multiple Turkish SMS providers with fallback support
- **Authentication**: OAuth, SAML, CAS, and custom OTP flows
- **Development**: Environment-specific URLs for dev, testflight, and production
- **External Services**: GitHub, documentation, and community resources

All URLs have been successfully migrated to the new `dedim.com.tr` infrastructure, with proper backwards compatibility maintained for the transition period.

