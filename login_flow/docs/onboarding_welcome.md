# Onboarding & Welcome Screen Implementation Guide

## 📋 Overview

This guide provides complete implementation details for the Dedi app's welcome/onboarding experience, which serves as the entry point for new users after the splash screen. The welcome screen introduces the app, explains its purpose, and guides users to start the authentication process.

## 🎨 Design Specifications

### Visual Design
- **App Logo**: Featured prominently at the top
- **Introduction Text**: Clear, welcoming message about the app
- **Call-to-Action**: Prominent "Get Started" button
- **Background**: Clean, minimal white background
- **Typography**: Clear hierarchy with headings and body text

### Layout Structure
1. **Header**: App bar with title and menu options
2. **Hero Section**: Large app logo with animation tag
3. **Content**: Introduction text and description
4. **Action Section**: Primary CTA button
5. **Footer**: Terms and privacy information

## 🛠 Complete Implementation

### Welcome Screen Controller

```dart
/// Welcome Screen Controller
/// Based on: lib/pages/homeserver_picker/homeserver_picker.dart
///
/// This controller manages the welcome screen logic, including
/// navigation to phone input and optional homeserver selection

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  final bool addMultiAccount;
  const WelcomeScreen({this.addMultiAccount = false, super.key});

  @override
  WelcomeScreenController createState() => WelcomeScreenController();
}

class WelcomeScreenController extends State<WelcomeScreen> {
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _initializeWelcomeScreen();
  }

  /// Initialize welcome screen and check if we should auto-navigate
  Future<void> _initializeWelcomeScreen() async {
    // Check if user has seen onboarding before
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

    // If app is configured for direct phone login, skip to phone input
    if (!AppConfig.allowOtherHomeservers && hasSeenOnboarding) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/home/phone');
        }
      });
    }
  }

  /// Handle "Get Started" button tap
  Future<void> getStartedAction() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      // Mark onboarding as seen
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_seen_onboarding', true);

      // Navigate to phone input
      if (mounted) {
        context.go('/home/phone');
      }
    } catch (e) {
      setState(() {
        error = 'Unable to continue. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Handle more actions menu (settings, privacy, about)
  void onMoreAction(MoreWelcomeActions action) {
    switch (action) {
      case MoreWelcomeActions.privacy:
        launchUrlString(AppConfig.privacyUrl);
        break;
      case MoreWelcomeActions.about:
        PlatformInfos.showDialog(context);
        break;
      case MoreWelcomeActions.settings:
        _showAppSettings();
        break;
    }
  }

  void _showAppSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('App Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: true,
              onChanged: (value) {
                // Handle notification setting
              },
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: false,
              onChanged: (value) {
                // Handle theme setting
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => WelcomeScreenView(this);
}

enum MoreWelcomeActions { privacy, about, settings }
```

### Welcome Screen View

```dart
/// Welcome Screen View
/// Based on: lib/pages/homeserver_picker/homeserver_picker_view.dart
///
/// This provides the UI layout for the welcome screen with modern design

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WelcomeScreenView extends StatelessWidget {
  final WelcomeScreenController controller;

  const WelcomeScreenView(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          controller.widget.addMultiAccount ? 'Add Account' : 'Welcome to Dedi',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          PopupMenuButton<MoreWelcomeActions>(
            useRootNavigator: true,
            onSelected: controller.onMoreAction,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: MoreWelcomeActions.settings,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.settings_outlined),
                    SizedBox(width: 12),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: MoreWelcomeActions.privacy,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.privacy_tip_outlined),
                    SizedBox(width: 12),
                    Text('Privacy'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: MoreWelcomeActions.about,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outlined),
                    SizedBox(width: 12),
                    Text('About'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),

                        // Hero Logo Section
                        Hero(
                          tag: 'welcome-logo',
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                'assets/images/dedi_logo_light.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Welcome Title
                        Text(
                          'Welcome to Dedi',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1D1D1D),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 16),

                        // Introduction Text
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SelectableLinkify(
                            text: 'Dedi lets you chat with your friends across different messengers. Learn more at https://matrix.org or just tap *Continue*.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                            linkStyle: TextStyle(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                            onOpen: (link) => launchUrlString(link.url),
                          ),
                        ),

                        const Spacer(),

                        // Main Action Section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Secure Messaging Heading
                              Text(
                                'Start secure messaging',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1D1D1D),
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 16),

                              // Description
                              Text(
                                'You can start immediately by verifying with your phone number.',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[600],
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(height: 32),

                              // Get Started Button
                              SizedBox(
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF47C2FF),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: controller.isLoading ? null : controller.getStartedAction,
                                  child: controller.isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          'Get Started',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Error Message
                              if (controller.error != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.red[200]!),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.error_outline, color: Colors.red[600]),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          controller.error!,
                                          style: TextStyle(color: Colors.red[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],

                              // Terms and Privacy
                              Text(
                                'By continuing, you agree to our Terms of Service and Privacy Policy.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

### Alternative: Multi-Page Onboarding

For apps requiring more detailed onboarding with multiple steps:

```dart
/// Multi-Page Onboarding Implementation
/// Use this for complex apps that need step-by-step introduction

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/images/ob1.png',
      title: 'Secure Messaging',
      description: 'Send encrypted messages to keep your conversations private and secure.',
    ),
    OnboardingPage(
      image: 'assets/images/ob2.png',
      title: 'Cross-Platform',
      description: 'Chat with friends across different messaging platforms using Matrix protocol.',
    ),
    OnboardingPage(
      image: 'assets/images/ob3.png',
      title: 'Easy Setup',
      description: 'Get started in seconds with just your phone number verification.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text('Skip'),
                ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          page.image,
                          height: 280,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 60),
                        Text(
                          page.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D1D1D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          page.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicators and navigation
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF47C2FF)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Navigation buttons
                  Row(
                    children: [
                      if (_currentPage > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF47C2FF)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size.fromHeight(52),
                            ),
                            child: const Text('Previous'),
                          ),
                        ),
                      if (_currentPage > 0) const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage < _pages.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _completeOnboarding();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF47C2FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size.fromHeight(52),
                          ),
                          child: Text(
                            _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home/phone');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}
```

## 🔄 Navigation Flow Integration

### Router Configuration

```dart
/// Update your routes to include onboarding
/// Add to lib/config/routes.dart

static final List<RouteBase> routes = [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => defaultPageBuilder(
      context,
      state,
      const SplashScreen(),
    ),
  ),
  GoRoute(
    path: '/welcome',
    pageBuilder: (context, state) => defaultPageBuilder(
      context,
      state,
      const WelcomeScreen(),
    ),
    routes: [
      GoRoute(
        path: 'onboarding',
        pageBuilder: (context, state) => defaultPageBuilder(
          context,
          state,
          const OnboardingScreen(),
        ),
      ),
    ],
  ),
  GoRoute(
    path: '/home',
    pageBuilder: (context, state) => defaultPageBuilder(
      context,
      state,
      const HomeserverPicker(addMultiAccount: false),
    ),
    redirect: loggedInRedirect,
    routes: [
      // ... phone and otp routes
    ],
  ),
];
```

### Conditional Navigation Logic

```dart
/// Main App Navigation Logic
/// Determines where to route users based on their state

