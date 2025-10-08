# Repository Guidelines

## Project Structure & Module Organization
The Flutter client lives in `lib/`, with configuration under `lib/config`, shared helpers in `lib/utils`, feature controllers and views sorted into `lib/pages`, and reusable UI in `lib/widgets`. Tests sit beside features in `test/`, while scenario flows use `integration_test/` and driver harnesses in `test_driver/`. Native wrappers (`android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/`, `winuwp/`) consume shared resources from `assets/`. Automation scripts reside in `scripts/`, long-form docs and ADRs in `docs/`, and localized strings use the Flutter `l10n` toolchain configured in `l10n.yaml`.

## Build, Test, and Development Commands
- `flutter pub get`: syncs package dependencies after editing `pubspec.yaml`.
- `flutter pub run build_runner build --delete-conflicting-outputs`: regenerates codegen artifacts and clears stale outputs.
- `flutter run -d <device>`: launches the app; pass `chrome` for the web shell or an emulator ID for mobile.
- `dart analyze` or `scripts/code_analyze.sh`: enforces repository lint rules before committing.
- `flutter build apk --release` or platform helpers in `scripts/`: mirrors CI release builds when validating platform changes.

## Coding Style & Naming Conventions
Follow `docs/code_style.md`: controllers manage state, views remain declarative, and heavy logic moves into helpers. Dart files use `snake_case.dart`; widgets end with `View`, controllers with `Controller`. Keep analyzer warnings at zero, run `dart format lib test`, and prefer dependency injection to singletons. Extract deeply nested UI into dedicated widgets under `lib/widgets/` to maintain readability.

## Testing Guidelines
Write unit and widget specs alongside the feature using `*_test.dart`. Run `flutter test --coverage` before submitting; keep coverage stable when adding features. Use `scripts/integration_test_patrol.sh` for patrol scenarios after preparing the target device with `integration-prepare-*.sh`. Document unusual fixtures or credentials in `docs/` so teammates can reproduce results.

## Commit & Pull Request Guidelines
Prefix commits with the ticket (for example, `TW-2564: Fix chat system events`) and keep messages imperative. Update `CHANGELOG.md` when behavior shifts for users. Pull requests should link the issue, describe verification steps, call out impacted platforms, and include screenshots or recordings for UI changes. Request reviews from the owning squad and wait for green CI before merging.

## Security & Configuration Tips
Never commit secrets; copy `config.sample.json` to `config.json` locally and store credentials in secure keychains. Validate authentication flows against staging homeservers, and coordinate sensitive fixes with the core team before disclosure or release.
