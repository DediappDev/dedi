import 'dart:async';
import 'dart:io';

import 'package:fluffychat/config/config_saas/config_saas.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:matrix/matrix.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'environment.dart';

abstract class AppConfig {
  static ResponsiveUtils responsive = getIt.get<ResponsiveUtils>();

  static Completer<bool> initConfigCompleter = Completer<bool>();

  static int retryCompleterCount = 0;

  static bool get hasReachedMaxRetries => retryCompleterCount == 3;

  static String _applicationName = 'Dedi';

  static String get applicationName => _applicationName;
  static String? _applicationWelcomeMessage;

  static String? get applicationWelcomeMessage => _applicationWelcomeMessage;
  static String _defaultHomeserver = 'matrix.dedim.com.tr';

  static String get defaultHomeserver => _defaultHomeserver;
  static double bubbleSizeFactor = 1;
  static double fontSizeFactor = 1;

  static const double messagePadding = 16.0;

  static const double defaultMaxWidthReactionsView = 400;

  static const double defaultMaxHeightReactionsView = 400;

  ///`REGISTRATION_URL`: Registration URL for public platform, sample is `https://example.com`
  static String registrationUrl = Environment.registrationUrl;

  ///`DEDI_WORKPLACE_HOMESERVER`: Dedi workplace homeserver, sample is `https://example.com`
  static String dediWorkplaceHomeserver = Environment.matrixHomeserver;

  ///`HOME_SERVER`: Homeserver, sample is `https://example.com`
  static String homeserver = Environment.matrixHomeserver;

  static String appParameter = 'chat';

  static String? platform;

  static String _appPolicy = Environment.privacyUrl;

  static String appTermsOfUse = 'https://dedim.com.tr/terms';

  static String qrCodeDownloadUrl = Environment.qrCodeDownloadUrl;

  /// ✅ OTP API endpoints - Updated for DEDI Server integration
  static String otpApiBaseUrl =
      Environment.tomServer; // Changed from identityServer to tomServer
  static String otpRequestEndpoint =
      '/otp/request'; // Simplified path for DEDI Server
  static String otpVerifyEndpoint =
      '/otp/verify'; // Simplified path for DEDI Server
  static String otpMatrixTokenEndpoint =
      '/otp/matrix-token'; // Simplified path for DEDI Server

  /// Matrix and identity configuration - Maintain existing URLs
  static String matrixIdentityServer = Environment.identityServer;
  static String matrixHomeserver = Environment.matrixHomeserver;
  static String tomServerUrl = Environment.tomServer;

  static String dediChatAppleStore =
      'https://apps.apple.com/us/app/dedi-chat/id6473384641';

  static String dediChatGooglePlay =
      'https://play.google.com/store/apps/details?id=app.dedi.android.chat';

  static double toolbarHeight(BuildContext context) =>
      responsive.isMobile(context) ? 48 : 56;
  static const Color chatColor = primaryColor;
  static Color colorSchemeSeed = primaryColor;
  static const double messageFontSize = 17.0;
  static const bool allowOtherHomeservers = true;
  static const bool enableRegistration = true;
  static const Color primaryColor = Color.fromARGB(255, 135, 103, 172);
  static const Color primaryColorLight = Color(0xFFCCBDEA);
  static const Color secondaryColor = Color(0xFF41a2bc);

  static const List<String> emojisDefault = [
    '💜',
    '👍',
    '👎',
    '😂',
    '😮',
    '🥲',
  ];

  static String get privacyUrl => _appPolicy;
  static const String enablePushTutorial =
      'https://gitlab.com/famedly/fluffychat/-/wikis/Push-Notifications-without-Google-Services';
  static const String encryptionTutorial =
      'https://gitlab.com/famedly/fluffychat/-/wikis/How-to-use-end-to-end-encryption-in-FluffyChat';
  static const String appOpenUrlScheme = 'dedi.chat';
  static String _webBaseUrl = Environment.chatWeb;

