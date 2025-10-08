/// OTP Verification Screen Implementation
/// Based on: lib/feature/auth/otp/otp_verify.dart
///
/// This is a complete OTP verification screen that:
/// - Provides 6-digit OTP input with auto-focus
/// - Handles paste operations and backspace navigation
/// - Manages countdown timer for resend functionality
/// - Integrates with Matrix authentication flow
/// - Provides comprehensive error handling

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import 'http_helper.dart';
import 'matrix_client.dart'; // Your Matrix client integration
import 'env_config.dart';

class OtpVerifyPage extends StatefulWidget {
  final String phoneNumber;
  final String? devOtp;

  const OtpVerifyPage({
    super.key,
    required this.phoneNumber,
    this.devOtp,
  });

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  // OTP input controllers and focus nodes
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());

  // State management
  bool _loading = false;
  String _errorMessage = '';
  int _resendCountdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();

    // Auto-fill dev OTP in development mode
    if (EnvConfig.autoFillDevOtp && widget.devOtp != null && widget.devOtp!.length == 6) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        for (int i = 0; i < 6; i++) {
          _controllers[i].text = widget.devOtp![i];
        }
        // Show dev info
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Dev OTP otomatik dolduruldu: ${widget.devOtp}'),
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
  Future<void> _verify() async {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6) {
      setState(() => _errorMessage = 'Lütfen 6 haneli kodu eksiksiz giriniz');
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      // Step 1: Verify OTP and get JWT token
      final authData = await HttpHelper.verifyOtp(widget.phoneNumber, code);

      if (mounted) {
        await _loginWithAuthData(authData);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = _parseErrorMessage(e.toString()));
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  /// Parse error message to user-friendly text
  String _parseErrorMessage(String error) {
    if (error.contains('Invalid OTP')) {
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
      await HttpHelper.sendOtpRequest(widget.phoneNumber);
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
      print('[OtpVerify] Auth data received: $authData');

      // Extract login credentials from auth data
      final userId = authData['mxid'] as String?;
      final jwtToken = authData['access_token'] as String? ?? authData['token'] as String?;

      if (userId == null || jwtToken == null) {
        throw Exception('Missing user ID or JWT token in auth response');
      }

      print('[OtpVerify] ✅ JWT Token received');
      print('[OtpVerify] ✅ Matrix User ID: $userId');

      // Step 2: Get Matrix access token from backend
      final matrixTokenData = await HttpHelper.getMatrixToken(
        jwtToken: jwtToken,
        phoneNumber: widget.phoneNumber,
      );

      final matrixAccessToken = matrixTokenData['access_token'] as String;
      final matrixUserId = matrixTokenData['mxid'] as String? ?? matrixTokenData['user_id'] as String?;
      final deviceId = matrixTokenData['device_id'] as String?;

      if (matrixUserId == null) {
        throw Exception('Missing user_id/mxid in backend response');
      }

      print('[OtpVerify] ✅ Matrix access token received');
      print('[OtpVerify] ✅ Matrix User ID: $matrixUserId');
      print('[OtpVerify] ✅ Device ID: $deviceId');

      // Step 3: Initialize Matrix client
      await MatrixClientManager.initializeClient(
        userId: matrixUserId,
        accessToken: matrixAccessToken,
        deviceId: deviceId ?? 'DEDI_MOBILE_APP',
        homeserverUrl: _extractHomeserverUrl(matrixUserId),
      );

      // Step 4: Save login state
      await _saveLoginState(matrixUserId);

      // Step 5: Navigate to chat list
      if (mounted) {
        _showSuccessMessage(matrixUserId);
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          context.go('/rooms');
        }
      }
    } catch (e) {
      print('[OtpVerify] Matrix integration error: $e');
      if (mounted) {
        _showErrorWithRetry(e.toString(), authData);
      }
      rethrow;
    }
  }

  /// Extract homeserver URL from Matrix user ID
  String _extractHomeserverUrl(String userId) {
    final userIdParts = userId.split(':');
    if (userIdParts.length > 1) {
      return 'https://${userIdParts.last}';
    }
    return 'https://dedi.useitsoon.com'; // Default homeserver
  }

  /// Save login state to persistent storage
  Future<void> _saveLoginState(String matrixUserId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_id', matrixUserId);
    print('[SharedPrefs] ✅ Login state saved');
  }

  /// Show success message to user
  void _showSuccessMessage(String userId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ Matrix sunucusuna başarıyla bağlanıldı! $userId'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show error message with retry option
  void _showErrorWithRetry(String error, Map<String, dynamic> authData) {
    final userMessage = _parseErrorMessage(error);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(userMessage),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Tekrar Dene',
          textColor: Colors.white,
          onPressed: () async {
            try {
              await _loginWithAuthData(authData);
            } catch (e) {
              print('[OtpVerify] Retry failed: $e');
            }
          },
        ),
      ),
    );
  }

  /// Handle OTP input changes with auto-focus and paste support
  void _onCodeChanged(int index, String value) {
    // Handle special backspace signal from empty field
    if (value == 'BACKSPACE_EMPTY') {
      if (index > 0 && index - 1 < _controllers.length && index - 1 < _focusNodes.length) {
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
      if (index < 5 && index + 1 < _focusNodes.length) {
        _focusNodes[index + 1].requestFocus();
      } else if (index < _focusNodes.length) {
        _focusNodes[index].unfocus();
        // Auto verify when all fields are filled
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && _controllers.every((c) => c.text.isNotEmpty)) {
            _verify();
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
    if (nextEmptyIndex != -1 && nextEmptyIndex < 6 && nextEmptyIndex < _focusNodes.length) {
      _focusNodes[nextEmptyIndex].requestFocus();
    } else if (_focusNodes.isNotEmpty) {
      _focusNodes.last.unfocus();
      // Auto verify when all fields are filled
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && _controllers.every((c) => c.text.isNotEmpty)) {
          _verify();
        }
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Doğrulama'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Title
                  const Text(
                    'Onay Kodunu Gir',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E121B),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    '${widget.phoneNumber} numarasına bir onay kodu gönderdik.\nKodu aşağıdaki alana girin.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // OTP input fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return OtpDigitField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        onChanged: (value) => _onCodeChanged(index, value),
                        isActive: _focusNodes[index].hasFocus,
                      );
                    }),
                  ),

                  const SizedBox(height: 40),

                  // Verify button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _controllers.every((c) => c.text.isNotEmpty) && !_loading ? _verify : null,
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
                              'Gönder',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                            text: 'Kodu alırken sorun mu yaşıyorsunuz?\n',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                          ),
                          TextSpan(
                            text: _resendCountdown > 0
                                ? 'Yeniden gönder (${_resendCountdown}s)'
                                : 'Yeniden gönder',
                            style: TextStyle(
                              fontSize: 14,
                              color: _resendCountdown > 0
                                  ? Colors.grey[600]
                                  : Theme.of(context).primaryColor,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Error message
                  if (_errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 16),
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
                  ],

                  const Spacer(),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_loading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'Kod doğrulanıyor...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
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

/// Custom OTP digit input field widget
class OtpDigitField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final bool isActive;

  const OtpDigitField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive
              ? Theme.of(context).primaryColor
              : controller.text.isNotEmpty
                  ? Colors.green
                  : Colors.grey[300]!,
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.isEmpty && controller.text.isEmpty) {
            // Handle backspace on empty field
            onChanged('BACKSPACE_EMPTY');
          } else {
            onChanged(value);
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}