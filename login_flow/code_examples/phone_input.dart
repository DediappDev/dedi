/// Phone Input Screen Implementation
/// Based on: lib/feature/auth/otp/phone_input.dart
///
/// This is a complete, production-ready phone input screen that:
/// - Validates Turkish phone numbers (+90 prefix)
/// - Handles OTP request to backend
/// - Provides user feedback and error handling
/// - Supports development mode auto-fill

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'http_helper.dart'; // Your HTTP helper implementation
import 'env_config.dart'; // Your environment configuration

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _controller = TextEditingController();
  bool _loading = false;
  String _errorMessage = '';

  /// Validates and sends OTP request to backend
  Future<void> _requestOtp() async {
    // Basic phone number validation
    if (_controller.text.trim().length < 10) {
      setState(() => _errorMessage = 'Geçerli bir telefon numarası giriniz');
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      // Format phone number with country code
      final phone = '+90${_controller.text.trim().replaceAll(RegExp(r'\D'), '')}';

      // Send OTP request to your backend
      final data = await HttpHelper.sendOtpRequest(phone);

      if (mounted) {
        // Handle development mode auto-fill (optional)
        final devOtp = data['dev_otp'] as String?;
        if (EnvConfig.autoFillDevOtp && devOtp != null && devOtp.length == 6) {
          // Navigate with development OTP for testing
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerifyPage(
                phoneNumber: phone,
                devOtp: devOtp,
              ),
            ),
          );
        } else {
          // Normal flow - navigate to OTP verification
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerifyPage(
                phoneNumber: phone,
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('[PhoneInputPage] OTP request error: $e');
      setState(() => _errorMessage = 'Bağlantı hatası: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dedi - Giriş'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo (replace with your logo)
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.chat,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                "Giriş Yap",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                "Telefon numaranızı girerek devam edin",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Phone input field
              TextField(
                controller: _controller,
                keyboardType: TextInputType.phone,
                enabled: !_loading,
                decoration: InputDecoration(
                  labelText: "Telefon Numarası",
                  prefixText: "+90 ",
                  prefixStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  errorText: _errorMessage.isEmpty ? null : _errorMessage,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                onSubmitted: (_) => _requestOtp(),
              ),

              const SizedBox(height: 32),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _requestOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Doğrulama Kodu Al",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              // Terms and privacy (optional)
              Text(
                "Devam ederek Kullanım Şartları ve Gizlilik Politikası'nı kabul etmiş olursunuz.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Environment Configuration Class
/// Create this class to manage development settings
class EnvConfig {
  static const bool autoFillDevOtp = bool.fromEnvironment('AUTO_FILL_DEV_OTP', defaultValue: false);
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'https://api.yourapp.com');
}

/// OTP Verify Page Interface
/// This is the interface for the next screen in the flow
class OtpVerifyPage extends StatelessWidget {
  final String phoneNumber;
  final String? devOtp;

  const OtpVerifyPage({
    super.key,
    required this.phoneNumber,
    this.devOtp,
  });

  @override
  Widget build(BuildContext context) {
    // This will be implemented in otp_verification.dart
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Center(
        child: Text('OTP verification for $phoneNumber'),
      ),
    );
  }
}