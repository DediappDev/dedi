<!-- 77efee8f-c973-4445-8cb3-7b5580286979 12da1ecf-c0fa-4962-88b1-d23b2e198c60 -->
# Flutter ↔️ Docker Backend Connectivity Troubleshooting Plan

## Overview

Systematically diagnose and fix connectivity between the Flutter app (iOS Simulator) and local Docker backend, resolving DNS, TLS, and network issues to enable successful OTP login flow.

## Phase 1: Environment Discovery & Validation

### 1.1 Analyze Current Configuration

- Read `DEDI_URL_ANALYSIS.md` to identify all backend domains
- Read `ENVIRONMENT_SETUP.md` for SSL/TLS setup details
- Check current `/etc/hosts` configuration
- Identify iOS simulator device ID for testing

### 1.2 Docker Backend Status

- Check if Docker containers are running (`docker ps`)
- Verify HAProxy/reverse proxy container status
- Confirm port 443 is exposed and accessible
- Check Docker network configuration

## Phase 2: DNS & Network Resolution

### 2.1 Verify /etc/hosts Configuration

- Compare current `/etc/hosts` with domains from `DEDI_URL_ANALYSIS.md`
- Ensure all `*.dedim.com.tr` domains point to `127.0.0.1`
- Test DNS resolution from macOS host:
  ```bash
  ping auth.dedim.com.tr
  ping matrix.dedim.com.tr
  nslookup auth.dedim.com.tr
  ```


### 2.2 Simulator DNS Resolution

- iOS simulator inherits macOS network config
- Verify simulator can resolve domains (checked during app run)

## Phase 3: SSL/TLS Certificate Trust

### 3.1 Locate SSL Certificates

- Find root CA certificate in `.compose/ssl/` directory
- Identify `both.pem` or equivalent root cert
- Check if cert is self-signed or from local CA

### 3.2 macOS Keychain Trust

- Check if root CA exists in System Keychain:
  ```bash
  security find-certificate -a -c "dedim" ~/Library/Keychains/login.keychain-db
  security find-certificate -a -c "dedim" /Library/Keychains/System.keychain
  ```

- If missing, add to System Keychain:
  ```bash
  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain <cert.pem>
  ```


### 3.3 iOS Simulator Certificate Trust

- Copy root CA to simulator:
  ```bash
  SIMULATOR_ID=$(xcrun simctl list devices | grep Booted | grep -o '[0-9A-F-]\{36\}')
  xcrun simctl spawn booted curl -o /tmp/root-ca.pem https://host.local/root-ca.pem
  ```

- Or manually drag cert to simulator and trust it
- Verify trust settings in simulator Settings → General → About → Certificate Trust Settings

## Phase 4: TLS Handshake Validation

### 4.1 Test from macOS Host

```bash
# Test TLS connection
openssl s_client -connect auth.dedim.com.tr:443 -servername auth.dedim.com.tr < /dev/null

# Test HTTP response
curl -v -k https://auth.dedim.com.tr
curl -v -k https://matrix.dedim.com.tr
```

### 4.2 Test from Docker Network

```bash
# Inside proxy container
docker exec Dedi-Proxy curl -k https://auth.dedim.com.tr
docker exec Dedi-Proxy curl -k https://matrix.dedim.com.tr

# Check backend logs
docker logs Dedi-Proxy --tail 50
docker logs <auth-container> --tail 50
```

## Phase 5: Flutter App Configuration

### 5.1 Pre-flight Checks

```bash
cd /Users/liberyus/development/dedi

# Ensure dependencies are current
fvm flutter pub get

# Check for any Flutter configuration issues
fvm flutter doctor -v

# List available simulators
xcrun simctl list devices | grep iPhone
```

### 5.2 Review App Network Configuration

- Check if app has hardcoded URLs or config file
- Review `config.json` for backend URLs
- Ensure URLs match domains in `/etc/hosts`

### 5.3 Add Development SSL Override (if needed)

If cert trust fails, create temporary override:

```dart
// lib/main.dart or appropriate initialization file
import 'dart:io';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) {
        // Only bypass for local dev domains
        return host.endsWith('dedim.com.tr');
      };
  }
}

// In main():
void main() {
  if (kDebugMode) {
    HttpOverrides.global = DevHttpOverrides();
  }
  runApp(MyApp());
}
```

## Phase 6: Launch & Debug

### 6.1 Launch Flutter App

```bash
# Get simulator ID
SIMULATOR_ID=$(xcrun simctl list devices | grep "iPhone SE" | grep Booted | grep -o '[0-9A-F-]\{36\}' | head -1)

# If no simulator booted, boot one
xcrun simctl boot "iPhone SE (3rd generation)"

# Launch app with verbose logging
fvm flutter run -d $SIMULATOR_ID --verbose 2>&1 | tee flutter_run.log
```