  static String get webBaseUrl => _webBaseUrl;
  static const String sourceCodeUrl = 'https://github.com/dediapp/dedi';
  static String supportUrl = Environment.supportUrl;
  static String cozyExternalBridgeVersion = '0.16.1';
  static bool renderHtml = true;
  static bool hideRedactedEvents = false;
  static bool hideUnknownEvents = true;
  static bool hideUnimportantStateEvents = true;
  static bool showDirectChatsInSpaces = true;
  static bool separateChatTypes = false;
  static bool autoplayImages = true;
  static bool experimentalVoip = false;
  static bool appGridDashboardAvailable = true;
  static bool enableRightAndLeftMessageAlignmentOnWeb = false;
  static const bool hideTypingUsernames = false;
  static const bool hideAllStateEvents = false;
  static const String inviteLinkPrefix = 'https://matrix.to/#/';
  static const String deepLinkPrefix = 'im.dedi://chat/';
  static const String schemePrefix = 'matrix:';
  static const String pushNotificationsChannelId = 'dedi_push';
  static const String pushNotificationsChannelName = 'Dedi Chat push channel';
  static const String pushNotificationsChannelDescription =
      'Push notifications for Dedi Chat';
  static String pushNotificationsAppId = Platform.isIOS
      ? kReleaseMode
          ? "app.dedi.ios.chat"
          : "app.dedi.ios.chat.sandbox"
      : "app.dedi.android.chat";

  static const String _pushNotificationsGatewayUrlEnv = String.fromEnvironment(
    'PUSH_NOTIFICATIONS_GATEWAY_URL',
    defaultValue: Environment.pushGatewayUrl,
  );

  static String pushNotificationsGatewayUrl = _pushNotificationsGatewayUrlEnv;
  static const String pushNotificationsPusherFormat = 'event_id_only';
  static const String emojiFontName = 'Dedi Emoji';
  static const String emojiFontUrl =
      'https://github.com/googlefonts/noto-emoji/';
  static const double borderRadius = 20.0;
  static const double columnWidth = 360.0;
  static const int maxFetchContacts = 100000;
  static const int chatRoomSearchKeywordMin = 2;
  static const bool chatRoomSearchWordStrategy = false;
  static const String defaultImageBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';
  static const String defaultVideoBlurHash = 'L5H2EC=PM+yV0g-mq.wG9c010J}I';
  static const int thumbnailQuality = 70;
  static const int blurHashSize = 32;
  static const int imageQuality = 50;
  static const String iOSKeychainSharingId = 'KUT463DS29.app.dedi.ios.chat';
  static const String iOSKeychainSharingAccount = 'app.dedi.ios.chat.sessions';
  static const int maxFilesSendPerDialog = 6;
  static const bool supportMultipleAccountsInTheSameHomeserver = false;
  static const imageCompressFormmat = CompressFormat.jpeg;
  static const videoThumbnailFormat = ImageFormat.JPEG;

  static const List<String> allowedExtensionsSupportedAvatar = [
    'png',
    'jpg',
    'jpeg',
    'jfif',
  ];

  static String? issueId;

  static int defaultMaxUploadAvtarSizeInBytes = 10000000;

  static bool devMode = false;

  /// Debug toast configuration - shows detailed server errors when enabled
  static bool enableDebugToasts = false;

  static const int maxRecentReactionsSize = 12;

  static const String appGridConfigurationPath =
      "configurations/app_dashboard.json";

  static const String _platformEnv = String.fromEnvironment(
    'PLATFORM',
    defaultValue: ConfigurationSaas.platform,
  );

  static const bool _enableDebugToastsEnv = bool.fromEnvironment(
    'ENABLE_DEBUG_TOASTS',
    defaultValue: false,
  );

  static const String _dediWorkplaceHomeserverEnv = String.fromEnvironment(
    'DEDI_WORKPLACE_HOMESERVER',
    defaultValue: ConfigurationSaas.dediWorkplaceHomeserver,
  );

  static const String _registrationUrlEnv = String.fromEnvironment(
    'REGISTRATION_URL',
    defaultValue: ConfigurationSaas.registrationUrl,
  );

  static const String _homeserverEnv = String.fromEnvironment(
    'HOME_SERVER',
    defaultValue: ConfigurationSaas.homeserver,
  );

