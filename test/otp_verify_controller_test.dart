import 'package:flutter_test/flutter_test.dart';
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluffychat/pages/phone_auth/otp_verify/otp_verify_controller.dart';
import 'package:fluffychat/services/models/otp_responses.dart';
import 'package:fluffychat/state/auth_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const otpVerifyResponse = OTPVerifyResponse(
    accessToken: 'jwt-token',
    userId: '@user:dedim.com.tr',
    mxid: '@user:dedim.com.tr',
    expiresIn: 300,
  );

  const matrixResponse = MatrixTokenResponse(
    accessToken: 'matrix-token',
    userId: '@user:dedim.com.tr',
    homeserver: 'https://matrix.dedim.com.tr',
    deviceId: 'DEVICE',
  );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('does not authenticate when token validation fails', () async {
    final auth = AuthStore();
    final client = Client('test-client');

    final controller = OTPVerifyController(
      phoneNumber: '+905551234567',
      matrixClient: client,
      authStore: auth,
      startSyncOnAuth: false,
      verifyOtpFn: (_, __) async => otpVerifyResponse,
      matrixTokenFn: (_, __) async => matrixResponse,
      hydrateFn: ({
        required Client client,
        required String homeserverBaseUrl,
        required String userId,
        required String accessToken,
        String? deviceId,
        bool verifyHomeserver = false,
        bool startSync = false,
      }) async {
        client.accessToken = accessToken;
        client.homeserver = Uri.parse(homeserverBaseUrl);
        return client;
      },
      validateTokenFn: (_) async => false,
      saveCredentialsFn: (_, {clientName}) async {},
      clearCredentialsFn: () async {},
    );

    final success = await controller.verifyOTP('123456');

    expect(success, isFalse);
    expect(auth.state, isNot(AuthState.authenticated));

    controller.dispose();
  });

  test('authenticates only after successful token validation', () async {
    var credentialsSaved = false;
    final auth = AuthStore();
    final client = Client('test-client');

    final controller = OTPVerifyController(
      phoneNumber: '+905551234567',
      matrixClient: client,
      authStore: auth,
      startSyncOnAuth: false,
      verifyOtpFn: (_, __) async => otpVerifyResponse,
      matrixTokenFn: (_, __) async => matrixResponse,
      hydrateFn: ({
        required Client client,
        required String homeserverBaseUrl,
        required String userId,
        required String accessToken,
        String? deviceId,
        bool verifyHomeserver = false,
        bool startSync = false,
      }) async {
        client.accessToken = accessToken;
        client.homeserver = Uri.parse(homeserverBaseUrl);
        return client;
      },
      validateTokenFn: (_) async => true,
      saveCredentialsFn: (_, {clientName}) async => credentialsSaved = true,
      clearCredentialsFn: () async {},
    );

    final success = await controller.verifyOTP('123456');

    expect(success, isTrue);
    expect(auth.state, AuthState.authenticated);
    expect(credentialsSaved, isTrue);
    expect(auth.userId, matrixResponse.userId);

    controller.dispose();
  });
}
