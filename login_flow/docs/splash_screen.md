# Splash Screen Implementation Guide

## 📋 Overview

This guide provides complete implementation details for the Dedi app's splash screen, including native splash screen configuration, custom splash implementation, and platform-specific considerations.

## 🎨 Design Specifications

### Visual Design
- **Background Color**: `#47C2FF` (Bright blue)
- **Logo**: White Dedi logo (192x192px optimal size)
- **Style**: Minimalist, centered logo on solid background
- **Duration**: System-controlled native splash + optional custom splash

### Brand Guidelines
- **Primary Color**: `#47C2FF` (Dedi Blue)
- **Logo Placement**: Center of screen
- **Logo Size**: 192x192px for optimal display across all devices
- **Background**: Solid color, no gradients or patterns

## 🛠 Implementation Options

### Option 1: Native Splash Screen (Recommended)

This is the current implementation used in Dedi, providing the fastest app startup experience.

#### Configuration File: `flutter_native_splash_config.yaml`

```yaml
flutter_native_splash:
  # Brand colors
  color: "#47C2FF"
  color_dark: "#47C2FF"

  # Logo configuration
  image: "assets/appLogo.png"
  image_dark: "assets/appLogo.png"

  # Platform support
  android: true
  ios: true
  web: true

  # Web-specific settings
  web_image_mode: "center"

  # Android 12+ specific settings
  android_12:
    image: "assets/appLogo.png"
    color: "#47C2FF"
    image_dark: "assets/appLogo.png"
    color_dark: "#47C2FF"
```

#### Setup Commands

```bash
# Add the flutter_native_splash dependency
flutter pub add flutter_native_splash

# Generate native splash screens
flutter pub run flutter_native_splash:create

# To remove (if needed)
flutter pub run flutter_native_splash:remove
```

#### Platform-Specific Files Generated

**Android:**
- `android/app/src/main/res/drawable/launch_background.xml`
- `android/app/src/main/res/drawable-*/splash.png` (multiple densities)
- `android/app/src/main/res/values/styles.xml` (updated)

**iOS:**
- `ios/Runner/Assets.xcassets/LaunchImage.imageset/`
- `ios/Runner/Base.lproj/LaunchScreen.storyboard`

**Web:**
- `web/splash/` directory with web-optimized assets

### Option 2: Custom Splash Screen Widget

For apps requiring custom animations or logic during splash.

```dart
/// Custom Splash Screen Implementation
/// Use this if you need custom animations or loading logic

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _logoScale;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoScale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
  }

  Future<void> _startSplashSequence() async {
    // Start animations
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    // Minimum splash duration
    await Future.delayed(const Duration(milliseconds: 2000));

    // Check authentication state and navigate
    await _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      if (mounted) {
        if (isLoggedIn) {
          Navigator.of(context).pushReplacementNamed('/rooms');
        } else {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      print('[SplashScreen] Error checking auth state: $e');
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF47C2FF),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: const Color(0xFF47C2FF),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_logoController, _fadeController]),
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/appLogo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
```

### Option 3: Hybrid Approach (Best of Both)

Combine native splash for instant display with custom splash for additional logic.

```dart
/// Hybrid Splash Implementation
/// Native splash shows immediately, custom splash handles app initialization

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HybridSplashScreen extends StatefulWidget {
  const HybridSplashScreen({super.key});

  @override
  State<HybridSplashScreen> createState() => _HybridSplashScreenState();
}

class _HybridSplashScreenState extends State<HybridSplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize app dependencies
      await _loadConfiguration();
      await _checkAuthenticationState();
      await _preloadAssets();

      // Minimum display time for branding
      await Future.delayed(const Duration(milliseconds: 1500));

      // Remove native splash and navigate
      FlutterNativeSplash.remove();
      await _navigateToNextScreen();
    } catch (e) {
      print('[HybridSplash] Initialization error: $e');
      FlutterNativeSplash.remove();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  Future<void> _loadConfiguration() async {
    // Load app configuration
    // Initialize Matrix client
    // Set up logging
  }

  Future<void> _checkAuthenticationState() async {
    final prefs = await SharedPreferences.getInstance();
    // Check if user is logged in
    // Validate stored tokens
    // Prepare Matrix client if needed
  }

  Future<void> _preloadAssets() async {
    // Preload critical images
    await precacheImage(const AssetImage('assets/images/dedi_logo_light.png'), context);
    await precacheImage(const AssetImage('assets/appLogo.png'), context);
  }

  Future<void> _navigateToNextScreen() async {
    if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed('/rooms');
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This widget is only shown if native splash is removed early
    return const Scaffold(
      backgroundColor: Color(0xFF47C2FF),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
```

## 📱 Platform-Specific Considerations

### Android
- **API Level 31+**: Uses new splash screen API automatically
- **Older Android**: Uses traditional launch screen
- **Adaptive Icons**: Ensure logo works with circular masks
- **Theme Support**: Dark mode configuration available

### iOS
- **LaunchScreen.storyboard**: Modern approach for iOS 13+
- **LaunchImage**: Legacy support for older iOS versions
- **Safe Areas**: Logo positioning accounts for notches/home indicator
- **Resolution**: Multiple @1x, @2x, @3x assets for different screen densities

