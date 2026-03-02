import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:matrix/matrix.dart';

import 'package:fluffychat/domain/exception/auth/otp_exceptions.dart';
import 'package:fluffychat/services/otp_api_service.dart';
import 'package:fluffychat/services/models/otp_responses.dart';
import 'package:fluffychat/services/session_credentials_storage.dart';
import 'package:fluffychat/utils/matrix_session_hydrator.dart';
import 'package:fluffychat/state/auth_store.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/data/network/interceptor/authorization_interceptor.dart';

/// State model for OTP verification screen
@immutable
class OTPVerificationState {
  /// Whether verification is in progress
  final bool isLoading;

  /// Error message to display (null if no error)
  final String? errorMessage;

  /// Countdown for resend button (in seconds)
  final int resendCountdown;

  /// Whether resend button is enabled
  final bool canResend;

  /// Current OTP code value
  final String otpCode;

  const OTPVerificationState({
    this.isLoading = false,
    this.errorMessage,
    this.resendCountdown = 60,
    this.canResend = false,
    this.otpCode = '',
  });

  /// Creates a copy of this state with the given fields replaced
  OTPVerificationState copyWith({
    bool? isLoading,
    String? errorMessage,
    int? resendCountdown,
    bool? canResend,
    String? otpCode,
  }) {
    return OTPVerificationState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      canResend: canResend ?? this.canResend,
      otpCode: otpCode ?? this.otpCode,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OTPVerificationState &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.resendCountdown == resendCountdown &&
        other.canResend == canResend &&
        other.otpCode == otpCode;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        errorMessage.hashCode ^
        resendCountdown.hashCode ^
        canResend.hashCode ^
        otpCode.hashCode;
  }

  @override
  String toString() {
    return 'OTPVerificationState(isLoading: $isLoading, hasError: ${errorMessage != null}, resendCountdown: $resendCountdown, canResend: $canResend)';
  }
}

/// Controller for OTP verification screen
///
/// Handles the complete authentication flow:
/// 1. Verify OTP and get JWT token
/// 2. Exchange JWT for Matrix access token
/// 3. Hydrate Matrix session
/// 4. **VALIDATE TOKEN (RE-ENABLED!)**
/// 5. Save credentials
/// 6. Update auth state
/// 7. Mark onboarding as done
class OTPVerifyController extends ChangeNotifier {
  OTPVerificationState _state = const OTPVerificationState();
  Timer? _resendTimer;

  /// Phone number for this verification session
  final String phoneNumber;

  /// Development OTP code (only in dev mode)
  final String? devOTP;

  /// Matrix client to initialize
  final Client matrixClient;

  /// Central auth store (provided from widget tree)
  final AuthStore authStore;
  final bool startSyncOnAuth;

  late final Future<OTPVerifyResponse> Function(String phoneNumber, String code)
      _verifyOtpFn;
  late final Future<MatrixTokenResponse> Function(
    String jwtToken,
    String phoneNumber,
  ) _matrixTokenFn;
  late final Future<Client> Function({
    required Client client,
    required String homeserverBaseUrl,
    required String userId,
    required String accessToken,
    String? deviceId,
    bool verifyHomeserver,
    bool startSync,
  }) _hydrateFn;
  late final Future<bool> Function(Client client) _validateTokenFn;
  late final Future<void> Function(
    SessionCredentials credentials, {
    String? clientName,
  }) _saveCredentialsFn;
  late final Future<void> Function() _clearCredentialsFn;

  OTPVerifyController({
    required this.phoneNumber,
    required this.matrixClient,
    required this.authStore,
    this.devOTP,
    this.startSyncOnAuth = true,
    Future<OTPVerifyResponse> Function(String phoneNumber, String code)?
        verifyOtpFn,
    Future<MatrixTokenResponse> Function(String jwtToken, String phoneNumber)?
        matrixTokenFn,
    Future<Client> Function({
      required Client client,
      required String homeserverBaseUrl,
      required String userId,
      required String accessToken,
      String? deviceId,
      bool verifyHomeserver,
      bool startSync,
    })? hydrateFn,
    Future<bool> Function(Client client)? validateTokenFn,
    Future<void> Function(
      SessionCredentials credentials, {
      String? clientName,
    })? saveCredentialsFn,
    Future<void> Function()? clearCredentialsFn,
  }) {
    _verifyOtpFn = verifyOtpFn ?? OTPApiService.verifyOTP;
    _matrixTokenFn = matrixTokenFn ?? OTPApiService.getMatrixToken;
    _hydrateFn = hydrateFn ?? MatrixSessionHydrator.fromAccessToken;
    _validateTokenFn =
        validateTokenFn ?? MatrixSessionHydrator.validateAccessToken;
    _saveCredentialsFn = saveCredentialsFn ?? SessionCredentialsStorage.save;
    _clearCredentialsFn = clearCredentialsFn ?? SessionCredentialsStorage.clear;

    _startResendCountdown();

    if (kDebugMode) {
      debugPrint('🔐 OTPVerifyController initialized');
      debugPrint('   - Phone: $phoneNumber');
      if (devOTP != null) {
        debugPrint('   - Dev OTP: $devOTP');
      }
    }
  }

