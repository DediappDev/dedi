import 'package:fluffychat/domain/exception/auth/otp_exceptions.dart';

/// Response models for OTP API endpoints
///
/// These models provide type-safe, structured representations of API responses
/// with proper null safety checks and validation.

/// Response from POST /otp/request
///
/// Contains the status of the OTP request and optional dev OTP for testing.
class OTPRequestResponse {
  /// Status of the request (e.g., "sent")
  final String status;

  /// Development OTP code (only present in dev/debug mode)
  final String? devOTP;

  /// OTP expiration time in seconds
  final int expiresIn;

  const OTPRequestResponse({
    required this.status,
    this.devOTP,
    required this.expiresIn,
  });

  /// Creates an [OTPRequestResponse] from JSON
  ///
  /// Throws [OTPRequestFailedException] if required fields are missing
  factory OTPRequestResponse.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as String?;

    if (status == null) {
      throw const OTPRequestFailedException(
        'Invalid OTP request response: missing status',
      );
    }

    return OTPRequestResponse(
      status: status,
      devOTP: json['dev_otp'] as String?,
      expiresIn: json['expires_in'] as int? ?? 300,
    );
  }

  /// Converts this response to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      if (devOTP != null) 'dev_otp': devOTP,
      'expires_in': expiresIn,
    };
  }

  @override
  String toString() =>
      'OTPRequestResponse(status: $status, expiresIn: $expiresIn)';
}

/// Response from POST /otp/verify
///
/// Contains the short-lived JWT token and user information.
class OTPVerifyResponse {
  /// JWT access token (short-lived, 5 minutes)
  final String accessToken;

  /// Matrix user ID
  final String userId;

  /// Matrix ID (MXID)
  final String mxid;

  /// Token expiration time in seconds
  final int expiresIn;

  const OTPVerifyResponse({
    required this.accessToken,
    required this.userId,
    required this.mxid,
    required this.expiresIn,
  });

  /// Creates an [OTPVerifyResponse] from JSON
  ///
  /// Throws [OTPInvalidException] if required fields are missing or null
  factory OTPVerifyResponse.fromJson(Map<String, dynamic> json) {
    final token = json['access_token'] as String?;
    final userId = json['user_id'] as String?;
    final mxid = json['mxid'] as String?;

    if (token == null || userId == null || mxid == null) {
      throw const OTPInvalidException(
        'Incomplete OTP verification response: missing required fields',
      );
    }

    return OTPVerifyResponse(
      accessToken: token,
      userId: userId,
      mxid: mxid,
      expiresIn: json['expires_in'] as int? ?? 300,
    );
  }

  /// Converts this response to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user_id': userId,
      'mxid': mxid,
      'expires_in': expiresIn,
    };
  }

  @override
  String toString() =>
      'OTPVerifyResponse(userId: $userId, mxid: $mxid, expiresIn: $expiresIn)';
}

/// Response from POST /otp/matrix-token
///
/// Contains the permanent Matrix access token and connection details.
class MatrixTokenResponse {
  /// Matrix access token (permanent, used for all Matrix API calls)
  final String accessToken;

  /// Matrix user ID
  final String userId;

  /// Homeserver URL
  final String homeserver;

  /// Device ID (optional)
  final String? deviceId;

  const MatrixTokenResponse({
    required this.accessToken,
    required this.userId,
    required this.homeserver,
    this.deviceId,
  });

  /// Creates a [MatrixTokenResponse] from JSON
  ///
  /// Throws [MatrixTokenException] if required fields are missing or null
  factory MatrixTokenResponse.fromJson(Map<String, dynamic> json) {
    final token = json['access_token'] as String?;
    final userId = json['user_id'] as String? ?? json['mxid'] as String?;
    final homeserver = json['homeserver'] as String?;

    if (token == null || userId == null || homeserver == null) {
      throw const MatrixTokenException(
        'Incomplete Matrix token response: missing required fields (access_token, user_id, or homeserver)',
      );
    }

    return MatrixTokenResponse(
      accessToken: token,
      userId: userId,
      homeserver: homeserver,
      deviceId: json['device_id'] as String?,
    );
  }

  /// Converts this response to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user_id': userId,
      'homeserver': homeserver,
      if (deviceId != null) 'device_id': deviceId,
    };
  }

  @override
  String toString() =>
      'MatrixTokenResponse(userId: $userId, homeserver: $homeserver, deviceId: $deviceId)';
}