### 6.2 Monitor Network Issues

Watch for these errors in logs:

- `SocketException: Failed host lookup`
- `HandshakeException`
- `CERTIFICATE_VERIFY_FAILED`
- `Connection refused`
- `Connection timeout`

### 6.3 Test OTP Login Flow

1. Enter phone number: +90 XXX XXX XXXX
2. Press "Get Verification Code"
3. Monitor:

   - Flutter console for network requests
   - Backend logs: `docker logs <auth-service> -f`
   - Network traffic (if using Charles Proxy)

Expected success:

- Network request sent to `https://auth.dedim.com.tr/api/otp/send`
- Response received with status 200
- OTP verification screen displayed

## Phase 7: Troubleshooting Matrix

### 7.1 Common Issues & Fixes

**Issue: DNS not resolving**

```bash
# Add/update /etc/hosts
sudo nano /etc/hosts
# Add:
127.0.0.1 auth.dedim.com.tr
127.0.0.1 matrix.dedim.com.tr
127.0.0.1 chat.dedim.com.tr
# ... all other domains
```

**Issue: Certificate trust failed**

```bash
# Reset simulator trust cache
xcrun simctl shutdown all
xcrun simctl erase all  # WARNING: Erases all simulator data
xcrun simctl boot "iPhone SE (3rd generation)"
```

**Issue: Backend not responding**

```bash
# Restart Docker stack
docker-compose down
docker-compose up -d

# Check HAProxy config
docker exec Dedi-Proxy cat /usr/local/etc/haproxy/haproxy.cfg
```

**Issue: Port conflicts**

```bash
# Check what's using port 443
sudo lsof -i :443
sudo lsof -i :80
```

### 7.2 Advanced Debugging

**Enable Flutter network logging:**

```bash
# Run with network debugging
fvm flutter run --observatory-port=8888 --disable-service-auth-codes
```

**Check simulator network from inside:**

```bash
# Open simulator shell
xcrun simctl spawn booted sh
ping auth.dedim.com.tr
curl -v https://auth.dedim.com.tr
```

## Phase 8: Verification & Testing

### 8.1 End-to-End Test

1. ✅ Docker backend running and healthy
2. ✅ DNS resolves all domains to 127.0.0.1
3. ✅ TLS handshake successful from macOS
4. ✅ Certificates trusted in System Keychain
5. ✅ Certificates trusted in iOS Simulator
6. ✅ Flutter app launches without errors
7. ✅ Phone number input works
8. ✅ OTP request succeeds
9. ✅ OTP verification screen shows
10. ✅ No network errors in logs

### 8.2 Document Solution

- Record working configuration
- Document certificate installation steps
- Note any iOS simulator specific quirks
- Save working `/etc/hosts` configuration

## Success Criteria

**Must Have:**

- ✅ App launches on iOS Simulator without network errors
- ✅ All `*.dedim.com.tr` domains resolve correctly
- ✅ TLS handshake completes successfully
- ✅ OTP SMS API call succeeds
- ✅ No `SocketException`, `HandshakeException`, or `CERT_VERIFY_FAILED`

**Validation:**

- Phone number → Get Code → OTP screen (full flow)
- Backend logs show successful API calls
- No SSL/TLS warnings in Flutter console

## Rollback Plan

If issues persist:

1. Document exact error messages
2. Capture network traces with Charles/Wireshark
3. Test with `curl` to isolate Flutter vs system issues
4. Consider using HTTP (not HTTPS) temporarily for debugging
5. Verify Docker backend works from Postman/Insomnia first

## Reference Files

- `DEDI_URL_ANALYSIS.md` - All backend domains
- `ENVIRONMENT_SETUP.md` - SSL and DNS configuration
- `config.json` - App backend URLs
- `.compose/ssl/both.pem` - SSL certificates
- `/etc/hosts` - DNS overrides

### To-dos

- [ ] Complete Git repository dependency inventory and create mirror script
- [ ] Complete Docker image inventory and create mirror script with REGISTRY_URL_PLACEHOLDER
- [ ] Analyze transitive dependencies (pub.dev, npm, maven, cocoapods) using dependency tree tools
- [ ] Configure private package registries on git.liberyus.com for all package types
- [ ] Execute git repository mirroring to git.liberyus.com
- [ ] Execute Docker image mirroring to private registry (pending devops URL)
- [ ] Mirror all pub.dev, npm, maven, and cocoapods packages to private registries
- [ ] Rewrite all configuration files (pubspec.yaml, Dockerfile, build.gradle, etc.) to use private sources
- [ ] Test all platform builds (web, android, ios) work completely offline
- [ ] Complete license compliance review for all mirrored dependencies
- [ ] Update project documentation with new private registry URLs and procedures