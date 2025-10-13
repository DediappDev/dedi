# Dedi Flutter Client - File Usage Analysis

## Overview
This document provides a comprehensive analysis of the Dedi Flutter client project, categorizing all files as either **active/required** by the app or **unused/removable**.

**Project Root:** `/Users/liberyus/development/dedi`  
**Analysis Date:** December 2024  
**Flutter Version:** 3.24.x  
**Dart SDK:** >=3.3.0

---

## ✅ Used / Required by App

### Core Application Files
- **`lib/main.dart`** - Application entry point, initializes Flutter bindings, Hive, GetIt, Matrix clients
- **`lib/widgets/twake_app.dart`** - Main app widget with routing, theming, localization
- **`lib/widgets/matrix.dart`** - Matrix client provider widget
- **`lib/widgets/lock_screen.dart`** - App lock screen widget
- **`pubspec.yaml`** - Dependencies, assets, fonts, and build configuration
- **`pubspec.lock`** - Locked dependency versions
- **`analysis_options.yaml`** - Dart/Flutter linting rules
- **`l10n.yaml`** - Localization configuration

### Configuration Files
- **`config.json`** - Production app configuration (homeserver, privacy URLs, etc.)
- **`config.sample.json`** - Sample configuration template
- **`lib/config/app_config.dart`** - App configuration constants and settings
- **`lib/config/environment.dart`** - Environment-specific configuration
- **`lib/config/setting_keys.dart`** - Shared preference keys
- **`lib/config/themes.dart`** - App theming configuration
- **`lib/config/go_routes/go_router.dart`** - Navigation routing configuration
- **`lib/config/localizations/localization_service.dart`** - Localization service

### Dependency Injection & Services
- **`lib/di/global/get_it_initializer.dart`** - GetIt dependency injection setup
- **`lib/di/global/`** (5 files) - Global dependency injection modules
- **`lib/di/base_di.dart`** - Base dependency injection interface
- **`lib/services/otp_api_service.dart`** - OTP API service

### Data Layer (111 files)
- **`lib/data/datasource/`** (17 files) - Data source interfaces
- **`lib/data/datasource_impl/`** (17 files) - Data source implementations
- **`lib/data/repository/`** (17 files) - Repository implementations
- **`lib/data/network/`** (25 files) - Network API clients and endpoints
- **`lib/data/hive/`** (10 files) - Hive database models and adapters
- **`lib/data/local/`** (7 files) - Local storage implementations
- **`lib/data/memory/`** (1 file) - In-memory data storage
- **`lib/data/model/`** (16 files) - Data transfer objects and models
- **`lib/data/extensions/`** (1 file) - Data layer extensions

### Domain Layer (195 files)
- **`lib/domain/app_state/`** (60 files) - Application state management
- **`lib/domain/model/`** (53 files) - Domain models and entities
- **`lib/domain/usecase/`** (52 files) - Business logic use cases
- **`lib/domain/repository/`** (17 files) - Repository interfaces
- **`lib/domain/exception/`** (7 files) - Domain-specific exceptions
- **`lib/domain/enums/`** (2 files) - Domain enumerations
- **`lib/domain/contact_manager/`** (1 file) - Contact management
- **`lib/domain/keychain_sharing/`** (3 files) - Keychain sharing functionality

### Presentation Layer (112 files)
- **`lib/presentation/mixins/`** (33 files) - Reusable presentation mixins
- **`lib/presentation/extensions/`** (16 files) - Presentation extensions
- **`lib/presentation/model/`** (35 files) - Presentation models
- **`lib/presentation/enum/`** (12 files) - Presentation enumerations
- **`lib/presentation/decorators/`** (7 files) - UI decorators
- **`lib/presentation/state/`** (2 files) - Presentation state management
- **`lib/presentation/style/`** (1 file) - Presentation styling
- **`lib/presentation/multiple_account/`** (2 files) - Multiple account handling
- **`lib/presentation/same_type_events_builder/`** (2 files) - Event builders

