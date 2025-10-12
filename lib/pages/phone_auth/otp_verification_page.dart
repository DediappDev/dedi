import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluffychat/services/otp_api_service.dart';
import 'package:fluffychat/widgets/matrix.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'dart:async';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String? devOTP;

  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
    this.devOTP,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  // OTP input controllers and focus nodes
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());

  // State management
  bool _isLoading = false;
  String _errorMessage = '';
  int _resendCountdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();

    // Auto-fill dev OTP in development mode if provided
    if (widget.devOTP != null && widget.devOTP!.length == 6) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (int i = 0; i < 6; i++) {
          _controllers[i].text = widget.devOTP![i];
        }
        // Show dev info
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Dev OTP: ${widget.devOTP}'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  /// Start countdown timer for resend functionality
  void _startResendCountdown() {
    setState(() => _resendCountdown = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  /// Verify OTP code with backend and initialize Matrix client
  Future<void> _verifyOTP() async {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6) {
      setState(() => _errorMessage = 'Lütfen 6 haneli kodu eksiksiz giriniz');
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
      if (mounted) {
        setState(() => _errorMessage = _parseErrorMessage(e.toString()));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Parse error message to user-friendly text
  String _parseErrorMessage(String error) {
    if (error.contains('Invalid OTP') || error.contains('INVALID_OTP')) {
      return 'Doğrulama kodu hatalı. Lütfen kontrol edin.';
    } else if (error.contains('timeout') || error.contains('network')) {
      return 'Bağlantı hatası. İnternet bağlantınızı kontrol edin.';
    } else if (error.contains('expired')) {
      return 'Doğrulama kodu süresi dolmuş. Yeni kod isteyin.';
    }
    return 'Bağlantı hatası. Lütfen tekrar deneyin.';
  }

  /// Resend OTP code
  Future<void> _resendCode() async {
    if (_resendCountdown > 0) return;

    try {
      await OTPApiService.requestOTP(widget.phoneNumber);
      _startResendCountdown();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Doğrulama kodu tekrar gönderildi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kod gönderilemedi. Lütfen tekrar deneyin.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Complete authentication flow with Matrix integration
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
      final deviceId = matrixTokenData['device_id'] as String?;
      final homeserverUrl = matrixTokenData['homeserver'] as String?;

      if (matrixUserId == null) {
        throw Exception('Matrix user ID not received');
      }

      // Step 3: Initialize Matrix client
      final matrixState = Matrix.of(context);
      final client = matrixState.client;

      await client.checkHomeserver(Uri.parse(homeserverUrl ?? 'https://matrix.dedim.com.tr'));

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
      print('Matrix integration error: $e');
      if (mounted) {
        setState(() => _errorMessage = 'Matrix bağlantı hatası: ${e.toString()}');
      }
    }
  }

  /// Save login state to persistent storage
  Future<void> _saveLoginState(String matrixUserId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_id', matrixUserId);
    await prefs.setString('phone_number', widget.phoneNumber);
  }

  /// Show success message to user
  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Başarıyla giriş yapıldı!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Handle OTP input changes with auto-focus and paste support
  void _onCodeChanged(int index, String value) {
    // Handle special backspace signal from empty field
    if (value == 'BACKSPACE_EMPTY') {
      if (index > 0) {
        _controllers[index - 1].clear();
        _focusNodes[index - 1].requestFocus();
      }
      setState(() {});
      return;
    }

    // Handle paste operation (when multiple digits are entered)
    if (value.length > 1) {
      _handlePastedOtp(value, index);
      return;
    }

    if (value.isNotEmpty) {
      // Character entered - move to next field
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        // Auto verify when all fields are filled
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && _controllers.every((c) => c.text.isNotEmpty)) {
            _verifyOTP();
          }
        });
      }
    }
    setState(() {});
  }

  /// Handle pasted OTP code
  void _handlePastedOtp(String pastedValue, int startIndex) {
    // Clean the pasted value (only keep digits)
    String cleanValue = pastedValue.replaceAll(RegExp(r'[^0-9]'), '');

    // Fill the OTP fields with the pasted digits
    for (int i = 0; i < cleanValue.length && (startIndex + i) < 6; i++) {
      _controllers[startIndex + i].text = cleanValue[i];
    }

    // Move focus to the next empty field or unfocus if all filled
    int nextEmptyIndex = _controllers.indexWhere((controller) => controller.text.isEmpty);
    if (nextEmptyIndex != -1 && nextEmptyIndex < 6) {
      _focusNodes[nextEmptyIndex].requestFocus();
    } else {
      _focusNodes.last.unfocus();
      // Auto verify when all fields are filled
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && _controllers.every((c) => c.text.isNotEmpty)) {
          _verifyOTP();
        }
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final allFieldsFilled = _controllers.every((c) => c.text.isNotEmpty);

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
              Text(
                L10n.of(context)!.otpVerificationTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D1D1D),
                ),
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                L10n.of(context)!.otpVerificationDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 48),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty && _controllers[index].text.isEmpty) {
                          // Handle backspace on empty field
                          _onCodeChanged(index, 'BACKSPACE_EMPTY');
                        } else {
                          _onCodeChanged(index, value);
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              // Error message
              if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
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
                            fontSize: 14,
                            color: Colors.red[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Resend section
              GestureDetector(
                onTap: _resendCountdown > 0 ? null : _resendCode,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Kod gelmediyse ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextSpan(
                        text: _resendCountdown > 0
                            ? 'tekrar gönder (${_resendCountdown}s)'
                            : 'tekrar gönder',
                        style: TextStyle(
                          fontSize: 14,
                          color: _resendCountdown > 0
                              ? Colors.grey[600]
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: allFieldsFilled && !_isLoading ? _verifyOTP : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: allFieldsFilled && !_isLoading
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                    foregroundColor: allFieldsFilled && !_isLoading
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
                          'Doğrula',
                          style: TextStyle(
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

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}