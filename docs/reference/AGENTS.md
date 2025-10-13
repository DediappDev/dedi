# Repository Guidelines

## Project Structure & Module Organization
- `lib/` hosts the Flutter client; feature bundles live under `modules/` and `pages/`, while shared utilities sit in `services/`, `di/`, and reusable widgets.
- Tests mirror the Dart layout inside `test/` and `integration_test/`; roadmap docs and flow specs stay in `docs/` and `login_flow/`.
- Platform shells reside in `android/`, `ios/`, `linux/`, `macos/`, `windows/`, and `web/`. Automation and release helpers are under `scripts/`.
- Assets, localization, and the web `js/package` bundle belong in `assets/`; rebuild libolm before launching the web target.

## Build, Test, and Development Commands
- `flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs` hydrates dependencies and refreshes generated code.
- `bash scripts/config-pre-commit.sh` installs the lint + hook stack used in CI.
- `flutter devices` followed by `flutter run -d chrome` starts a local debug session.
- `./scripts/build-web.sh`, `./scripts/build-android-apk.sh`, and platform peers create release artifacts with project defaults.

## Coding Style & Naming Conventions
- Follow Flutter defaults: 2-space indent, PascalCase for widgets/services, lowerCamelCase members, and `SCREAMING_SNAKE_CASE` constants.
- Run `dart format lib test integration_test` and avoid editing generated sources like `lib/l10n/**` or `**/*.g.dart`.
- `analysis_options.yaml` extends `flutter_lints`; fix issues flagged by `flutter analyze` instead of suppressing them.

## Testing Guidelines
- Unit specs live in `test/` and should end with `_test.dart`; integration flows live in `integration_test/` or Patrol scripts.
- Execute `flutter test` for fast feedback, `flutter test integration_test` for device suites, and add regression coverage with bug fixes.
- Produce coverage via `flutter test --coverage` when requested and share reports in review.

## Commit & Pull Request Guidelines
- Use Conventional Commit subjects (e.g., `feat(client): add room filter`) or ticket IDs, keeping messages under 72 characters.
- Ensure every commit passes `flutter analyze` and `flutter test`; rerun build_runner whenever generated files change.
- PRs should summarize scope, list automated/manual checks, link related issues, and include screenshots or recordings for UI updates.

## Security & Configuration Tips
- Copy `config.sample.json` to `config.json` before local runs or CI jobs and point it at the intended Matrix homeserver.
- Store secrets in local tooling or `.env`; never commit credentials. Rebuild libolm when web dependencies change and reset file ownership afterward.
