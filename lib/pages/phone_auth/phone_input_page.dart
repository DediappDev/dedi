import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:fluffychat/services/otp_api_service.dart';

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    if (_errorMessage.isNotEmpty) {
      setState(() {
        _errorMessage = '';
      });
    }
  }

  String _formatPhoneNumber(String input) {
    // Remove all non-digit characters
    final digits = input.replaceAll(RegExp(r'\D'), '');

    // Limit to 10 digits (Turkish mobile numbers)
    final limitedDigits = digits.length > 10 ? digits.substring(0, 10) : digits;

    // Format as XXX XXX XX XX
    String formatted = '';
    for (int i = 0; i < limitedDigits.length; i++) {
      if (i == 3 || i == 6 || i == 8) {
        formatted += ' ';
      }
      formatted += limitedDigits[i];
    }

    return formatted;
  }

  bool _isValidPhoneNumber(String phone) {
    // Remove spaces and check if it's a valid Turkish mobile number
    final digits = phone.replaceAll(' ', '');

    // Turkish mobile numbers: 5XX XXX XX XX (10 digits starting with 5)
    if (digits.length != 10) return false;
    if (!digits.startsWith('5')) return false;

    // Check second digit (valid ranges)
    final secondDigit = digits[1];
    return ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].contains(secondDigit);
  }

  Future<void> _sendOTP() async {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      setState(() {
        _errorMessage = 'Lütfen telefon numaranızı giriniz';
      });
      return;
    }

    if (!_isValidPhoneNumber(phone)) {
      setState(() {
        _errorMessage = 'Geçerli bir telefon numarası giriniz';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Format phone number for API (+90 prefix)
      final phoneDigits = phone.replaceAll(' ', '');
      final formattedPhone = '+90$phoneDigits';

      final response = await OTPApiService.requestOTP(formattedPhone);

      if (mounted) {
        // Navigate to OTP verification with phone number and dev OTP
        context.push('/otp-verify', extra: {
          'phone': formattedPhone,
          'dev_otp': response['dev_otp'],
        });
      }
    } catch (e) {
      if (mounted) {
        String errorMsg = 'Bir hata oluştu. Lütfen tekrar deneyin.';

        // Parse specific error messages
        final errorStr = e.toString().toLowerCase();
        if (errorStr.contains('network') || errorStr.contains('connection')) {
          errorMsg = 'İnternet bağlantınızı kontrol edin.';
        } else if (errorStr.contains('timeout')) {
          errorMsg = 'İstek zaman aşımına uğradı. Tekrar deneyin.';
        } else if (errorStr.contains('invalid phone')) {
          errorMsg = 'Geçersiz telefon numarası.';
        }

        setState(() {
          _errorMessage = errorMsg;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = _phoneController.text.isNotEmpty && !_isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // Title
              const Text(
                'Telefon Numaranız',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Text(
                'Size bir doğrulama kodu göndereceğiz',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 48),

              // Phone input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Telefon Numarası',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1D1D1D),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    enabled: !_isLoading,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final formatted = _formatPhoneNumber(newValue.text);
                        return newValue.copyWith(
                          text: formatted,
                          selection: TextSelection.collapsed(offset: formatted.length),
                        );
                      }),
                    ],
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 24,
                              height: 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.red,
                              ),
                              child: const Center(
                                child: Text(
                                  '🇹🇷',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '+90',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1D1D1D),
                              ),
                            ),
                            Container(
                              height: 24,
                              width: 1,
                              color: Colors.grey[300],
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ],
                        ),
                      ),
                      hintText: '5XX XXX XX XX',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      errorText: _errorMessage.isEmpty ? null : _errorMessage,
                    ),
                    onSubmitted: (_) => isButtonEnabled ? _sendOTP() : null,
                  ),
                ],
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isButtonEnabled ? _sendOTP : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonEnabled
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                    foregroundColor: isButtonEnabled
                        ? Colors.white
                        : Colors.grey[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Doğrulama Kodu Gönder',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              // Terms and privacy
              Text(
                'Devam ederek Kullanım Şartları ve Gizlilik Politikası\'nı kabul etmiş olursunuz.',
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
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }
}