### Pages (429 files)
- **`lib/pages/chat/`** (130 files) - Chat functionality and UI
- **`lib/pages/chat_details/`** (61 files) - Chat details and settings
- **`lib/pages/settings_dashboard/`** (40 files) - Settings and preferences
- **`lib/pages/chat_list/`** (26 files) - Chat list and navigation
- **`lib/pages/search/`** (16 files) - Search functionality
- **`lib/pages/new_group/`** (15 files) - Group creation
- **`lib/pages/new_private_chat/`** (10 files) - Private chat creation
- **`lib/pages/forward/`** (10 files) - Message forwarding
- **`lib/pages/contacts_tab/`** (10 files) - Contacts management
- **`lib/pages/profile_info/`** (12 files) - User profile information
- **`lib/pages/phone_auth/`** (4 files) - Phone authentication
- **`lib/pages/twake_welcome/`** (3 files) - Welcome screens
- **`lib/pages/login/`** (3 files) - Login functionality
- **`lib/pages/homeserver_picker/`** (5 files) - Homeserver selection
- **`lib/pages/connect/`** (5 files) - Connection management
- **`lib/pages/auto_homeserver_picker/`** (4 files) - Auto homeserver detection
- **`lib/pages/bootstrap/`** (7 files) - App bootstrap and initialization
- **`lib/pages/device_settings/`** (3 files) - Device-specific settings
- **`lib/pages/error_page/`** (2 files) - Error handling
- **`lib/pages/image_viewer/`** (9 files) - Image viewing
- **`lib/pages/key_verification/`** (2 files) - Key verification
- **`lib/pages/invitation_selection/`** (3 files) - Invitation handling
- **`lib/pages/dialer/`** (3 files) - Voice calling
- **`lib/pages/chat_search/`** (3 files) - Chat search
- **`lib/pages/chat_permissions_settings/`** (3 files) - Chat permissions
- **`lib/pages/chat_encryption_settings/`** (2 files) - Encryption settings
- **`lib/pages/chat_profile_info/`** (4 files) - Chat profile information
- **`lib/pages/chat_adaptive_scaffold/`** (3 files) - Adaptive chat layout
- **`lib/pages/chat_blank/`** (3 files) - Blank chat state
- **`lib/pages/chat_draft/`** (8 files) - Draft message handling
- **`lib/pages/archive/`** (2 files) - Archive functionality
- **`lib/pages/app_grid/`** (7 files) - App grid dashboard
- **`lib/pages/add_story/`** (3 files) - Story creation
- **`lib/pages/story/`** (2 files) - Story viewing
- **`lib/pages/share/`** (2 files) - Content sharing
- **`lib/pages/sign_up/`** (2 files) - User registration
- **`lib/pages/splash/`** (1 file) - Splash screen
- **`lib/pages/multiple_accounts/`** (1 file) - Multiple account management

### Widgets (118 files)
- **`lib/widgets/`** - Reusable UI components and widgets

### Utilities (101 files)
- **`lib/utils/`** - Utility functions, extensions, helpers, and managers

### Modules (29 files)
- **`lib/modules/federation_identity_lookup/`** (18 files) - Federation identity lookup
- **`lib/modules/federation_identity_request_token/`** (11 files) - Federation token requests

### Event System (4 files)
- **`lib/event/`** - Event dispatching and handling

### App State (4 files)
- **`lib/app_state/`** - Application state management

### Migration (2 files)
- **`lib/migrate_steps/`** - Database migration steps

### Resources (3 files)
- **`lib/resource/image_paths.dart`** - Asset path constants
- **`lib/resource/assets_paths.dart`** - Asset path definitions
- **`lib/resource/colors.dart`** - Color constants

### Assets (Used)
- **`assets/google_fonts/`** (4 files) - Inter font family (Medium, Regular, SemiBold, Bold)
- **`assets/images/`** (57 files) - UI icons and images (SVG and PNG)
- **`assets/icons/icon_launcher.png`** - App launcher icon
- **`assets/l10n/`** (78 files) - Localization files (40 .arb, 38 .dart)
- **`assets/sounds/`** (3 files) - Audio files for notifications and calls
- **`assets/js/`** - JavaScript packages for web platform
- **`assets/logo.png`** - Main app logo
- **`assets/logo_ios.png`** - iOS-specific logo
- **`assets/logo.svg`** - SVG logo
- **`assets/branding.png`** - Branding image
- **`assets/verification.png`** - Verification background image
- **`assets/backup.png`** - Backup illustration
- **`assets/colors.png`** - Color palette image
- **`assets/lottie-chat.json`** - Chat loading animation
- **`assets/twake_loading.json`** - Loading animation
- **`assets/sas-emoji.json`** - SAS verification emojis
- **`assets/typing-indicator.zip`** - Typing indicator animation

### Platform-Specific Files
- **`android/`** - Android platform configuration and native code
- **`ios/`** - iOS platform configuration and native code
- **`web/`** - Web platform configuration
- **`linux/`** - Linux desktop platform configuration
- **`macos/`** - macOS desktop platform configuration
- **`windows/`** - Windows desktop platform configuration

### Test Files (69 files)
- **`test/`** - Unit tests and widget tests
- **`integration_test/`** - Integration tests
- **`test_driver/`** - Test driver configuration

---

## 🚫 Unused / Removable

### Documentation and Research Files
- **`docs/`** (entire directory) - Documentation, ADRs, guides, screenshots
  - **Reason:** Documentation only, not imported by app code
  - **Files:** 32 ADR files, implementation guides, configuration docs, screenshots
- **`send_to_ai/`** (entire directory) - AI analysis files and research
  - **Reason:** Research and analysis files, not used by app
  - **Files:** 34 files including code examples, config templates, research docs
