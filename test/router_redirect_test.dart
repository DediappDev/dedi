import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';

import 'package:fluffychat/config/go_routes/go_router.dart';
import 'package:fluffychat/state/auth_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppRouter.redirectFor', () {
    test('first run unauthenticated user is sent to onboarding', () async {
      final auth = AuthStore()
        ..state = AuthState.unauthenticated
        ..onboardingDone = false;

      final redirect =
          AppRouter.redirectFor(auth: auth, location: '/phone-input');

      expect(redirect, '/onboarding');
    });

    test('returning user without creds goes to phone-input', () async {
      final auth = AuthStore()
        ..state = AuthState.unauthenticated
        ..onboardingDone = true;

      final redirect = AppRouter.redirectFor(auth: auth, location: '/rooms');

      expect(redirect, '/phone-input');
    });

    test('authenticated user is routed to rooms from auth flow', () async {
      final auth = AuthStore()..onboardingDone = true;
      final client = Client('test');

      await auth.setAuthenticated(
        client,
        startSync: false,
        userId: '@user:dedim.com.tr',
      );

      final redirect =
          AppRouter.redirectFor(auth: auth, location: '/phone-input');

      expect(redirect, '/rooms');
    });
  });
}
