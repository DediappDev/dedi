# DEDI Client Environment Setup Guide

## Overview
This guide helps developers set up the DEDI Client development environment for Flutter development.

## Prerequisites

### Required Software
- **Flutter SDK**: 3.24.x or later
- **Dart SDK**: 3.3.0 or later
- **Android Studio**: Latest version
- **Xcode**: Latest version (for iOS development)
- **VS Code**: Latest version (recommended)
- **Git**: Latest version

### Platform-Specific Requirements

#### Android Development
- **Android SDK**: API level 21 or higher
- **Android Studio**: With Android SDK tools
- **Java**: JDK 11 or later

#### iOS Development
- **Xcode**: Latest version
- **iOS Simulator**: Latest version
- **CocoaPods**: Latest version

#### Web Development
- **Chrome**: Latest version
- **Web server**: For testing

#### Desktop Development
- **Linux**: For Linux builds
- **macOS**: For macOS builds
- **Windows**: For Windows builds

## Environment Setup

### 1. Flutter Installation

```bash
# Download Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
cd flutter

# Add to PATH
export PATH="$PATH:`pwd`/bin"

# Verify installation
flutter doctor
```

### 2. Project Setup

```bash
# Clone the repository
git clone https://github.com/dediapp/dedi.git
cd dedi

# Install dependencies
flutter pub get

# Verify setup
flutter doctor
```

### 3. Configuration

#### Environment Variables
Create `.env` file in project root:

```bash
# API Configuration
DEDI_API_BASE_URL=https://api.dedim.com.tr
DEDI_HOMESERVER_URL=https://matrix.dedim.com.tr

# SMS Configuration
SMS_PROVIDER_ORDER=Turkcell,NetGSM,IletiMerkezi,TurkTelekom,Twilio

# Development
FLUTTER_ENV=development
DEBUG_MODE=true
```

#### Configuration Files

**File:** `config.json`
```json
{
  "app_name": "Dedi Chat",
  "homeserver_url": "https://matrix.dedim.com.tr",
  "api_base_url": "/_dedi/app/v1",
  "identity_api_url": "/_dedi/identity/v1",
  "sms_providers": {
    "primary": "Turkcell",
    "fallback": ["NetGSM", "IletiMerkezi", "TurkTelekom", "Twilio"]
  }
}
```

### 4. Platform Setup

#### Android Setup
```bash
# Install Android SDK
# Open Android Studio
# Install Android SDK through SDK Manager

# Verify Android setup
flutter doctor --android-licenses
flutter doctor
```

#### iOS Setup
```bash
# Install Xcode from App Store
# Install iOS Simulator
# Install CocoaPods

# Verify iOS setup
flutter doctor
```

#### Web Setup
```bash
# Enable web support
flutter config --enable-web

# Verify web setup
flutter doctor
```

#### Desktop Setup
```bash
# Enable desktop support
flutter config --enable-linux-desktop
flutter config --enable-macos-desktop
flutter config --enable-windows-desktop

# Verify desktop setup
flutter doctor
```

## Development Workflow

### 1. Daily Development
```bash
# Start development
fvm flutter pub get
fvm flutter run

# Run tests
fvm flutter test

# Run integration tests
fvm flutter test integration_test/
```

### 2. Building for Platforms
```bash
# Android
fvm flutter build apk
fvm flutter build appbundle

# iOS
fvm flutter build ios
fvm flutter build ipa

# Web
fvm flutter build web

# Desktop
fvm flutter build linux
fvm flutter build macos
fvm flutter build windows
```

### 3. Testing
```bash
# Unit tests
fvm flutter test

# Integration tests
fvm flutter test integration_test/

# Widget tests
fvm flutter test test/widget/

# Platform-specific tests
fvm flutter test test/android/
fvm flutter test test/ios/
fvm flutter test test/web/
```

## Environment Variables

### Development Environment
```bash
# .env.development
FLUTTER_ENV=development
DEBUG_MODE=true
API_BASE_URL=https://dev-api.dedim.com.tr
HOMESERVER_URL=https://dev-matrix.dedim.com.tr
```

### Testflight Environment
```bash
# .env.testflight
FLUTTER_ENV=testflight
DEBUG_MODE=false
API_BASE_URL=https://testflight-api.dedim.com.tr
HOMESERVER_URL=https://testflight-matrix.dedim.com.tr
```

### Production Environment
```bash
# .env.production
FLUTTER_ENV=production
DEBUG_MODE=false
API_BASE_URL=https://api.dedim.com.tr
HOMESERVER_URL=https://matrix.dedim.com.tr
```

## Configuration Management

### Environment-Specific Configs

**File:** `lib/config/environment.dart`
```dart
class Environment {
  static const String development = 'development';
  static const String testflight = 'testflight';
  static const String production = 'production';
  
  static String get current => 
    const String.fromEnvironment('FLUTTER_ENV', defaultValue: development);
  
  static bool get isDevelopment => current == development;
  static bool get isTestflight => current == testflight;
  static bool get isProduction => current == production;
}
```

### Configuration Loading

**File:** `lib/config/app_config.dart`
```dart
class AppConfig {
  static String get apiBaseUrl {
    switch (Environment.current) {
      case Environment.development:
        return 'https://dev-api.dedim.com.tr';
      case Environment.testflight:
        return 'https://testflight-api.dedim.com.tr';
      case Environment.production:
        return 'https://api.dedim.com.tr';
      default:
        return 'https://dev-api.dedim.com.tr';
    }
  }
}
```

## Troubleshooting

### Common Issues

#### Flutter Doctor Issues
```bash
# Fix Android licenses
flutter doctor --android-licenses

# Fix iOS issues
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

# Fix web issues
flutter config --enable-web
```

#### Build Issues
```bash
# Clean build
fvm flutter clean
fvm flutter pub get

# Rebuild
fvm flutter build apk
```

#### Dependency Issues
```bash
# Update dependencies
fvm flutter pub upgrade

# Check for conflicts
fvm flutter pub deps
```

### Platform-Specific Issues

#### Android Issues
- **Gradle issues**: Update Gradle version
- **SDK issues**: Update Android SDK
- **Build issues**: Clean and rebuild

#### iOS Issues
- **Xcode issues**: Update Xcode
- **Simulator issues**: Reset simulator
- **Build issues**: Clean and rebuild

#### Web Issues
- **Chrome issues**: Update Chrome
- **Build issues**: Clean and rebuild
- **CORS issues**: Check server configuration

## Best Practices

### Code Organization
- Use feature-based folder structure
- Keep platform-specific code separate
- Use dependency injection
- Follow Flutter/Dart conventions

### Testing
- Write unit tests for business logic
- Write widget tests for UI components
- Write integration tests for user flows
- Test on all platforms

### Performance
- Use const constructors where possible
- Avoid unnecessary rebuilds
- Optimize images and assets
- Monitor memory usage

### Security
- Never commit secrets
- Use environment variables for sensitive data
- Validate all inputs
- Use secure communication (HTTPS)

## Support

### Documentation
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [DEDI Client Documentation](./docs/)

### Community
- [Flutter Community](https://flutter.dev/community)
- [Dart Community](https://dart.dev/community)

### Support
- **Development Team**: dev@dedim.com.tr
- **Server Team**: server@dedim.com.tr
- **Support**: support@dedim.com.tr
