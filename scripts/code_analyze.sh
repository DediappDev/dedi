#!/bin/sh -ve
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
./scripts/check_domains.sh
dart format --set-exit-if-changed lib/ test/
flutter analyze
