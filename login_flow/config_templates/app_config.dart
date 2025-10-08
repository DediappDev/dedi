/// Application Configuration Template
/// Based on: lib/config/app_config.dart
///
/// This file contains all the configuration settings for your Matrix chat application.
/// Copy this file to your project and customize the values according to your needs.

import 'dart:ui';
import 'package:matrix/matrix.dart';

abstract class AppConfig {
  // =======================
  // APPLICATION SETTINGS
  // =======================

  /// Application name displayed in UI and system
  static String _applicationName = 'YourChatApp';
  static String get applicationName => _applicationName;

  /// Welcome message shown on first launch (optional)
  static String? _applicationWelcomeMessage;
  static String? get applicationWelcomeMessage => _applicationWelcomeMessage;

  /// App version and build information
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // =======================
  // MATRIX CONFIGURATION
  // =======================

  /// Default Matrix homeserver URL
  /// Change this to your own homeserver
  static String _defaultHomeserver = 'matrix.org';
  static String get defaultHomeserver => _defaultHomeserver;

  /// Fallback homeserver IP for when DNS fails
  /// Set this to your homeserver's IP address
  static const String fallbackHomeserverIp = '127.0.0.1';

  /// Whether to allow users to connect to other homeservers
  static const bool allowOtherHomeservers = true;

  /// Whether to enable user registration (vs login only)
  static const bool enableRegistration = true;

  /// Matrix app identifier for push notifications
  static const String appId = 'com.yourcompany.yourchatapp';

  /// URL scheme for deep links
  static const String appOpenUrlScheme = 'yourchatapp';

  // =======================
  // UI/UX CONFIGURATION
  // =======================

  /// Primary theme color
  static const Color primaryColor = Color(0xFF2196F3);

  /// Light variant of primary color
  static const Color primaryColorLight = Color(0xFFBBDEFB);

  /// Secondary theme color
  static const Color secondaryColor = Color(0xFF03DAC6);

  /// Color scheme seed for Material You theming
  static Color? colorSchemeSeed = primaryColor;

  /// Chat message font size
  static const double messageFontSize = 16.0;

  /// Overall font size multiplier
  static double fontSizeFactor = 1.0;

  /// Border radius for UI elements
  static const double borderRadius = 12.0;

  /// Column width for desktop/tablet layouts
  static const double columnWidth = 360.0;

  /// Default emoji reactions
  static const Set<String> defaultReactions = {'👍', '❤️', '😂', '😮', '😢'};

  // =======================
  // CHAT BEHAVIOR SETTINGS
  // =======================

  /// Whether to render HTML in messages
  static bool renderHtml = true;

  /// Whether to hide redacted (deleted) events
  static bool hideRedactedEvents = false;

  /// Whether to hide unknown event types
  static bool hideUnknownEvents = true;

  /// Whether to separate chat types in the UI
  static bool separateChatTypes = false;

  /// Whether to autoplay images in chat
  static bool autoplayImages = true;

  /// Whether to send typing notifications
  static bool sendTypingNotifications = true;

  /// Whether to send public read receipts
  static bool sendPublicReadReceipts = true;

  /// Whether swipe right-to-left triggers reply
  static bool swipeRightToLeftToReply = true;

  /// Whether Enter key sends message (null = auto-detect platform)
  static bool? sendOnEnter;

  /// Whether to show user presence indicators
  static bool showPresences = true;

  /// Whether to display navigation rail on desktop
  static bool displayNavigationRail = false;

  /// Whether to enable experimental VoIP features
  static bool experimentalVoip = false;

  /// Whether to hide typing usernames in indicators
  static const bool hideTypingUsernames = false;

  // =======================
  // AUTHENTICATION CONFIG
  // =======================

  /// Backend API base URL for OTP authentication
  static const String authApiBaseUrl = 'https://api.yourapp.com';

  /// Whether to auto-fill development OTP codes
  static const bool autoFillDevOtp = bool.fromEnvironment(
    'AUTO_FILL_DEV_OTP',
    defaultValue: false,
  );

