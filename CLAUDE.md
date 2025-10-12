# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Dedi (formerly Twake Chat)** - An open-source Matrix protocol-based chat application built with Flutter. Uses clean architecture with feature-based organization and MVC pattern.

### 🎉 Migration Status: COMPLETED (October 9, 2025)

**Project successfully migrated from Twake Chat to dedim.com.tr infrastructure:**
- ✅ **Domain centralization** to `*.dedim.com.tr`
- ✅ **Native login flow** implemented (4 new screens)
- ✅ **SMS provider refactor** (Octopush → MultiProvider with Turkish carriers)
- ✅ **Production ready** with comprehensive documentation

**See `docs/MIGRATION_ACHIEVEMENTS.md` for complete implementation details.**

## Development Setup

### Prerequisites
- Flutter 3.27.4 (managed via FVM)
- Use `.fvmrc` file for version consistency
- Config file: Copy `config.sample.json` to `config.json` (gitignored)

### Initial Setup
```bash
# Install dependencies
flutter pub get

# Generate code (required for json_serializable, hive)
flutter pub run build_runner build --delete-conflicting-outputs

# Install pre-commit hooks
bash scripts/config-pre-commit.sh
```

## Common Development Commands

### Running the App
```bash
# Web (Chrome recommended)
flutter run -d chrome

# Mobile/Desktop
flutter devices                    # List available devices
flutter run -d <device-id>        # Run on specific device
```

### Code Generation & Quality
```bash
# Generate code (after model changes)
flutter pub run build_runner build --delete-conflicting-outputs

# Format and analyze
dart format lib test
dart analyze
# Or use the script
./scripts/code_analyze.sh
```

### Testing
```bash
# Unit/widget tests
flutter test --coverage

# Integration tests (Patrol framework)
./scripts/integration_test_patrol.sh
```

### Building
```bash
# Android
./scripts/build-android-debug.sh    # Debug APK
./scripts/build-android-apk.sh      # Release APK

# iOS
./scripts/build-ios.sh

# Web
./scripts/build-web.sh

# Desktop
./scripts/build-linux-debug.sh
./scripts/build-macos-debug.sh
./scripts/build-windows-debug.sh
```

## Architecture Overview

### Clean Architecture Structure
```
lib/
├── domain/          # Business logic (entities, repositories, use cases)
├── data/            # Data layer (APIs, local storage, repository implementations)
├── presentation/    # UI logic (mixins, extensions, state)
├── pages/           # Feature modules with MVC pattern
├── widgets/         # Reusable UI components
├── config/          # App configuration and routing
├── di/              # Dependency injection (GetIt)
└── utils/           # Utilities and helpers
```

### Key Patterns
- **Dependency Injection**: GetIt service locator pattern
- **State Management**: Provider pattern with custom controllers
- **Routing**: go_router with declarative navigation
- **Feature Organization**: Each feature has `*_view.dart` (UI) and `*_controller.dart` (logic)

### Phone Authentication Flow
- **Native screens**: Splash → Onboarding → Phone Input → OTP Verification → Matrix login
- **Persistent state**: SharedPreferences for one-time onboarding
- **Turkish localization**: Complete Turkish phone number validation (+90 5XX XXX XX XX)
- **Matrix integration**: JWT token exchange with full Matrix SDK login

### Data Layer
- **Local Storage**: Hive key-value database
- **HTTP Client**: Dio with caching interceptors
- **Matrix SDK**: Custom Linagora fork for Matrix protocol
- **Network APIs**: REST endpoints for ToM/Matrix servers

## Important Files & Configurations

### Configuration Files
- `pubspec.yaml` - Flutter project configuration
- `config.json` - App settings (copy from `config.sample.json`)
- `analysis_options.yaml` - Lint rules and code style
- `l10n.yaml` - Localization settings (ARB files)
- `.fvmrc` - Flutter version pinning

### Build Scripts Location
- `scripts/` directory contains all build and CI scripts
- Platform-specific build scripts for Android, iOS, Web, Linux, macOS, Windows

## Testing Structure

### Unit & Widget Tests
- Location: `test/` directory
- Organized alongside features
- Mock client: `test/fake_client.dart`

### Integration Tests
- Location: `integration_test/` directory
- Framework: Patrol (enhanced Flutter integration testing)
- Test categories: contact, chat, chat_group, sending_message

## Platform-Specific Notes

### iOS
- Minimum iOS 13.0
- Extensions: Share Extension, Notification Service Extension
- CocoaPods for dependencies

### Android
- API levels 31-35
- Gradle 8.0+, Java 17
- NDK 26.1.10909125

### Web
- Chrome recommended
- Requires libolm JavaScript package
- HTTPS enforcement in production

## Development Guidelines

### Code Style
- File naming: `snake_case.dart`
- Views: End with `View`, stay declarative
- Controllers: End with `Controller`, manage state
- Zero analyzer warnings required

### Commit Messages
- Format: `TW-####: Description` (include ticket ID)
- Update `CHANGELOG.md` for user-facing changes

### Code Generation
- Required after changes to:
  - JSON serializable models
  - Hive type adapters
- Always run build_runner after model changes

## Matrix Protocol Integration

- Custom Matrix SDK fork from Linagora
- End-to-end encryption via Olm/Megolm
- Federation support with identity lookup
- WebRTC for voice/video calls (when enabled)

## Security & Storage

- **Never commit secrets** - use local `config.json`
- App lock with PIN/biometric authentication
- Keychain sharing between app and extensions (iOS)
- Encrypted local storage via Hive + encryption

## Task Master AI Instructions
**Import Task Master's development workflow commands and guidelines, treat as if import is in the main CLAUDE.md file.**
@./.taskmaster/CLAUDE.md
