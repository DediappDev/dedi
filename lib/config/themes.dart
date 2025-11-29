import 'package:fluffychat/di/global/get_it_initializer.dart';
import 'package:fluffychat/utils/responsive/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:linagora_design_flutter/colors/linagora_ref_colors.dart';
import 'package:linagora_design_flutter/colors/linagora_sys_colors.dart';

import 'app_config.dart';

abstract class DediThemes {
  static const double columnWidth = 360.0;
  static const double iconSize = 24.0;

  static bool isColumnModeByWidth(double width) => width > columnWidth * 2 + 64;

  static bool isColumnMode(BuildContext context) =>
      isColumnModeByWidth(MediaQuery.sizeOf(context).width);

  static bool getDisplayNavigationRail(BuildContext context) =>
      !(GoRouterState.of(context).path?.startsWith('/settings') == true);

  static ResponsiveUtils responsive = getIt.get<ResponsiveUtils>();

  static var fallbackTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.15,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      fontSize: 32,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      letterSpacing: -0.15,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
  );

  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Curve animationCurve = Curves.easeInOut;

  static ThemeData buildTheme(
    BuildContext context,
    Brightness brightness, [
    Color? seed,
  ]) =>
      ThemeData(
        visualDensity: VisualDensity.standard,
        useMaterial3: true,
        fontFamily: 'Inter',
        textTheme: brightness == Brightness.light
            ? Typography.material2021().black.merge(fallbackTextTheme)
            : Typography.material2021().white.merge(fallbackTextTheme),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        scaffoldBackgroundColor: LinagoraSysColors.material().onPrimary,
        dividerColor: brightness == Brightness.light
            ? Colors.blueGrey.shade50
            : Colors.blueGrey.shade900,
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConfig.borderRadius),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
          ),
          hintStyle: fallbackTextTheme.bodyLarge?.merge(
            TextStyle(
              fontSize: 17,
              color: DediRefColors.material().neutralVariant[60],
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          toolbarHeight: AppConfig.toolbarHeight(context),
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: brightness.reversed,
            statusBarBrightness: brightness,
          ),
          foregroundColor: brightness == Brightness.light
              ? DediSysColors.material().onBackground
              : DediSysColors.material().onBackgroundDark,
          backgroundColor: DediSysColors.material().onPrimary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
            ),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConfig.borderRadius / 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConfig.borderRadius),
            ),
          ),
        ),
        highlightColor: DediRefColors.material().tertiary[80],
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed ?? AppConfig.colorSchemeSeed,
          brightness: brightness,
          primary: brightness == Brightness.light
              ? DediSysColors.material().primary
              : DediSysColors.material().primaryDark,
          onPrimary: brightness == Brightness.light
              ? DediSysColors.material().onPrimary
              : DediSysColors.material().onPrimaryDark,
          primaryContainer: brightness == Brightness.light
              ? DediSysColors.material().primaryContainer
              : DediSysColors.material().primaryContainerDark,
          onPrimaryContainer: brightness == Brightness.light
              ? DediSysColors.material().onPrimaryContainer
              : DediSysColors.material().onPrimaryContainerDark,
          inversePrimary: brightness == Brightness.light
              ? DediSysColors.material().inversePrimary
              : DediSysColors.material().inversePrimaryDark,
          tertiary: brightness == Brightness.light
              ? DediSysColors.material().tertiary
              : DediSysColors.material().tertiaryDark,
          onTertiary: brightness == Brightness.light
              ? DediSysColors.material().onTertiary
              : DediSysColors.material().onTertiaryDark,
          tertiaryContainer: brightness == Brightness.light
              ? DediSysColors.material().tertiaryContainer
              : DediSysColors.material().tertiaryContainerDark,
          onTertiaryContainer: brightness == Brightness.light
              ? DediSysColors.material().onTertiaryContainer
              : DediSysColors.material().onTertiaryContainerDark,
          secondary: brightness == Brightness.light
              ? DediSysColors.material().secondary
              : DediSysColors.material().secondaryDark,
          onSecondary: brightness == Brightness.light
              ? DediSysColors.material().onSecondary
              : DediSysColors.material().onSecondaryDark,
          secondaryContainer: brightness == Brightness.light
              ? DediSysColors.material().secondaryContainer
              : DediSysColors.material().secondaryContainerDark,
          onSecondaryContainer: brightness == Brightness.light
              ? DediSysColors.material().onSecondaryContainer
              : DediSysColors.material().onSecondaryContainerDark,
          // TODO: remove when the color scheme is updated
          // ignore: deprecated_member_use
          background: brightness == Brightness.light
              ? DediSysColors.material().background
              : DediSysColors.material().backgroundDark,
          // TODO: remove when the color scheme is updated
          // ignore: deprecated_member_use
          onBackground: brightness == Brightness.light
              ? DediSysColors.material().onBackground
              : DediSysColors.material().onBackgroundDark,
          error: brightness == Brightness.light
              ? DediSysColors.material().error
              : DediSysColors.material().errorDark,
          onError: brightness == Brightness.light
              ? DediSysColors.material().onError
              : DediSysColors.material().onErrorDark,
          errorContainer: brightness == Brightness.light
              ? DediSysColors.material().errorContainer
              : DediSysColors.material().errorContainerDark,
          onErrorContainer: brightness == Brightness.light
              ? DediSysColors.material().onErrorContainer
              : DediSysColors.material().onErrorContainerDark,
          surface: brightness == Brightness.light
              ? DediSysColors.material().surface
              : DediSysColors.material().surfaceDark,
          onSurface: brightness == Brightness.light
              ? DediSysColors.material().onSurface
              : DediSysColors.material().onSurfaceDark,
          surfaceTint: brightness == Brightness.light
              ? DediSysColors.material().surfaceTint
              : DediSysColors.material().surfaceTintDark,
          surfaceContainerHighest: brightness == Brightness.light
              ? DediSysColors.material().surfaceVariant
              : DediSysColors.material().surfaceVariantDark,
          onSurfaceVariant: brightness == Brightness.light
              ? DediSysColors.material().onSurfaceVariant
              : DediSysColors.material().onSurfaceVariantDark,
          inverseSurface: brightness == Brightness.light
              ? DediSysColors.material().inverseSurface
              : DediSysColors.material().inverseSurfaceDark,
          onInverseSurface: brightness == Brightness.light
              ? DediSysColors.material().onInverseSurface
              : DediSysColors.material().onInverseSurfaceDark,
          shadow: brightness == Brightness.light
              ? DediSysColors.material().shadow
              : DediSysColors.material().shadowDark,
          outline: brightness == Brightness.light
              ? DediSysColors.material().outline
              : DediSysColors.material().outlineDark,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: brightness == Brightness.light
              ? DediSysColors.material().primary
              : DediSysColors.material().primaryDark,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: WidgetStateProperty.all(iconSize),
            iconColor: WidgetStateProperty.all(
              brightness == Brightness.light
                  ? DediSysColors.material().onSurface
                  : DediSysColors.material().onSurfaceDark,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          size: iconSize,
          color: brightness == Brightness.light
              ? DediSysColors.material().onBackground
              : DediSysColors.material().onBackgroundDark,
        ),
        switchTheme: SwitchThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return brightness == Brightness.light
                    ? DediSysColors.material().primary
                    : DediSysColors.material().primaryDark;
              } else {
                return brightness == Brightness.light
                    ? DediSysColors.material().outline
                    : DediSysColors.material().outlineDark;
              }
            },
          ),
          thumbColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return brightness == Brightness.light
                    ? DediSysColors.material().onPrimary
                    : DediSysColors.material().onPrimaryDark;
              } else {
                return brightness == Brightness.light
                    ? DediSysColors.material().outline
                    : DediSysColors.material().outlineDark;
              }
            },
          ),
          trackColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return brightness == Brightness.light
                    ? DediSysColors.material().primary
                    : DediSysColors.material().primaryDark;
              } else {
                return brightness == Brightness.light
                    ? DediSysColors.material().surface
                    : DediSysColors.material().surfaceDark;
              }
            },
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 64,
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return fallbackTextTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  color: DediSysColors.material().primary,
                );
              }
              return responsive.isDesktop(context)
                  ? fallbackTextTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      color: DediRefColors.material().neutral[10],
                    )
                  : fallbackTextTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      color: DediSysColors.material().tertiary,
                    );
            },
          ),
          backgroundColor: brightness == Brightness.light
              ? DediSysColors.material().surface
              : DediSysColors.material().surfaceDark,
          shadowColor: brightness == Brightness.light
              ? Colors.black.withOpacity(0.15)
              : Colors.white.withOpacity(0.15),
          elevation: 4.0,
          overlayColor: WidgetStateColor.resolveWith(
            (states) {
              return Colors.transparent;
            },
          ),
        ),
        navigationRailTheme: NavigationRailThemeData(
          indicatorColor: brightness == Brightness.light
              ? DediSysColors.material().inversePrimary
              : DediSysColors.material().secondaryContainerDark,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: brightness == Brightness.light
              ? DediSysColors.material().background
              : DediSysColors.material().backgroundDark,
          surfaceTintColor: brightness == Brightness.light
              ? DediSysColors.material().background
              : DediSysColors.material().backgroundDark,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: DediSysColors.material().surface,
          selectedLabelStyle: fallbackTextTheme.labelSmall?.copyWith(
            fontSize: 11,
            color: DediSysColors.material().primary,
          ),
          unselectedLabelStyle: fallbackTextTheme.labelSmall?.copyWith(
            fontSize: 11,
            color: DediSysColors.material().tertiary,
          ),
          selectedItemColor: DediSysColors.material().primary,
          unselectedItemColor: DediSysColors.material().tertiary,
        ),
      );
}

extension on Brightness {
  Brightness get reversed =>
      this == Brightness.dark ? Brightness.light : Brightness.dark;
}