  static void loadEnvironment() {
    dediWorkplaceHomeserver = _dediWorkplaceHomeserverEnv;

    Logs().i(
      '[Public Platform] AppConfig():: DEDI_WORKPLACE_HOMESERVER $_dediWorkplaceHomeserverEnv',
    );

    registrationUrl = _registrationUrlEnv;

    Logs().i(
      '[Public Platform] AppConfig():: REGISTRATION_URL $_registrationUrlEnv',
    );

    platform = _platformEnv;

    Logs().i(
      '[Public Platform] AppConfig():: Platform $_platformEnv',
    );

    homeserver = _homeserverEnv;

    Logs().i(
      '[Public Platform] AppConfig():: HOME_SERVER $_homeserverEnv',
    );

    enableDebugToasts = _enableDebugToastsEnv;

    Logs().i(
      '[Debug] AppConfig():: ENABLE_DEBUG_TOASTS $_enableDebugToastsEnv',
    );

    // Debug: Print debug toast status
    if (kDebugMode) {
      debugPrint('🐛 AppConfig: enableDebugToasts = $enableDebugToasts');
      debugPrint(
        '🐛 AppConfig: _enableDebugToastsEnv = $_enableDebugToastsEnv',
      );
    }

    // ✅ DEDI Server Configuration Debug Logging
    if (kDebugMode && enableDebugToasts) {
      debugPrint('🚀 DEDI Server Configuration Loaded:');
      debugPrint('⚡ OTP API Base URL: $otpApiBaseUrl');
      debugPrint('📤 OTP Request Endpoint: $otpRequestEndpoint');
      debugPrint('✅ OTP Verify Endpoint: $otpVerifyEndpoint');
      debugPrint('🔗 Matrix Token Endpoint: $otpMatrixTokenEndpoint');
      debugPrint('🔐 Matrix Identity Server: $matrixIdentityServer');
      debugPrint('📡 Matrix Homeserver: $matrixHomeserver');
      debugPrint('🏗️ ToM Server URL: $tomServerUrl');
      debugPrint('✅ DEDI Server configuration logging complete');
    }

    // ✅ Log environment variables for troubleshooting
    Environment.logEnvironmentVariables();
  }

  static bool get isSaasPlatForm => _platformEnv == 'saas';

