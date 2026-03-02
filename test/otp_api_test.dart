import 'package:fluffychat/services/otp_api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OTP API integration (mock)', () {
    const phoneNumber = '+905551234567';

    test('Complete OTP flow using mock server', () async {
      final requestResponse = await OTPApiService.requestOTP(phoneNumber);
      expect(requestResponse.status, equals('sent'));
      expect(requestResponse.devOTP, isNotNull);
      expect(RegExp(r'^\d{6}$').hasMatch(requestResponse.devOTP!), isTrue);

      final verifyResponse =
          await OTPApiService.verifyOTP(phoneNumber, requestResponse.devOTP!);
      expect(verifyResponse.userId, contains(phoneNumber.replaceAll('+', '')));

      final jwtToken = verifyResponse.accessToken;
      expect(jwtToken.isNotEmpty, isTrue);

      final matrixResponse =
          await OTPApiService.getMatrixToken(jwtToken, phoneNumber);
      expect(matrixResponse.userId, verifyResponse.userId);
      expect(matrixResponse.accessToken.isNotEmpty, isTrue);
    });
  });
}
