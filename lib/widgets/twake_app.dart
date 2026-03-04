import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/go_routes/go_router.dart';
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

  const DediApp({
    super.key,
    this.testWidget,
    required this.clients,
  });

  /// getInitialLink may rereturn the value multiple times if this view is
  /// opened multiple times for example if the user logs out after they logged
  /// in with qr code or magic link.
  static bool gotInitialLink = false;

  // Router is (re)built with AuthStore as refreshListenable to react to auth changes
  static late GoRouter router;

  static bool isCurrentPageIsInRooms() =>
      router.routeInformationProvider.value.uri.path.startsWith('/rooms/');

  static bool isCurrentPageIsNotRooms() =>
      !router.routeInformationProvider.value.uri.path.startsWith('/rooms');

  @override
  DediAppState createState() => DediAppState();
}

class DediAppState extends State<DediApp> {
  final networkConnectionService = getIt.get<NetworkConnectionService>();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    networkConnectionService.onInit();

    // 🔧 Debug: Boot log
    if (kDebugMode) {
      final auth = context.read<AuthStore>();
      debugPrint('[BOOT] DediApp.initState authState=${auth.state}');
    }

    // Router'ı bir kere oluştur (AuthStore ile)
    final auth = context.read<AuthStore>();
    _router = GoRouter(
      routes: AppRoutes.routes,
      debugLogDiagnostics: true,
      navigatorKey: DediApp.routerKey,
      refreshListenable: auth,
      initialLocation: PlatformInfos.isIOS ? '/splash' : null,
      redirect: (ctx, state) {
        final s = auth.state;
        final loc = state.matchedLocation;

        // 🔍 Debug: Redirect log
        if (kDebugMode) {
          debugPrint('[REDIRECT] authState=$s from=$loc');
        }

        final isAuthFlow = loc.startsWith('/auth') ||
            loc.startsWith('/phone') ||
            loc.startsWith('/onboarding') ||
            loc.startsWith('/otp') ||
            loc.startsWith('/splash');

        // Unknown/Hydrating state → splash
        if (s == AuthState.unknown || s == AuthState.hydrating) {
          return loc == '/splash' ? null : '/splash';
        }

        // Authenticated → rooms (skip auth flow)
        if (s == AuthState.authenticated) {
          return isAuthFlow ? '/rooms' : null;
        }

        // Unauthenticated → phone input (skip other screens)
        return isAuthFlow ? null : '/phone-input';
      },
      onException: (context, state, router) {
        Logs().e('GoRouter exception: ${state.error}');
        if (kDebugMode) {
          debugPrint('[ROUTER ERROR] ${state.error}');
        }
        return router.go('/error');
      },
    );

    // Static referansı güncelle (geriye dönük uyumluluk için)
    DediApp.router = _router;

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await LocalizationService.initializeLanguage(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    networkConnectionService.onDispose();
    _router.dispose();
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
