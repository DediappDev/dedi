/// Custom exceptions for OTP authentication flow
///
/// This file defines a hierarchy of exceptions that can occur during
/// phone-based OTP authentication, allowing for specific error handling
/// and appropriate user feedback.
library;

/// Base exception for all OTP-related errors
abstract class OTPException implements Exception {
  /// Human-readable error message
  final String message;

  /// Optional error code from the API
  final String? code;

  /// Optional HTTP status code
  final int? statusCode;

  const OTPException(this.message, {this.code, this.statusCode});

  @override
  String toString() => 'OTPException: $message';
}

/// Exception thrown when OTP request fails
///
/// This can occur when:
/// - Phone number format is invalid
/// - Server is unreachable
/// - API returns an error
class OTPRequestFailedException extends OTPException {
  const OTPRequestFailedException(
    super.message, {
    super.code,
    super.statusCode,
  });

  @override
  String toString() => 'OTPRequestFailedException: $message';
}

/// Exception thrown when OTP verification fails due to invalid code
///
/// This occurs when the user enters an incorrect OTP code
class OTPInvalidException extends OTPException {
  const OTPInvalidException(
    super.message, {
    super.code,
    super.statusCode,
  });

  @override
  String toString() => 'OTPInvalidException: $message';
}

/// Exception thrown when OTP code has expired
///
/// OTP codes typically expire after 5 minutes
class OTPExpiredException extends OTPException {
  const OTPExpiredException(
    super.message, {
    super.code,
    super.statusCode,
  });

  @override
  String toString() => 'OTPExpiredException: $message';
}

/// Exception thrown when rate limit is hit
///
/// This occurs when too many requests are made in a short time period.
/// The [retryAfterSeconds] field indicates how long to wait before retrying.
class OTPRateLimitException extends OTPException {
  /// Number of seconds to wait before retrying
  final int retryAfterSeconds;

  const OTPRateLimitException(
    super.message, {
    required this.retryAfterSeconds,
    super.code,
    super.statusCode,
  });

  @override
  String toString() =>
      'OTPRateLimitException: $message (retry after $retryAfterSeconds seconds)';
}

/// Exception thrown when network request fails
///
/// This can occur due to:
/// - No internet connection
/// - DNS resolution failure
/// - Connection timeout
class OTPNetworkException extends OTPException {
  const OTPNetworkException(
    super.message, {
    super.code,
    super.statusCode,
  });

  @override
  String toString() => 'OTPNetworkException: $message';
}

/// Exception thrown when request times out
///
/// This occurs when the server doesn't respond within the timeout period
class OTPTimeoutException extends OTPException {
  const OTPTimeoutException(
    super.message, {
    super.code,
    super.statusCode,
  });

  @override
  String toString() => 'OTPTimeoutException: $message';
}

/// Exception thrown when Matrix token exchange fails
///
/// This can occur when:
/// - JWT token is invalid or expired
/// - Matrix server is unreachable
/// - Token minting fails on backend
class MatrixTokenException extends OTPException {
  const MatrixTokenException(
    super.message, {
    super.code,
    super.statusCode,
  });

  @override
  String toString() => 'MatrixTokenException: $message';
}

/// Exception thrown when phone number format is invalid
///
/// This occurs before making any API calls when the phone number
/// doesn't match the expected format
class InvalidPhoneNumberException extends OTPException {
  const InvalidPhoneNumberException(
    super.message, {
    super.code,
    super.statusCode,
  });

  @override
  String toString() => 'InvalidPhoneNumberException: $message';
}
