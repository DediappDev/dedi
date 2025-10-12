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

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Fade-in animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    
    // Scale animation for logo
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );
    
    // Pulse animation for loading indicator
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _fadeController.forward();
    _scaleController.forward();
    _initializeApp();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
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
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4FC3F7), // Light blue
              Color(0xFF2196F3), // Medium blue
              Color(0xFF1976D2), // Rich blue
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: Column(
              children: [
                // Logo section (centered vertically)
                Expanded(
                  child: Center(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Dedi logo with glow effect
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(90),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/dedi_splash_logo.png',
                                width: 140,
                                height: 140,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback to splash_logo if dedi_splash_logo doesn't exist
                                  return Image.asset(
                                    'assets/images/splash_logo@2x.png',
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Final fallback to icon
                                      return const Icon(
                                        Icons.chat_bubble_rounded,
                                        size: 90,
                                        color: Colors.white,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 60),
                          
                          // Pulsing loading indicator
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 3.5,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Tagline at bottom (matching LaunchScreen style)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Türkiye'nin",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        "Mesajlaşma Platformu",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.05), // 5% of screen height
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

