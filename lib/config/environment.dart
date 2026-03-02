import 'package:flutter/foundation.dart';

class Environment {
  Environment._();

  // Matrix and Identity Services (env-backed)
  static const String matrixHomeserver = String.fromEnvironment(
    'MATRIX_HOMESERVER',
    defaultValue: 'https://matrix.dedim.com.tr',
  );
  static const String identityServer = String.fromEnvironment(
    'IDENTITY_BASE',
    defaultValue: 'https://matrix.dedim.com.tr',
  );

  // ✅ ToM/OTP Server URL - Added for DEDI Server integration (env-backed)
  static const String tomServer = String.fromEnvironment(
    'OTP_BASE',
    defaultValue: 'https://tom.dedim.com.tr',
  );

  // Dedi API base (/_dedi/*) (env-backed)
  static const String dediApiBase = String.fromEnvironment(
    'DEDI_API_BASE',
    defaultValue: 'https://matrix.dedim.com.tr',
  );

  // Web and User Services
  static const String chatWeb = 'https://chat.dedim.com.tr';
  static const String registrationUrl = 'https://sign-up.dedim.com.tr/';
  static const String qrCodeDownloadUrl =
      'https://sign-up.dedim.com.tr/download/chat';

  // Notification and Support Services
  static const String pushGatewayUrl =
      'https://notification.dedim.com.tr/_matrix/push/v1/notify';
  static const String privacyUrl = 'https://dedim.com.tr/en/privacy/';
  static const String supportUrl = 'https://dedim.com.tr/support';

  // Debug configuration
  static const bool enableDebugLogging = true;

  /// Initialize environment and log configuration for debugging
  static void initialize() {
    if (kDebugMode && enableDebugLogging) {
      debugPrint('🚀 Environment initialized with DEDI Server configuration:');
      debugPrint('📡 Matrix Homeserver: $matrixHomeserver');
      debugPrint('🔐 Identity Server: $identityServer');
      debugPrint('⚡ ToM Server: $tomServer');
      debugPrint('🌐 Chat Web: $chatWeb');
      debugPrint('📝 Registration URL: $registrationUrl');
      debugPrint('🔔 Push Gateway: $pushGatewayUrl');
      debugPrint('✅ Environment configuration loaded successfully');
    }
  }

  /// ✅ Log environment variables and build information for troubleshooting
  static void logEnvironmentVariables() {
    if (!kDebugMode || !enableDebugLogging) {
      return;
    }

    debugPrint('🔍 === Environment Variables & Build Information ===');

    // Platform and build information
    debugPrint('🏗️ Platform Information:');
    debugPrint('   - Debug Mode: $kDebugMode');
    debugPrint('   - Profile Mode: $kProfileMode');
    debugPrint('   - Release Mode: $kReleaseMode');
    debugPrint('   - Debug Logging: $enableDebugLogging');

    // Server environment configuration
    debugPrint('🌍 Server Environment:');
    debugPrint('   - Matrix Homeserver: $matrixHomeserver');
    debugPrint('   - Identity Server: $identityServer');
    debugPrint('   - ToM Server: $tomServer');
    debugPrint('   - Chat Web: $chatWeb');
    debugPrint('   - Registration URL: $registrationUrl');
    debugPrint('   - QR Download URL: $qrCodeDownloadUrl');
    debugPrint('   - Push Gateway: $pushGatewayUrl');
    debugPrint('   - Privacy URL: $privacyUrl');
    debugPrint('   - Support URL: $supportUrl');

    // Environment variables from String.fromEnvironment
    debugPrint('🔧 Environment Variables:');

    // Check common environment variables
    const platformEnv =
        String.fromEnvironment('PLATFORM', defaultValue: 'not_set');
    const homeServerEnv =
        String.fromEnvironment('HOME_SERVER', defaultValue: 'not_set');
    const registrationUrlEnv =
        String.fromEnvironment('REGISTRATION_URL', defaultValue: 'not_set');
    const debugToastsEnv =
        String.fromEnvironment('ENABLE_DEBUG_TOASTS', defaultValue: 'not_set');
    const pushGatewayEnv = String.fromEnvironment(
        'PUSH_NOTIFICATIONS_GATEWAY_URL',
        defaultValue: 'not_set');
    const workplaceHomeserverEnv = String.fromEnvironment(
        'DEDI_WORKPLACE_HOMESERVER',
        defaultValue: 'not_set');

    debugPrint('   - PLATFORM: $platformEnv');
    debugPrint('   - HOME_SERVER: $homeServerEnv');
    debugPrint('   - REGISTRATION_URL: $registrationUrlEnv');
    debugPrint('   - ENABLE_DEBUG_TOASTS: $debugToastsEnv');
    debugPrint('   - PUSH_NOTIFICATIONS_GATEWAY_URL: $pushGatewayEnv');
    debugPrint('   - DEDI_WORKPLACE_HOMESERVER: $workplaceHomeserverEnv');

    // DEDI Server specific configuration summary
    debugPrint('⚡ DEDI Server Configuration Summary:');
    debugPrint('   - OTP Operations will use: $tomServer');
    debugPrint('   - Matrix Operations will use: $matrixHomeserver');
    debugPrint('   - Identity Operations will use: $identityServer');
    debugPrint('   - User Registration will use: $registrationUrl');

    debugPrint('✅ === End Environment Variables Logging ===');
  }

  /// ✅ Log configuration changes for troubleshooting
  static void logConfigurationChange(
      String component, String oldValue, String newValue) {
    if (kDebugMode && enableDebugLogging) {
      debugPrint('🔄 Configuration Change in $component:');
      debugPrint('   - Old Value: $oldValue');
      debugPrint('   - New Value: $newValue');
      debugPrint('   - Timestamp: ${DateTime.now().toIso8601String()}');
    }
  }

  /// ✅ Log critical configuration errors
  static void logConfigurationError(String component, String error,
      {String? suggestion}) {
    if (kDebugMode) {
      debugPrint('❌ Configuration Error in $component:');
      debugPrint('   - Error: $error');
      if (suggestion != null) {
        debugPrint('   - Suggestion: $suggestion');
      }
      debugPrint('   - Timestamp: ${DateTime.now().toIso8601String()}');
    }
  }
}