  /// Current state of the verification
  OTPVerificationState get state => _state;

  /// Start or restart the resend countdown timer
  void _startResendCountdown() {
    _state = _state.copyWith(resendCountdown: 60, canResend: false);
    notifyListeners();

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_state.resendCountdown > 0) {
        _state = _state.copyWith(resendCountdown: _state.resendCountdown - 1);
        notifyListeners();
      } else {
        timer.cancel();
        _state = _state.copyWith(canResend: true);
        notifyListeners();
      }
    });
  }

  /// Verify the OTP code and complete authentication
  ///
  /// This is the main authentication flow that:
  /// 1. Verifies OTP and gets JWT
  /// 2. Exchanges JWT for Matrix token
  /// 3. Hydrates Matrix session
  /// 4. **VALIDATES TOKEN** (previously disabled, now re-enabled!)
  /// 5. Saves credentials
  /// 6. Updates AuthStore
  /// 7. Marks onboarding as done
  ///
  /// Returns true on success, false on failure.
  Future<bool> verifyOTP(String code) async {
    if (_state.isLoading) {
      if (kDebugMode) {
        debugPrint('⚠️ verifyOTP ignored: verification already in progress');
      }
      return false;
    }

    // Validate code length
    if (code.length != 6) {
      _state = _state.copyWith(
        errorMessage:
            'Please enter the complete 6-digit code', // Convert translation form
      );
      notifyListeners();
      return false;
    }

    // Set loading state
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      if (kDebugMode) {
        debugPrint('🔐 Step 1: Verifying OTP code...');
      }

      // Step 1: Verify OTP and get JWT token
      final authData = await _verifyOtpFn(phoneNumber, code);

      if (kDebugMode) {
        debugPrint('✅ Step 1 complete: JWT token received');
        debugPrint('   - User ID: ${authData.userId}');
        debugPrint('   - MXID: ${authData.mxid}');
        debugPrint('   - Expires in: ${authData.expiresIn}s');
      }

      if (kDebugMode) {
        debugPrint('🔑 Step 2: Exchanging JWT for Matrix token...');
      }

      // Step 2: Exchange JWT for Matrix access token
      final matrixToken =
          await _matrixTokenFn(authData.accessToken, phoneNumber);

      if (kDebugMode) {
        debugPrint('✅ Step 2 complete: Matrix token received');
        debugPrint('   - User ID: ${matrixToken.userId}');
        debugPrint('   - Homeserver: ${matrixToken.homeserver}');
        debugPrint('   - Device ID: ${matrixToken.deviceId}');
      }

      if (kDebugMode) {
        debugPrint('💧 Step 3: Hydrating Matrix session...');
      }

      // Step 3: Hydrate Matrix session
      await _hydrateFn(
        client: matrixClient,
        homeserverBaseUrl: matrixToken.homeserver,
        userId: matrixToken.userId,
        accessToken: matrixToken.accessToken,
        deviceId: matrixToken.deviceId,
        verifyHomeserver:
            false, // Skip homeserver verification to avoid .well-known issues
        startSync: false,
      );

      if (kDebugMode) {
        debugPrint('✅ Step 3 complete: Matrix session hydrated');
      }

      if (kDebugMode) {
        debugPrint('🔍 Step 4: Validating token with /whoami...');
        debugPrint('   ⚠️ TOKEN VALIDATION RE-ENABLED!');
        debugPrint('   This step was previously disabled but is now active.');
      }

      // Step 4: VALIDATE TOKEN (RE-ENABLED!)
      // This was disabled in the previous implementation (lines 209-226 of otp_verify_view.dart)
      // but is now re-enabled because the backend generates proper Matrix tokens
      final isValid = await _validateTokenFn(matrixClient);

      if (!isValid) {
        if (kDebugMode) {
          debugPrint(
            '❌ Step 4 failed: Token validation failed (M_UNKNOWN_TOKEN)',
          );
          debugPrint('   The Matrix server does not recognize this token.');
          debugPrint(
            '   This likely means the backend token generation is incorrect.',
          );
        }

        // Clear any stored credentials
        await _clearCredentialsFn();

        _state = _state.copyWith(
          isLoading: false,
          errorMessage: 'Token validation failed. Please contact support.',
        );
        notifyListeners();
        return false;
      }

      if (kDebugMode) {
        debugPrint('✅ Step 4 complete: Token is valid!');
        debugPrint('   Matrix server recognizes the token.');
      }

      // Prime AuthorizationInterceptor immediately
      try {
        getIt.get<AuthorizationInterceptor>().accessToken =
            matrixToken.accessToken;
      } catch (_) {}

      if (kDebugMode) {
        debugPrint('💾 Step 5: Saving credentials to secure storage...');
      }

      // Step 5: Save credentials for auto-login on app restart
      final normalizedHomeserver =
          matrixClient.homeserver?.toString() ?? matrixToken.homeserver;

      await _saveCredentialsFn(
        SessionCredentials(
          accessToken: matrixToken.accessToken,
          userId: matrixToken.userId,
          homeserver: normalizedHomeserver,
          deviceId: matrixToken.deviceId ?? matrixClient.deviceID,
        ),
        clientName: matrixClient.clientName,
      );

      if (kDebugMode) {
        debugPrint('✅ Step 5 complete: Credentials saved');
      }

      if (kDebugMode) {
        debugPrint('🔄 Step 6: Updating AuthStore...');
      }

      // Step 6: Update auth state
      await authStore.setAuthenticated(
        matrixClient,
        startSync: startSyncOnAuth,
        userId: matrixToken.userId,
      );

      if (kDebugMode) {
        debugPrint('✅ Step 6 complete: AuthStore updated');
      }

      if (kDebugMode) {
        debugPrint('🎯 Step 7: Marking onboarding as done...');
      }

      // Step 7: Mark onboarding as done (in case user skipped it or came from fresh install)
      await authStore.setOnboardingDone();

      if (kDebugMode) {
        debugPrint('✅ Step 7 complete: Onboarding marked as done');
        debugPrint('🎉 AUTHENTICATION COMPLETE!');
        debugPrint('   User is now authenticated and can access Matrix');
      }

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      return true;
    } on OTPInvalidException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Authentication failed: Invalid OTP code');
        debugPrint('   Error: ${e.message}');
      }

      _state = _state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
      notifyListeners();
      return false;
    } on OTPExpiredException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Authentication failed: OTP code expired');
        debugPrint('   Error: ${e.message}');
      }

      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Verification code has expired. Request a new code.',
      );
      notifyListeners();
      return false;
    } on MatrixTokenException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Authentication failed: Matrix token error');
        debugPrint('   Error: ${e.message}');
      }

      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Matrix connection error. Please try again.',
      );
      notifyListeners();
      return false;
    } on OTPNetworkException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Authentication failed: Network error');
        debugPrint('   Error: ${e.message}');
      }

      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Connection error. Check your internet.',
      );
      notifyListeners();
      return false;
    } on OTPTimeoutException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Authentication failed: Timeout');
        debugPrint('   Error: ${e.message}');
      }

      _state = _state.copyWith(
        isLoading: false,
        errorMessage:
            'Request timed out. Please try again.', // Convert translation form
      );
      notifyListeners();
      return false;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('❌ Authentication failed: Unexpected error');
        debugPrint('   Error: $e');
        debugPrint('   Stack trace: $stackTrace');
      }

      _state = _state.copyWith(
        isLoading: false,
        errorMessage:
            'Connection error. Please try again.', // Convert translation form
      );
      notifyListeners();
      return false;
    }
  }

  /// Resend OTP code
  ///
  /// Requests a new OTP code for the same phone number.
  /// Only works if [canResend] is true (countdown finished).
  Future<bool> resendOTP() async {
    if (!_state.canResend) {
      if (kDebugMode) {
        debugPrint('⚠️ Cannot resend: countdown still active');
      }
      return false;
    }

    try {
      if (kDebugMode) {
        debugPrint('📤 Resending OTP code to $phoneNumber');
      }

      await OTPApiService.requestOTP(phoneNumber);

      if (kDebugMode) {
        debugPrint('✅ OTP code resent successfully');
      }

      // Restart countdown
      _startResendCountdown();

      return true;
    } on OTPRateLimitException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Resend failed: Rate limit');
        debugPrint('   Retry after: ${e.retryAfterSeconds}s');
      }

      _state = _state.copyWith(
        errorMessage: 'Too many attempts. Wait ${e.retryAfterSeconds} seconds.',
      );
      notifyListeners();
      return false;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Resend failed: $e');
      }

      _state = _state.copyWith(
        errorMessage: 'Failed to send code. Please try again.',
      );
      notifyListeners();
      return false;
    }
  }

  /// Clear the current error message
  void clearError() {
    if (_state.errorMessage != null) {
      _state = _state.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      debugPrint('🗑️ OTPVerifyController disposed');
    }
    _resendTimer?.cancel();
    super.dispose();
  }
}
