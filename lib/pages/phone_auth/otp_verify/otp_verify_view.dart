import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'dart:async';

import 'package:fluffychat/services/otp_api_service.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:matrix/matrix.dart';

/// Modern OTP verification screen using pin_code_fields package
/// Replaces the old 6-TextField implementation
class OTPVerifyView extends StatefulWidget {
  final String phoneNumber;
  final String? devOTP;

  const OTPVerifyView({
    super.key,
    required this.phoneNumber,
    this.devOTP,
  });

  @override
  State<OTPVerifyView> createState() => _OTPVerifyViewState();
}

class _OTPVerifyViewState extends State<OTPVerifyView> {
  final _otpController = TextEditingController();
  final _otpStreamController = StreamController<ErrorAnimationType>();
  
  bool _isLoading = false;
  String _errorMessage = '';
  int _resendCountdown = 60;
  Timer? _timer;
  String _currentText = '';

  @override
  void initState() {
    super.initState();
    _startResendCountdown();

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
    _timer?.cancel();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() => _resendCountdown = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _verifyOTP() async {
    final code = _otpController.text.trim();
    
    if (code.length != 6) {
      setState(() {
        _errorMessage = L10n.of(context)!.pleaseEnterCompleteCode;
      });
      _otpStreamController.add(ErrorAnimationType.shake);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Step 1: Verify OTP and get JWT token
      final authData = await OTPApiService.verifyOTP(widget.phoneNumber, code);

      if (mounted) {
        await _loginWithAuthData(authData);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTP verification error: $e');
      }
      
      if (mounted) {
        setState(() {
          _errorMessage = _parseErrorMessage(e.toString());
        });
        _otpStreamController.add(ErrorAnimationType.shake);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _parseErrorMessage(String error) {
    if (error.contains('Invalid OTP') || error.contains('INVALID_OTP')) {
      return L10n.of(context)!.invalidOtp;
    } else if (error.contains('timeout') || error.contains('network')) {
      return L10n.of(context)!.connectionError;
    } else if (error.contains('expired')) {
      return L10n.of(context)!.expiredOtp;
    }
    return L10n.of(context)!.verificationFailed;
  }

  Future<void> _resendCode() async {
    if (_resendCountdown > 0) return;

    try {
      await OTPApiService.requestOTP(widget.phoneNumber);
      _startResendCountdown();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(L10n.of(context)!.codeSentAgain),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(L10n.of(context)!.codeSendFailed),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loginWithAuthData(Map<String, dynamic> authData) async {
    try {
      // Extract JWT token
      final jwtToken = authData['access_token'] as String?;
      if (jwtToken == null) {
        throw Exception('JWT token not received');
      }

      // Step 2: Exchange JWT for Matrix access token
      final matrixTokenData = await OTPApiService.getMatrixToken(
        jwtToken,
        widget.phoneNumber,
      );

      final matrixAccessToken = matrixTokenData['access_token'] as String;
      final matrixUserId = matrixTokenData['mxid'] as String? ??
                          matrixTokenData['user_id'] as String?;
      final homeserverUrl = matrixTokenData['homeserver'] as String?;

      if (matrixUserId == null) {
        throw Exception('Matrix user ID not received');
      }

      // Step 3: Initialize Matrix client
      final matrixState = Matrix.of(context);
      final client = matrixState.client;

      await client.checkHomeserver(
        Uri.parse(homeserverUrl ?? 'https://matrix.dedim.com.tr'),
      );

      await client.login(
        LoginType.mLoginToken,
        token: matrixAccessToken,
        initialDeviceDisplayName: 'Dedi Mobile App',
      );

      // Step 4: Save login state
      await _saveLoginState(matrixUserId);

      // Step 5: Navigate to chat list
      if (mounted) {
        _showSuccessMessage();
        await Future.delayed(const Duration(milliseconds: 1500));
        if (mounted) {
          context.go('/rooms');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Matrix integration error: $e');
      }
      if (mounted) {
        setState(() {
          _errorMessage = 'Matrix bağlantı hatası: ${e.toString()}';
        });
      }
    }
  }

  Future<void> _saveLoginState(String matrixUserId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_id', matrixUserId);
    await prefs.setString('phone_number', widget.phoneNumber);
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(L10n.of(context)!.loginSuccess),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1D1D1D)),
          onPressed: () => context.pop(),
        ),
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

              // Title: Onay Kodunu Gir
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
                L10n.of(context)!.otpSentMessage(widget.phoneNumber),
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
                  if (!_isLoading) {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (mounted) {
                        _verifyOTP();
                      }
                    });
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _currentText = value;
                    if (_errorMessage.isNotEmpty) {
                      _errorMessage = '';
                    }
                  });
                },
                beforeTextPaste: (text) {
                  // Allow pasting only if it's 6 digits
                  return text?.length == 6 && RegExp(r'^\d+$').hasMatch(text!);
                },
              ),

              const SizedBox(height: 24),

              // Error message
              if (_errorMessage.isNotEmpty)
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
                      Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
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
                  onPressed: (_isLoading || _currentText.length < 6)
                      ? null
                      : _verifyOTP,
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
                  if (_resendCountdown > 0)
                    Text(
                      '${L10n.of(context)!.resendCode} ($_resendCountdown${L10n.of(context)!.seconds})',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9E9E9E),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: _resendCode,
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

