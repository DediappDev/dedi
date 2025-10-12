import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/widgets/matrix.dart';

/// New splash screen with gradient background and Dedi branding
/// Replaces the old basic splash screen with a modern design
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Add small delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      final isFirstTime = prefs.getBool('first_time') ?? true;

      // Check if Matrix client has valid session
      final matrixState = Matrix.maybeOf(context);
      final hasValidSession = matrixState?.client.isLogged() == true;

      if (mounted) {
        if (isLoggedIn && hasValidSession) {
          // User is logged in and has valid Matrix session → go to rooms
          context.go('/rooms');
        } else if (isFirstTime) {
          // First time user → show onboarding
          context.go('/onboarding');
        } else {
          // Returning user but not logged in → go to phone input
          context.go('/phone-input');
        }
      }
    } catch (e) {
      // Error checking login state → go to onboarding
      if (mounted) {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4FC3F7), // Light blue
              Color(0xFF2196F3), // Rich blue
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dedi logo in chat bubble
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/dedi_splash_logo.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to splash_logo if dedi_splash_logo doesn't exist
                      return Image.asset(
                        'assets/images/splash_logo@2x.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Final fallback to icon
                          return const Icon(
                            Icons.chat_bubble_rounded,
                            size: 80,
                            color: Colors.white,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // App tagline
              Text(
                L10n.of(context)!.splashTagline,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Loading indicator
              const SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