  static void loadFromJson(Map<String, dynamic> json) {
    // ✅ Debug logging for configuration loading start
    if (kDebugMode && enableDebugToasts) {
      debugPrint('🔧 AppConfig: Starting loadFromJson configuration loading');
      debugPrint('📋 AppConfig: JSON keys found: ${json.keys.toList()}');
      debugPrint(
        '🔍 AppConfig: Configuration source contains ${json.length} parameters',
      );
    }

    if (json['homeserver'] != null && json['homeserver'] is String) {
      if (json['homeserver'] != '') {
        homeserver = json['homeserver'];
      }
    }

    if (json['registration_url'] != null &&
        json['registration_url'] is String) {
      if (json['registration_url'] != '') {
        registrationUrl = json['registration_url'];
      }
    }

    if (json['dedi_workplace_homeserver'] != null &&
        json['dedi_workplace_homeserver'] is String) {
      if (json['dedi_workplace_homeserver'] != '') {
        dediWorkplaceHomeserver = json['dedi_workplace_homeserver'];
      }
    }

    if (json['chat_color'] != null) {
      try {
        colorSchemeSeed = Color(json['chat_color']);
      } catch (e) {
        Logs().w(
          'Invalid color in config.json! Please make sure to define the color in this format: "0xffdd0000"',
          e,
        );
      }
    }
    if (json['application_name'] is String) {
      _applicationName = json['application_name'];
    }
    if (json['application_welcome_message'] is String) {
      _applicationWelcomeMessage = json['application_welcome_message'];
    }
    if (json['default_homeserver'] is String) {
      _defaultHomeserver = json['default_homeserver'];
    }
    if (json['privacy_url'] is String) {
      _webBaseUrl = json['privacy_url'];
    }
    if (json['web_base_url'] is String) {
      _appPolicy = json['web_base_url'];
    }
    if (json['render_html'] is bool) {
      renderHtml = json['render_html'];
    }
    if (json['hide_redacted_events'] is bool) {
      hideRedactedEvents = json['hide_redacted_events'];
    }
    if (json['hide_unknown_events'] is bool) {
      hideUnknownEvents = json['hide_unknown_events'];
    }
    if (json['issue_id'] is String?) {
      issueId = json['issue_id'];
    }
    if (json['app_grid_dashboard_available'] is bool) {
      appGridDashboardAvailable = json['app_grid_dashboard_available'];
    }
    if (json['platform'] is String?) {
      platform = json['platform'];
    }
    if (json['default_max_upload_avatar_size_in_bytes'] is int) {
      defaultMaxUploadAvtarSizeInBytes =
          json['default_max_upload_avatar_size_in_bytes'];
    }
    if (json['dev_mode'] is bool) {
      devMode = json['dev_mode'];
    }
    if (json['enable_debug_toasts'] is bool) {
      enableDebugToasts = json['enable_debug_toasts'];
      if (kDebugMode) {
        debugPrint(
          '🐛 AppConfig: Loaded enableDebugToasts from config.json = $enableDebugToasts',
        );
      }
    }
    if (json['qr_code_download_url'] is String) {
      qrCodeDownloadUrl = json['qr_code_download_url'];
    }
    if (json['enable_logs'] is bool) {
      DebugUtils.enableLogs = json['enable_logs'];
      Logs().level = DebugUtils().isDebugMode ? Level.verbose : Level.warning;
    }
    if (json['support_url'] is String) {
      supportUrl = json['support_url'];
    }
    if (json['cozy_external_bridge_version'] is String &&
        json['cozy_external_bridge_version'].isNotEmpty) {
      cozyExternalBridgeVersion = json['cozy_external_bridge_version'];
    }

    // ✅ DEDI Server Configuration - Load new fields
    if (json['tom_server_url'] is String) {
      tomServerUrl = json['tom_server_url'];
    }
    if (json['identity_server_url'] is String) {
      matrixIdentityServer = json['identity_server_url'];
    }
    if (json['otp_api_base_url'] is String) {
      otpApiBaseUrl = json['otp_api_base_url'];
    }
    if (json['otp_request_endpoint'] is String) {
      otpRequestEndpoint = json['otp_request_endpoint'];
    }
    if (json['otp_verify_endpoint'] is String) {
      otpVerifyEndpoint = json['otp_verify_endpoint'];
    }
    if (json['otp_matrix_token_endpoint'] is String) {
      otpMatrixTokenEndpoint = json['otp_matrix_token_endpoint'];
    }

    // ✅ Debug logging for DEDI Server specific configuration
    if (kDebugMode && enableDebugToasts) {
      debugPrint(
          '🏗️ AppConfig: Checking for DEDI Server specific configuration...');

      // Log DEDI Server URLs if present in JSON
      if (json['tom_server_url'] != null) {
        debugPrint(
            '⚡ AppConfig: Found tom_server_url in config: ${json['tom_server_url']}');
      }
      if (json['identity_server_url'] != null) {
        debugPrint(
            '🔐 AppConfig: Found identity_server_url in config: ${json['identity_server_url']}');
      }
      if (json['otp_api_base_url'] != null) {
        debugPrint(
            '📡 AppConfig: Found otp_api_base_url in config: ${json['otp_api_base_url']}');
      }

      // Log OTP endpoints if present in JSON
      if (json['otp_request_endpoint'] != null) {
        debugPrint(
            '📤 AppConfig: Found otp_request_endpoint in config: ${json['otp_request_endpoint']}');
      }
      if (json['otp_verify_endpoint'] != null) {
        debugPrint(
            '✅ AppConfig: Found otp_verify_endpoint in config: ${json['otp_verify_endpoint']}');
      }
      if (json['otp_matrix_token_endpoint'] != null) {
        debugPrint(
            '🔗 AppConfig: Found otp_matrix_token_endpoint in config: ${json['otp_matrix_token_endpoint']}');
      }

      // Log debug configuration if present
      if (json['debug_configuration'] != null) {
        debugPrint(
            '🐛 AppConfig: Found debug_configuration in config: ${json['debug_configuration']}');
      }
      if (json['server_mapping'] != null) {
        debugPrint(
            '🗺️ AppConfig: Found server_mapping in config: ${json['server_mapping']}');
      }

      // Final configuration summary
      debugPrint('✅ AppConfig: loadFromJson configuration loading completed');
      debugPrint('🎯 AppConfig: Current homeserver: $homeserver');
      debugPrint('📝 AppConfig: Current registration URL: $registrationUrl');
      debugPrint('🏗️ AppConfig: Current application name: $applicationName');
      debugPrint('🔧 AppConfig: Dev mode: $devMode');
      debugPrint('🐛 AppConfig: Debug toasts enabled: $enableDebugToasts');
    }
  }
}