### Web
- **Initial Load**: Shows while Flutter framework loads
- **SEO Friendly**: Includes proper meta tags and loading indicators
- **Performance**: Optimized image formats and sizes
- **PWA Support**: Works with Progressive Web App installations

## 🎯 Implementation Steps

### Step 1: Asset Preparation

```bash
# Create assets directory structure
mkdir -p assets/images
mkdir -p assets/splash

# Add your logo files
# - assets/appLogo.png (192x192px, transparent background)
# - assets/splash_logo.png (optional alternative)
```

### Step 2: Configuration

Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter_native_splash: ^2.3.6

flutter:
  assets:
    - assets/
    - assets/images/
    - assets/splash/

dev_dependencies:
  flutter_native_splash: ^2.3.6
```

### Step 3: Generate Splash Screens

```bash
flutter pub get
flutter pub run flutter_native_splash:create
```

### Step 4: Main App Integration

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // Preserve splash screen until app is ready
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const DediApp());
}

class DediApp extends StatefulWidget {
  const DediApp({super.key});

  @override
  State<DediApp> createState() => _DediAppState();
}

class _DediAppState extends State<DediApp> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // App initialization logic
    await Future.delayed(const Duration(seconds: 2));

    // Remove splash screen
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dedi',
      home: const HomeScreen(),
    );
  }
}
```

## 🔧 Customization Options

### Colors
```yaml
# Primary brand color
color: "#47C2FF"

# Dark mode alternative (optional)
color_dark: "#1E3A8A"

# Gradient backgrounds (advanced)
gradient:
  begin: Alignment.topLeft
  end: Alignment.bottomRight
  colors:
    - "#47C2FF"
    - "#3B82F6"
```

### Logo Variations
```yaml
# Standard logo
image: "assets/appLogo.png"

# Dark mode logo
image_dark: "assets/appLogo_dark.png"

# Platform-specific logos
android_image: "assets/android_logo.png"
ios_image: "assets/ios_logo.png"
web_image: "assets/web_logo.png"
```

### Animation Settings
```yaml
# Fade in animation
android_splash_fade_duration: 300

# Logo scaling
logo_scale: 1.0

# Position adjustments
logo_offset:
  x: 0
  y: -50  # Move logo up slightly
```

## 🚀 Performance Optimization

### Asset Optimization
- **PNG Compression**: Use tools like TinyPNG for smaller file sizes
- **Vector Graphics**: Consider SVG for scalable logos
- **Multiple Densities**: Provide @1x, @2x, @3x versions for iOS
- **WebP Support**: Use WebP format for web platform

### Loading Optimization
- **Preload Critical Assets**: Load important images during splash
- **Initialize Services**: Set up Matrix client, preferences, etc.
- **Network Prefetch**: Start downloading user data if logged in
- **Error Handling**: Graceful fallbacks for initialization failures

## 📝 Testing Checklist

### Visual Testing
- [ ] Logo displays correctly on all screen sizes
- [ ] Colors match brand guidelines exactly
- [ ] Dark mode variation works properly
- [ ] No visual glitches during transitions

### Functional Testing
- [ ] Splash duration feels appropriate (1-3 seconds)
- [ ] App initializes properly during splash
- [ ] Error states handled gracefully
- [ ] Navigation to correct screen after splash

### Platform Testing
- [ ] Android: Multiple API levels and manufacturers
- [ ] iOS: Various device sizes and iOS versions
- [ ] Web: Different browsers and screen sizes
- [ ] Performance: No lag or frame drops

### Accessibility Testing
- [ ] Contrast ratios meet WCAG guidelines
- [ ] Screen readers can navigate properly
- [ ] Reduced motion preferences respected
- [ ] Keyboard navigation works (web)

## 🔍 Troubleshooting

### Common Issues

**Logo Not Displaying:**
- Check file path in configuration
- Verify image format (PNG recommended)
- Ensure image exists in assets folder

**Wrong Colors:**
- Verify hex color format (#RRGGBB)
- Check platform-specific color settings
- Clear app cache and rebuild

**Splash Too Long/Short:**
- Adjust minimum display duration
- Optimize initialization code
- Check for blocking operations

**Build Errors:**
- Run `flutter clean` and `flutter pub get`
- Regenerate splash screens
- Check pubspec.yaml syntax

### Debug Commands

```bash
# Regenerate splash screens
flutter pub run flutter_native_splash:create

# Remove splash screens
flutter pub run flutter_native_splash:remove

# Clean and rebuild
flutter clean
flutter pub get
flutter build apk --debug
```

## 📚 Resources

- [Flutter Native Splash Documentation](https://pub.dev/packages/flutter_native_splash)
- [Android Splash Screen Guide](https://developer.android.com/develop/ui/views/launch/splash-screen)
- [iOS Launch Screen Guide](https://developer.apple.com/design/human-interface-guidelines/launch-screen)
- [Web PWA Splash Guidelines](https://web.dev/splash-screen/)

This implementation provides a professional, fast-loading splash screen that enhances the user experience while maintaining the Dedi brand identity across all platforms.