  /// OTP code length
  static const int otpLength = 6;

  /// OTP expiration time in seconds
  static const int otpExpirationSeconds = 300; // 5 minutes

  /// Maximum OTP retry attempts
  static const int maxOtpAttempts = 5;

  /// Resend OTP cooldown in seconds
  static const int resendOtpCooldownSeconds = 60;

  // =======================
  // URLS AND LINKS
  // =======================

  /// Privacy policy URL
  static String _privacyUrl = 'https://yourapp.com/privacy';
  static String get privacyUrl => _privacyUrl;

  /// Website URL
  static const String website = 'https://yourapp.com';

  /// Web app base URL
  static String _webBaseUrl = 'https://yourapp.com/app';
  static String get webBaseUrl => _webBaseUrl;

  /// Source code repository URL
  static const String sourceCodeUrl = 'https://github.com/yourcompany/yourchatapp';

  /// Support/help URL
  static const String supportUrl = 'https://yourapp.com/support';

  /// Changelog URL
  static const String changelogUrl = 'https://github.com/yourcompany/yourchatapp/blob/main/CHANGELOG.md';

  /// URL for reporting bugs/issues
  static final Uri newIssueUrl = Uri(
    scheme: 'https',
    host: 'github.com',
    path: '/yourcompany/yourchatapp/issues/new',
  );

  /// Tutorial URLs
  static const String pushNotificationTutorial = 'https://yourapp.com/help/push-notifications';
  static const String encryptionTutorial = 'https://yourapp.com/help/encryption';
  static const String startChatTutorial = 'https://yourapp.com/help/start-chat';

  // =======================
  // MATRIX PROTOCOL SETTINGS
  // =======================

  /// Matrix invite link prefix
  static const String inviteLinkPrefix = 'https://matrix.to/#/';

  /// App-specific deep link prefix
  static const String deepLinkPrefix = 'yourchatapp://chat/';

  /// Matrix URI scheme prefix
  static const String schemePrefix = 'matrix:';

  /// Homeserver list URL for server discovery
  static final Uri homeserverList = Uri(
    scheme: 'https',
    host: 'servers.joinmatrix.org',
    path: 'servers.json',
  );

  // =======================
  // PUSH NOTIFICATIONS
  // =======================

  /// Push notification channel ID (Android)
  static const String pushNotificationsChannelId = 'yourchatapp_push';

  /// Push notification app ID for UnifiedPush
  static const String pushNotificationsAppId = 'com.yourcompany.yourchatapp';

  // =======================
  // DEVELOPMENT SETTINGS
  // =======================

  /// Enable debug logging
  static const bool enableDebugLogging = bool.fromEnvironment(
    'DEBUG_LOGGING',
    defaultValue: false,
  );

  /// Mock backend responses in development
  static const bool mockBackendResponses = bool.fromEnvironment(
    'MOCK_BACKEND',
    defaultValue: false,
  );

  /// Development homeserver URL
  static const String devHomeserver = String.fromEnvironment(
    'DEV_HOMESERVER',
    defaultValue: 'localhost:8008',
  );

  // =======================
  // CONFIGURATION LOADING
  // =======================

