import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/go_routes/go_router.dart' as app_router;
import 'package:fluffychat/config/localizations/localization_service.dart';
import 'package:fluffychat/config/themes.dart';
import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/custom_scroll_behaviour.dart';
import 'package:fluffychat/utils/network_connection_service.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/widgets/theme_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluffychat/state/auth_store.dart';
import 'package:matrix/matrix.dart';

import 'matrix.dart';

class DediApp extends StatefulWidget {
  final Widget? testWidget;
  final List<Client> clients;
  static GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();

  static DediAppState? _instance;

  static GoRouter get router {
    final instance = _instance;
    if (instance == null) {
      throw StateError('Router not initialized yet');
    }
    return instance._router;
  }

  const DediApp({
    super.key,
    this.testWidget,
    required this.clients,
  });

  /// getInitialLink may rereturn the value multiple times if this view is
  /// opened multiple times for example if the user logs out after they logged
  /// in with qr code or magic link.
  static bool gotInitialLink = false;

  static bool isCurrentPageIsInRooms() {
    final instance = _instance;
    if (instance == null) return false;
    return instance._router.routeInformationProvider.value.uri.path.startsWith(
      '/rooms/',
    );
  }

  static bool isCurrentPageIsNotRooms() {
    final instance = _instance;
    if (instance == null) return true;
    return !instance._router.routeInformationProvider.value.uri.path
        .startsWith('/rooms');
  }

  @override
  DediAppState createState() => DediAppState();
}

class DediAppState extends State<DediApp> {
  final networkConnectionService = getIt.get<NetworkConnectionService>();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    DediApp._instance = this;
    networkConnectionService.onInit();

    // 🔧 Debug: Boot log
    if (kDebugMode) {
      final auth = context.read<AuthStore>();
      debugPrint('[BOOT] DediApp.initState authState=${auth.state}');
    }

    // Router'ı bir kere oluştur (AuthStore ile)
    final auth = context.read<AuthStore>();
    _router = app_router.AppRouter.build(
      auth,
      navigatorKey: DediApp.routerKey,
    );

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await LocalizationService.initializeLanguage(context);
    });
  }

  @override
  void dispose() {
    DediApp._instance = null;
    networkConnectionService.onDispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🔧 Debug: Build log
    if (kDebugMode) {
      final auth = context.watch<AuthStore>();
      debugPrint('[BUILD] DediApp.build authState=${auth.state}');
    }
    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) => ValueListenableBuilder(
        valueListenable: LocalizationService.currentLocale,
        builder: (context, local, _) {
          return MaterialApp.router(
            restorationScopeId: 'Dedi',
            title: AppConfig.applicationName,
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: DediThemes.buildTheme(
              context,
              Brightness.light,
              primaryColor,
            ),
            darkTheme: DediThemes.buildTheme(
              context,
              Brightness.light,
              primaryColor,
            ),
            scrollBehavior: CustomScrollBehavior(),
            localizationsDelegates: const [
              LocaleNamesLocalizationsDelegate(),
              L10n.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: LocalizationService.supportedLocales,
            locale: local,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (final locale in supportedLocales) {
                if (locale.languageCode == deviceLocale?.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            routerConfig: _router,
            builder: (context, child) => Matrix(
              clients: widget.clients,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
