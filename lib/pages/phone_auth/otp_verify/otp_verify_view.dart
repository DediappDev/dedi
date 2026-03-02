import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

import 'package:fluffychat/pages/phone_auth/otp_verify/otp_verify_controller.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:fluffychat/widgets/layouts/agruments/switch_active_account_body_args.dart';
import 'package:fluffychat/state/auth_store.dart';

/// Modern OTP verification screen using pin_code_fields package
///
/// This screen uses [OTPVerifyController] for state management and
/// includes token validation (re-enabled from disabled state).
///
/// **IMPORTANT CHANGE:** Token validation is now active at line 239
/// of otp_verify_controller.dart. Previously disabled, now re-enabled.
class OTPVerifyView extends StatelessWidget {
  final String phoneNumber;
  final String? devOTP;
  final bool addAccountMode;

  const OTPVerifyView({
    super.key,
    required this.phoneNumber,
    this.devOTP,
    this.addAccountMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final matrixState = Matrix.of(context);
    final matrixClient =
        addAccountMode ? matrixState.getLoginClient() : matrixState.client;

    return ChangeNotifierProvider(
      create: (_) => OTPVerifyController(
        phoneNumber: phoneNumber,
        matrixClient: matrixClient,
        authStore: context.read<AuthStore>(),
        devOTP: devOTP,
        startSyncOnAuth: !addAccountMode,
      ),
      child: _OTPVerifyViewBody(
        devOTP: devOTP,
        addAccountMode: addAccountMode,
      ),
    );
  }
}

class _OTPVerifyViewBody extends StatefulWidget {
  final String? devOTP;
  final bool addAccountMode;

  const _OTPVerifyViewBody({
    this.devOTP,
    this.addAccountMode = false,
  });

  @override
  State<_OTPVerifyViewBody> createState() => _OTPVerifyViewBodyState();
}

class _OTPVerifyViewBodyState extends State<_OTPVerifyViewBody> {
  final _otpController = TextEditingController();
  final _otpStreamController = StreamController<ErrorAnimationType>.broadcast();
  String _currentText = '';
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    // Auto-fill dev OTP in development mode if provided
    if (widget.devOTP != null && widget.devOTP!.length == 6) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _otpController.text = widget.devOTP!;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Dev OTP: ${widget.devOTP}'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpStreamController.close();
    super.dispose();
  }

  Future<void> _handleVerifyOTP() async {
    if (_isSubmitting) {
      if (kDebugMode) {
        debugPrint(
          '⚠️ _handleVerifyOTP ignored: submission already in progress',
        );
      }
      return;
    }

    if (mounted) {
      setState(() {
        _isSubmitting = true;
      });
    } else {
      _isSubmitting = true;
    }

    final controller = context.read<OTPVerifyController>();
    try {
      final success = await controller.verifyOTP(_otpController.text.trim());

      if (!mounted) return;

      if (success) {
        final auth = context.read<AuthStore>();
        final userId = auth.client?.userID ?? auth.userId;
        final hasClient = auth.client != null && userId != null;
        if (!hasClient) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                L10n.of(context)!.verificationFailed,
              ), // TODO: add translation
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          context.go('/phone-input');
          return;
        }

        // Wire auth token into interceptors for downstream requests
        final matrixState = Matrix.maybeOf(context);
        final client = auth.client;
        if (matrixState != null && client != null) {
          matrixState.setUpAuthorization(client);
          if (widget.addAccountMode) {
            await matrixState.registerAndActivateAddedAccount(client);
          }
        }

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(L10n.of(context)!.loginSuccess), // TODO: add translation
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate directly to Chats after successful auth/add-account flow
        await Future.delayed(const Duration(milliseconds: 300));
        if (!mounted) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.go(
              '/rooms',
              extra: SwitchActiveAccountBodyArgs(
                newActiveClient: Matrix.of(context).client,
              ),
            );
          }
        });
      } else {
        // Trigger error animation
        _otpStreamController.add(ErrorAnimationType.shake);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      } else {
        _isSubmitting = false;
      }
    }
  }

  Future<void> _handleResendCode() async {
    final controller = context.read<OTPVerifyController>();
    final success = await controller.resendOTP();

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(L10n.of(context)!.codeSentAgain),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<OTPVerifyController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: widget.addAccountMode,
        leading: widget.addAccountMode
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF1D1D1D)),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

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

              // Title: Enter Verification Code
              Text(
                L10n.of(context)!.enterVerificationCode,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle with phone number
              Text(
                L10n.of(context)!.otpSentMessage(controller.phoneNumber),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // OTP Input using pin_code_fields
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                errorAnimationController: _otpStreamController,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 56,
                  fieldWidth: 48,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: const Color(0xFF2196F3),
                  inactiveColor: const Color(0xFFE0E0E0),
                  selectedColor: const Color(0xFF2196F3),
                  errorBorderColor: Colors.red,
                ),
                cursorColor: const Color(0xFF2196F3),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 2,
                  ),
                ],
                onCompleted: (code) {
                  _currentText = code;
                  // Auto-verify when all 6 digits are entered
                  if (!state.isLoading && !_isSubmitting) {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (mounted) {
                        _handleVerifyOTP();
                      }
                    });
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _currentText = value;
                  });
                  // Clear error when user types
                  if (state.errorMessage != null) {
                    controller.clearError();
                  }
                },
                beforeTextPaste: (text) {
                  // Allow pasting only if it's 6 digits
                  return text?.length == 6 && RegExp(r'^\d+$').hasMatch(text!);
                },
              ),

              const SizedBox(height: 24),

              // Error message
              if (state.errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[600],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(
                            color: Colors.red[800],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: (state.isLoading ||
                          _isSubmitting ||
                          _currentText.length < 6)
                      ? null
                      : _handleVerifyOTP,
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
                  child: (state.isLoading || _isSubmitting)
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
                          L10n.of(context)!.verify,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 32),

              // Resend code section
              Column(
                children: [
                  Text(
                    L10n.of(context)!.otpProblemQuestion,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (state.resendCountdown > 0)
                    Text(
                      '${L10n.of(context)!.resendCode} (${state.resendCountdown}${L10n.of(context)!.seconds})',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9E9E9E),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: _handleResendCode,
                      child: Text(
                        L10n.of(context)!.resendCode,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2196F3),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
