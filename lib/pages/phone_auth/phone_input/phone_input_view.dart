import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:fluffychat/services/otp_api_service.dart';

/// Modern phone input screen using intl_phone_field package
/// Replaces the old basic TextField implementation
class PhoneInputView extends StatefulWidget {
  const PhoneInputView({super.key});

  @override
  State<PhoneInputView> createState() => _PhoneInputViewState();
}

class _PhoneInputViewState extends State<PhoneInputView> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  String _fullPhoneNumber = '';
  bool _isValidNumber = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (_fullPhoneNumber.isEmpty || !_isValidNumber) {
      setState(() {
        _errorMessage = L10n.of(context)!.pleaseEnterValidPhone;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await OTPApiService.requestOTP(_fullPhoneNumber);
      
      if (kDebugMode) {
        debugPrint('OTP request success for $_fullPhoneNumber: $response');
      }

      if (mounted) {
        // Navigate to OTP verification with phone number and dev OTP
        context.push(
          '/otp-verify',
          extra: {
            'phone': _fullPhoneNumber,
            'dev_otp': response['dev_otp'] as String?,
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTP request error: $e');
      }
      
      setState(() {
        _errorMessage = L10n.of(context)!.otpRequestFailed;
      });
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
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Dedi Logo
              Image.asset(
                'assets/images/dedi_logo_light.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Title: Giriş Yap
              Text(
                L10n.of(context)!.loginTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle: Hoş geldiniz!
              Text(
                L10n.of(context)!.welcomeMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF757575),
                ),
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                L10n.of(context)!.loginDescription,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Phone Input Field with intl_phone_field
              IntlPhoneField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: L10n.of(context)!.phoneNumberLabel,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF757575),
                  ),
                  hintText: '(555) 000-0000',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF2196F3),
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                ),
                initialCountryCode: 'TR',
                flagsButtonMargin: const EdgeInsets.only(left: 12),
                dropdownIconPosition: IconPosition.trailing,
                dropdownIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF757575),
                ),
                showCountryFlag: true,
                showDropdownIcon: true,
                onChanged: (phone) {
                  setState(() {
                    _fullPhoneNumber = phone.completeNumber;
                    _isValidNumber = phone.number.isNotEmpty && 
                        phone.number.length >= 10;
                    if (_errorMessage.isNotEmpty) {
                      _errorMessage = '';
                    }
                  });
                },
                onCountryChanged: (country) {
                  if (kDebugMode) {
                    debugPrint('Country changed to: ${country.name}');
                  }
                },
              ),

              const SizedBox(height: 32),

              // Send OTP Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE0E0E0),
                    disabledForegroundColor: const Color(0xFF9E9E9E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          L10n.of(context)!.getVerificationCode,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

