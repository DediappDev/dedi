# OTP → Matrix Login Manual Test

1) Configure Synapse for JWT login (org.matrix.login.jwt):
   - Edit `homeserver.yaml` and add the snippet from `../dedi-server/docs/synapse_jwt_login_snippet.yaml`.
   - Set `secret` to the same value as env `SYNAPSE_JWT_SECRET` (or `MATRIX_JWT_SECRET`) for `dedi-server`.
   - Restart Synapse: `sudo systemctl restart matrix-synapse`.

2) Configure DEDI Server environment:
   - Set `SYNAPSE_JWT_SECRET` to the same secret above.
   - Optionally configure SMS providers or run in dev (OTP shown in response).

3) Mobile app flow (debug):
   - Launch the app.
   - Enter phone in E.164 Turkish format: `+9055XXXXXXXX`.
   - Request OTP. In dev, the code appears as `dev_otp`.
   - Enter the 6‑digit code.
   - App exchanges OTP → opaque JWT → Matrix login JWT, then POSTs login (m.login.token flow using the returned token).

4) Expected result:
   - No error: `Server supports the Login Types: {m.login.application_service}`.
   - App navigates to rooms and remains logged in across restarts.

Troubleshooting:
- If you see the application_service login error, enable JWT login in Synapse.
- If token login fails, ensure `SYNAPSE_JWT_SECRET` matches homeserver.yaml `secret` and device time is correct.