  /// Load configuration from JSON file (for web deployment)
  static void loadFromJson(Map<String, dynamic> json) {
    // Application settings
    if (json['application_name'] is String) {
      _applicationName = json['application_name'];
    }
    if (json['application_welcome_message'] is String) {
      _applicationWelcomeMessage = json['application_welcome_message'];
    }

    // Homeserver settings
    if (json['default_homeserver'] is String) {
      _defaultHomeserver = json['default_homeserver'];
    }

    // URL settings
    if (json['privacy_url'] is String) {
      _privacyUrl = json['privacy_url'];
    }
    if (json['web_base_url'] is String) {
      _webBaseUrl = json['web_base_url'];
    }

    // Theme settings
    if (json['chat_color'] != null) {
      try {
        colorSchemeSeed = Color(json['chat_color']);
      } catch (e) {
        Logs().w('Invalid color in config.json: ${json['chat_color']}', e);
      }
    }

    // Chat behavior settings
    if (json['render_html'] is bool) {
      renderHtml = json['render_html'];
    }
    if (json['hide_redacted_events'] is bool) {
      hideRedactedEvents = json['hide_redacted_events'];
    }
    if (json['hide_unknown_events'] is bool) {
      hideUnknownEvents = json['hide_unknown_events'];
    }
    if (json['send_typing_notifications'] is bool) {
      sendTypingNotifications = json['send_typing_notifications'];
    }
    if (json['send_public_read_receipts'] is bool) {
      sendPublicReadReceipts = json['send_public_read_receipts'];
    }
    if (json['autoplay_images'] is bool) {
      autoplayImages = json['autoplay_images'];
    }

    // Font and UI settings
    if (json['font_size_factor'] is num) {
      fontSizeFactor = json['font_size_factor'].toDouble();
    }
  }

  // =======================
  // VALIDATION HELPERS
  // =======================

  /// Validate homeserver URL format
  static bool isValidHomeserverUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  /// Validate Matrix user ID format
  static bool isValidMatrixId(String matrixId) {
    return matrixId.startsWith('@') && matrixId.contains(':');
  }

  /// Validate phone number format (international)
  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+[1-9]\d{1,14}$');
    return phoneRegex.hasMatch(phone);
  }

  // =======================
  // UTILITY METHODS
  // =======================

  /// Get user-agent string for HTTP requests
  static String getUserAgent() {
    return '$applicationName/$appVersion (Matrix Chat App)';
  }

  /// Get default Matrix client name
  static String getDefaultClientName() {
    return '$applicationName-${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Get platform-specific settings
  static Map<String, dynamic> getPlatformConfig() {
    return {
      'app_name': applicationName,
      'app_id': appId,
      'homeserver': defaultHomeserver,
      'primary_color': primaryColor.value,
      'version': appVersion,
    };
  }
}

// =======================
// ENVIRONMENT CONFIGURATION
// =======================

/// Environment-specific configuration
class EnvironmentConfig {
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';

  /// Get environment-specific homeserver
  static String get homeserver {
    switch (environment) {
      case 'production':
        return AppConfig.defaultHomeserver;
      case 'staging':
        return AppConfig.devHomeserver;
      case 'development':
      default:
        return AppConfig.devHomeserver;
    }
  }

  /// Get environment-specific API base URL
  static String get apiBaseUrl {
    switch (environment) {
      case 'production':
        return AppConfig.authApiBaseUrl;
      case 'staging':
        return 'https://staging-api.yourapp.com';
      case 'development':
      default:
        return 'http://localhost:3000';
    }
  }
}

// =======================
// FEATURE FLAGS
// =======================

/// Feature flags for experimental or conditional features
class FeatureFlags {
  /// Enable new UI design
  static const bool newUIDesign = bool.fromEnvironment(
    'NEW_UI_DESIGN',
    defaultValue: false,
  );

  /// Enable voice messages
  static const bool voiceMessages = bool.fromEnvironment(
    'VOICE_MESSAGES',
    defaultValue: true,
  );

  /// Enable video calls
  static const bool videoCalls = bool.fromEnvironment(
    'VIDEO_CALLS',
    defaultValue: false,
  );

  /// Enable location sharing
  static const bool locationSharing = bool.fromEnvironment(
    'LOCATION_SHARING',
    defaultValue: true,
  );

  /// Enable file sharing
  static const bool fileSharing = bool.fromEnvironment(
    'FILE_SHARING',
    defaultValue: true,
  );

  /// Enable emoji reactions
  static const bool emojiReactions = bool.fromEnvironment(
    'EMOJI_REACTIONS',
    defaultValue: true,
  );

  /// Enable message threading
  static const bool messageThreading = bool.fromEnvironment(
    'MESSAGE_THREADING',
    defaultValue: false,
  );

  /// Enable spaces feature
  static const bool spaces = bool.fromEnvironment(
    'SPACES',
    defaultValue: true,
  );
}