- **`login_flow/`** (entire directory) - Login flow documentation and examples
  - **Reason:** Documentation and examples only, not imported by app
  - **Files:** API specs, code examples, implementation guides, troubleshooting

### Root Documentation Files
- **`AGENTS.md`** - Agent documentation
- **`API_MIGRATION_GUIDE.md`** - API migration documentation
- **`CHANGELOG.md`** - Version changelog
- **`CLAUDE.md`** - Claude AI documentation
- **`DEPLOYMENT_CHECKLIST.md`** - Deployment checklist
- **`ENVIRONMENT_SETUP.md`** - Environment setup guide
- **`PRIVACY.md`** - Privacy policy
- **`README.md`** - Project readme
- **`REFACTORING_QUICKSTART.md`** - Refactoring guide
- **`TESTFLIGHT_BRANDING_PLAN.md`** - TestFlight branding plan
- **`TRANSLATORS_GUIDE.md`** - Translation guide
- **`DEDI_URL_ANALYSIS.md`** - URL analysis document
- **`DEDI_FILE_USAGE_ANALYSIS.md`** - This analysis document

### Build and Development Tools
- **`appimage/`** (entire directory) - AppImage build configuration
  - **Reason:** Build tooling, not runtime dependencies
- **`fdroid/`** (entire directory) - F-Droid build configuration
  - **Reason:** Build tooling for F-Droid store
- **`fastlane/`** - Fastlane configuration (root level)
  - **Reason:** Build automation tooling
- **`scripts/`** (entire directory) - Build and utility scripts
  - **Reason:** Development and build scripts, not app dependencies
- **`server/`** (entire directory) - Server configuration
  - **Reason:** Server-side configuration, not client dependencies

### Development Environment Files
- **`devenv.lock`** - Development environment lock file
- **`devenv.nix`** - Nix development environment
- **`devenv.yaml`** - Development environment configuration
- **`Dockerfile`** - Docker container configuration
- **`login_flow.zip`** - Compressed login flow documentation

### Unused Platform Support
- **`winuwp/`** (entire directory) - Windows UWP platform support
  - **Reason:** UWP platform not actively used, legacy support

### Configuration Templates
- **`configurations/`** (entire directory) - Configuration templates
  - **Reason:** Template files, not runtime configuration
  - **Exception:** `configurations/icons/` contains icons referenced by `ImagePaths.getConfigurationImagePath()`

### Unused Assets
- **`assets/blur.png`** - Blur effect image (not referenced in code)
- **`assets/favicon.png`** - Web favicon (not used in mobile app)
- **`assets/info-logo.png`** - Info logo (not referenced in code)
- **`assets/share.png`** - Share icon (not referenced in code)
- **`assets/twake.svg`** - Twake SVG logo (not referenced in code)

### Unused Localization Files
- **`assets/l10n/l10n_*.dart`** (38 files) - Generated localization files
  - **Reason:** These are generated files, should be in `.gitignore` or build output
  - **Note:** The `.arb` files (40 files) are the source files and are required

---

## 🔍 Analysis Summary

### File Count Breakdown
- **Total Files Analyzed:** ~1,200+ files
- **Active/Required Files:** ~900+ files
- **Unused/Removable Files:** ~300+ files

### Key Findings

1. **Well-Structured Codebase:** The app follows clean architecture principles with clear separation between data, domain, and presentation layers.

2. **Comprehensive Testing:** Good test coverage with unit tests, widget tests, and integration tests.

3. **Documentation Heavy:** Significant amount of documentation and research files that could be moved to a separate docs repository.

4. **Platform Support:** Full multi-platform support (mobile, web, desktop) with platform-specific configurations.

5. **Asset Management:** Most assets are properly referenced through the `ImagePaths` class, with only a few unused assets.

6. **Build Tooling:** Extensive build and deployment tooling for various platforms and stores.

### Recommendations

1. **Move Documentation:** Consider moving `docs/`, `send_to_ai/`, and `login_flow/` to a separate documentation repository.

2. **Clean Up Assets:** Remove unused assets (`blur.png`, `favicon.png`, `info-logo.png`, `share.png`, `twake.svg`).

3. **Generated Files:** Ensure generated localization files are properly handled in build process.

4. **Legacy Support:** Consider removing `winuwp/` directory if UWP support is no longer needed.

5. **Build Scripts:** Keep build scripts in repository but consider organizing them better.

### Risk Assessment
- **Low Risk:** Removing documentation and research files
- **Medium Risk:** Removing unused assets (verify no runtime references)
- **High Risk:** Removing any files in `lib/`, `assets/` (except confirmed unused), or platform directories

This analysis provides a comprehensive view of the Dedi Flutter client's file usage, helping identify opportunities for cleanup while ensuring no critical files are removed.