class AppNavigationController {
  static Future<String> determineInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();

    // Check if user is logged in
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    if (isLoggedIn) {
      return '/rooms';
    }

    // Check if user has seen onboarding
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;
    if (!hasSeenOnboarding) {
      return '/welcome';
    }

    // Direct to home for returning users
    return '/home';
  }

  static Future<bool> shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('has_seen_onboarding') ?? false);
  }

  static Future<void> markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
  }
}
```

## 🎯 Customization Options

### Branding Customization

```dart
class WelcomeTheme {
  static const Color primaryColor = Color(0xFF47C2FF);
  static const Color backgroundColor = Colors.white;
  static const Color textPrimary = Color(0xFF1D1D1D);
  static const Color textSecondary = Color(0xFF666666);

  static const double logoSize = 160;
  static const double buttonHeight = 56;
  static const double borderRadius = 16;

  static const String logoAsset = 'assets/images/dedi_logo_light.png';
  static const String welcomeTitle = 'Welcome to Dedi';
  static const String welcomeMessage = 'Dedi lets you chat with your friends across different messengers.';
}
```

### Content Customization

```dart
class WelcomeContent {
  static const String appName = 'Dedi';
  static const String tagline = 'Secure messaging for everyone';
  static const String description = 'Connect with friends across different messaging platforms using the Matrix protocol.';

  static const List<String> features = [
    'End-to-end encryption',
    'Cross-platform messaging',
    'Decentralized architecture',
    'Open source protocol',
  ];

  static const String ctaText = 'Get Started';
  static const String skipText = 'Skip';
  static const String termsText = 'By continuing, you agree to our Terms of Service and Privacy Policy.';
}
```

## 📱 Platform-Specific Considerations

### Android
- **Material Design**: Use Material 3 components
- **Navigation**: Handle system back button properly
- **Permissions**: Request necessary permissions during onboarding
- **Dark Mode**: Support system dark mode preferences

### iOS
- **Human Interface Guidelines**: Follow iOS design patterns
- **Safe Areas**: Handle notches and home indicators
- **Navigation**: Use appropriate iOS navigation patterns
- **Accessibility**: Support VoiceOver and other accessibility features

### Web
- **Responsive Design**: Adapt to different screen sizes
- **Keyboard Navigation**: Support tab navigation
- **SEO**: Include proper meta tags and descriptions
- **Performance**: Optimize for web loading times

## 🔧 Testing Strategy

### Unit Tests
```dart
testWidgets('Welcome screen displays correctly', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

  expect(find.text('Welcome to Dedi'), findsOneWidget);
  expect(find.text('Get Started'), findsOneWidget);
  expect(find.byType(Image), findsOneWidget);
});

testWidgets('Get Started button navigates correctly', (WidgetTester tester) async {
  // Test navigation logic
});
```

### Integration Tests
- Test complete onboarding flow
- Verify navigation between screens
- Test error handling scenarios
- Validate data persistence

## 📝 Accessibility Guidelines

### WCAG Compliance
- **Color Contrast**: Ensure 4.5:1 ratio for text
- **Touch Targets**: Minimum 44x44 points
- **Screen Reader**: Provide semantic labels
- **Focus Management**: Logical tab order

### Implementation
```dart
Semantics(
  label: 'Get started with Dedi messaging',
  hint: 'Navigates to phone number verification',
  child: ElevatedButton(
    onPressed: controller.getStartedAction,
    child: const Text('Get Started'),
  ),
)
```

This comprehensive implementation provides a professional, accessible, and user-friendly welcome experience that effectively introduces new users to your Matrix-based messaging application.