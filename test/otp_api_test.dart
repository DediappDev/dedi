import 'package:dedi/services/otp_api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OTP API integration (mock)', () {
    const phoneNumber = '+905551234567';

    test('Complete OTP flow using mock server', () async {
      final requestResponse = await OTPApiService.requestOTP(phoneNumber);
      expect(requestResponse['status'], equals('sent'));
      expect(requestResponse['dev_otp'], equals('123456'));

      final verifyResponse =
          await OTPApiService.verifyOTP(phoneNumber, '123456');
      expect(verifyResponse['user_id'], contains(phoneNumber.replace('+', '')));

      final jwtToken = verifyResponse['access_token'] as String;
      expect(jwtToken, startsWith('mock_jwt_'));

      final matrixResponse =
          await OTPApiService.getMatrixToken(jwtToken, phoneNumber);
      expect(matrixResponse['user_id'], verifyResponse['user_id']);
      expect(matrixResponse['access_token'], startsWith('syt_'));
    });
  });
}
