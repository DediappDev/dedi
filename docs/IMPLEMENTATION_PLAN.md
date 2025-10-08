# Twake Chat → dedim.com.tr Implementation Plan

## 1. Discovery Summary

### Backend (`/Users/liberyus/development/dedi-server`)
- **Identity/OTP**: `@twake/matrix-identity-server` serves Matrix Identity v2 routes and invitation flows but relies on a bespoke `SmsService` that posts to Octopush. No dedicated MSISDN OTP endpoints exist today.
- **Invite UI**: `packages/matrix-invite/` only generates matrix.to share links.
- **Domains**: Configs reference `matrix.twake.app`, `sign-up.twake.app`, `push.twake.app`, etc.
- **Push**: No ntfy integration.

### Frontend (`/Users/liberyus/development/dedi`)
- **Login**: WebView SSO (`login_view.dart`) targets `sign-up.twake.app`.
- **Session**: Matrix SDK persistence exists but WebView runs on every launch.
- **Hosts**: Hard-coded URLs for Matrix, identity, push, policy/support.
- **Push**: Background push gateway defaults to `push.twake.app`.

## 2. Domain Migration Map

| Service            | Current Host             | Target Host                  |
|--------------------|--------------------------|------------------------------|
| Matrix homeserver  | `matrix.twake.app`       | `matrix.dedim.com.tr`        |
| Identity server    | `identity.twake.app` (*) | `identity.dedim.com.tr`      |
| Chat web           | `chat.twake.app`         | `chat.dedim.com.tr`          |
| Registration/QR    | `sign-up.twake.app`      | `sign-up.dedim.com.tr`       |
| Push gateway       | `push.twake.app`         | `notification.dedim.com.tr`  |
| Policy/support     | `twake.app/...`          | `dedim.com.tr/...`           |

(*) Identity host inferred from configs.

CI will fail if non-`dedim.com.tr` hosts remain after migration.

## 3. OTP Strategy Decision

- **Finding**: No reusable MSISDN OTP workflow in the repo.
- **Decision**: Proceed with **Plan B (Thin glue)**—create `packages/msisdn-auth/` exposing `/otp/request`, `/otp/verify`, and `/otp/matrix-token` that orchestrate existing identity components with minimal state (e.g., Redis-backed sessions) and normalize responses for mobile.

## 4. Multi-Provider SMS Plan

1. Remove Octopush usage from `@twake/matrix-identity-server`.
2. Introduce a provider-agnostic stack:
   - `SMSProvider` interface
   - Providers: Turkcell MesajÜssü v2, NetGSM, İletiMerkezi, Twilio
   - `MultiProvider` honoring env-ordered priorities (`SMS_PROVIDERS=turkcell,netgsm,...`) with fallback on transient errors only.
3. Bridge existing invite/OTP flows through `MultiProvider` without changing their public APIs.

## 5. Client Login Flow Plan

1. Implement native screens: `Splash`, `Onboarding`, `PhoneInput`, `OTPVerify`.
2. GoRouter: `/splash → /onboarding? → /phone-input → /otp-verify → /rooms`.
3. Persist onboarding/login flags via `shared_preferences` so OTP is prompted only once.
4. Remove WebView SSO and rely on Matrix SDK session persistence.

## 6. Push Migration Plan

- Deploy `ntfy` (`notification.dedim.com.tr`).
- Backend helper to publish notifications.
- Flutter client subscribes via WebSocket/SSE and displays native notifications (Firebase removed).

## 7. Documentation & Tests

- Add `docs/SMS_PROVIDERS.md`, `docs/FRONTEND_FLOW.md`, and `openapi/otp.yaml` if the adapter publishes new routes.
- Jest: provider fallback logic, token cache, OTP adapter.
- Flutter widget tests: onboarding skip, OTP persistence, relaunch → Rooms.
- CI grep ensures only `*.dedim.com.tr` domains remain.

## 8. Execution Steps

1. Centralize and migrate domains in Flutter/server configs.
2. Build native login flow with persistence.
3. Create `packages/msisdn-auth/` (Plan B) and integrate.
4. Implement Multi-Provider SMS stack replacing Octopush.
5. Integrate ntfy push.
6. Update docs/tests/CI.
