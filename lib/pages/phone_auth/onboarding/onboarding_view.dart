import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fluffychat/state/auth_store.dart';

/// Onboarding screen shown on first app launch
///
/// This screen introduces the user to the app and allows them to proceed
/// to the phone input screen. After completing onboarding, the preference
/// is saved and this screen won't be shown again unless reset.
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Logo
            Image.asset(
              'assets/images/dedi_logo_light.png',
              width: 120,
              height: 120,
            ),

            const SizedBox(height: 32),

            // Title
            const Text(
              'DEDI\'ye Hoşgeldiniz',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'Güvenli ve şifreli mesajlaşma uygulaması',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),

            const Spacer(),

            // Get Started Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    // Mark onboarding as done
                    final auth = context.read<AuthStore>();
                    await auth.setOnboardingDone();

                    // Navigate to phone input
                    if (context.mounted) {
                      context.go('/phone-input');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Başlayalım',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
