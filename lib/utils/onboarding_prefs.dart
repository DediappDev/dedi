import 'package:shared_preferences/shared_preferences.dart';

/// Utility class for managing onboarding preference
///
/// This class provides a simple interface to track whether the user has
/// completed the onboarding flow. The preference is persisted using
/// SharedPreferences and survives app restarts.
class OnboardingPrefs {
  static const _key = 'onboarding_done';

  /// Check if the user has completed onboarding
  ///
  /// Returns `true` if onboarding was previously marked as done,
  /// `false` for first-time users or after a reset.
  static Future<bool> isDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  /// Mark onboarding as completed
  ///
  /// This should be called when the user completes the onboarding flow
  /// (either by clicking "Başlayalım" or completing OTP authentication).
  static Future<void> setDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }

  /// Reset onboarding status (for testing or settings option)
  ///
  /// This will cause the onboarding screen to show again on next launch.
  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
