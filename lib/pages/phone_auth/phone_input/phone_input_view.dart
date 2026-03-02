import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

import 'package:fluffychat/pages/phone_auth/phone_input/phone_input_controller.dart';

/// Modern phone input screen using intl_phone_field package
///
/// This screen uses [PhoneInputController] for state management,
/// separating business logic from UI.
class PhoneInputView extends StatelessWidget {
  final String otpVerifyRoute;
  final bool addAccountMode;

  const PhoneInputView({
    super.key,
    this.otpVerifyRoute = '/otp-verify',
    this.addAccountMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhoneInputController(),
      child: _PhoneInputViewBody(
        otpVerifyRoute: otpVerifyRoute,
        addAccountMode: addAccountMode,
      ),
    );
  }
}

class _PhoneInputViewBody extends StatefulWidget {
  final String otpVerifyRoute;
  final bool addAccountMode;

  const _PhoneInputViewBody({
    required this.otpVerifyRoute,
    required this.addAccountMode,
  });

  @override
  State<_PhoneInputViewBody> createState() => _PhoneInputViewBodyState();
}

class _PhoneInputViewBodyState extends State<_PhoneInputViewBody> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSendOTP() async {
    final controller = context.read<PhoneInputController>();
    final response = await controller.sendOTP();

    if (response != null && mounted) {
      // Navigate to OTP verification with phone number and dev OTP
      context.push(
        widget.otpVerifyRoute,
        extra: {
          'phone': controller.state.phoneNumber,
          'dev_otp': response.devOTP,
          'add_account_mode': widget.addAccountMode,
        },
      );
    }
  }

  void _handleCancelAddAccount() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go('/rooms/profile');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<PhoneInputController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.addAccountMode
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF1D1D1D)),
                onPressed: _handleCancelAddAccount,
              ),
              title: Text(
                L10n.of(context)!.addAnotherAccount,
                style: const TextStyle(
                  color: Color(0xFF1D1D1D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
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

              // Title: Sign In
              Text(
                L10n.of(context)!.loginTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle: Welcome!
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
                  errorText: state.errorMessage?.isNotEmpty == true
                      ? state.errorMessage
                      : null,
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
                  controller.updatePhoneNumber(
                    phone.completeNumber,
                    phone.number.isNotEmpty && phone.number.length >= 10,
                  );
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
                  onPressed: state.isLoading ? null : _handleSendOTP,
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
                  child: state.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
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
