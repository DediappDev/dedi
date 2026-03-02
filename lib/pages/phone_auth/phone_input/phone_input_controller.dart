import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fluffychat/domain/exception/auth/otp_exceptions.dart';
import 'package:fluffychat/services/otp_api_service.dart';
import 'package:fluffychat/services/models/otp_responses.dart';

/// State model for phone input screen
@immutable
class PhoneInputState {
  /// Whether an OTP request is in progress
  final bool isLoading;

  /// Error message to display (null if no error)
  final String? errorMessage;

  /// Current phone number value
  final String phoneNumber;

  /// Whether the phone number is valid
  final bool isValid;

  const PhoneInputState({
    this.isLoading = false,
    this.errorMessage,
    this.phoneNumber = '',
    this.isValid = false,
  });

  /// Creates a copy of this state with the given fields replaced
  PhoneInputState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? phoneNumber,
    bool? isValid,
  }) {
    return PhoneInputState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneInputState &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.phoneNumber == phoneNumber &&
        other.isValid == isValid;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        errorMessage.hashCode ^
        phoneNumber.hashCode ^
        isValid.hashCode;
  }

  @override
  String toString() {
    return 'PhoneInputState(isLoading: $isLoading, hasError: ${errorMessage != null}, phoneNumber: $phoneNumber, isValid: $isValid)';
  }
}

/// Controller for phone input screen
///
/// Handles phone number validation and OTP request logic.
/// Separates business logic from UI for better testability.
class PhoneInputController extends ChangeNotifier {
  PhoneInputState _state = const PhoneInputState();

  /// Current state of the phone input
  PhoneInputState get state => _state;

  /// Update phone number and validation status
  ///
  /// Called when the user types or changes the phone number.
  /// [phone] is the new phone number value
  /// [isValid] indicates if the phone number is valid
  void updatePhoneNumber(String phone, bool isValid) {
    _state = _state.copyWith(
      phoneNumber: phone,
      isValid: isValid,
      errorMessage: null, // Clear error when user types
    );
    notifyListeners();
  }

  /// Send OTP to the current phone number
  ///
  /// Returns [OTPRequestResponse] on success, null on failure.
  /// Updates state with loading/error information.
  Future<OTPRequestResponse?> sendOTP() async {
    // Validate phone before sending
    if (!_state.isValid || _state.phoneNumber.isEmpty) {
      _state = _state.copyWith(
        errorMessage: 'Please enter a valid phone number',
      );
      notifyListeners();
      return null;
    }

    // Set loading state
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      // Call API service
      final response = await OTPApiService.requestOTP(_state.phoneNumber);

      // Success - clear loading state
      _state = _state.copyWith(isLoading: false);
      notifyListeners();

      if (kDebugMode) {
        debugPrint('✅ OTP sent successfully to ${_state.phoneNumber}');
        if (response.devOTP != null) {
          debugPrint('📱 Dev OTP: ${response.devOTP}');
        }
      }

      return response;
    } on OTPRateLimitException catch (e) {
      // Rate limit error - show countdown
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Too many attempts. Wait ${e.retryAfterSeconds} seconds.',
      );
      notifyListeners();

      if (kDebugMode) {
        debugPrint('⚠️ Rate limit hit: ${e.retryAfterSeconds}s');
      }

      return null;
    } on OTPNetworkException catch (e) {
      // Network error - show connection error
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Connection error. Check your internet.',
      );
      notifyListeners();

      if (kDebugMode) {
        debugPrint('❌ Network error: ${e.message}');
      }

      return null;
    } on OTPTimeoutException catch (e) {
      // Timeout error
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Request timed out. Please try again.',
      );
      notifyListeners();

      if (kDebugMode) {
        debugPrint('⏰ Timeout: ${e.message}');
      }

      return null;
    } on InvalidPhoneNumberException catch (e) {
      // Invalid phone number format
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
      notifyListeners();

      if (kDebugMode) {
        debugPrint('❌ Invalid phone: ${e.message}');
      }

      return null;
    } catch (e) {
      // Unexpected error
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to send code. Please try again.',
      );
      notifyListeners();

      if (kDebugMode) {
        debugPrint('❌ Unexpected error: $e');
      }

      return null;
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
      debugPrint('🗑️ PhoneInputController disposed');
    }
    super.dispose();
  }
}
