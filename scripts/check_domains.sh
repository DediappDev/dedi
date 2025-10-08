#!/bin/sh
set -eu

SEARCH_PATHS="lib config.json config.sample.json scripts test integration_test"
EXCLUDE_OPTS="--exclude-dir=.git --exclude-dir=build --exclude-dir=.dart_tool --exclude-dir=.idea --exclude-dir=.vscode --exclude=coverage --exclude=pubspec.lock --exclude=scripts/check_domains.sh --exclude-dir=send_to_ai --exclude-dir=login_flow"

# Check for legacy Twake domains
for pattern in 'twake.app' 'matrix.twake.app' 'sign-up.twake.app' 'push.twake.app' 'chat.twake.app'; do
  if grep -R -nF "$pattern" $SEARCH_PATHS $EXCLUDE_OPTS >/dev/null 2>&1; then
    echo "Error: legacy domain $pattern detected. Please migrate to *.dedim.com.tr." >&2
    echo "Found in:"
    grep -R -nF "$pattern" $SEARCH_PATHS $EXCLUDE_OPTS
    exit 1
  fi
done

# Check for incorrect development domains
for pattern in 'useitsoon.com' 'dedi.useitsoon.com'; do
  if grep -R -nF "$pattern" $SEARCH_PATHS $EXCLUDE_OPTS >/dev/null 2>&1; then
    echo "Error: incorrect domain $pattern detected. Please use *.dedim.com.tr instead." >&2
    echo "Found in:"
    grep -R -nF "$pattern" $SEARCH_PATHS $EXCLUDE_OPTS
    exit 1
  fi
done

# Check for app scheme references that should be updated
if grep -R -nF "twake.chat://" $SEARCH_PATHS $EXCLUDE_OPTS >/dev/null 2>&1; then
  echo "Error: legacy app scheme 'twake.chat://' detected. Please use 'dedi://' instead." >&2
  echo "Found in:"
  grep -R -nF "twake.chat://" $SEARCH_PATHS $EXCLUDE_OPTS
  exit 1
fi

echo "✅ All domains check passed - only dedim.com.tr domains found"
exit 0
