# Step 2: OTP Verification Implementation

## 📱 Overview

This guide covers the implementation of the OTP verification screen, which handles 6-digit code input, verification with backend, and Matrix client initialization.

## 🎯 Goals

- Create intuitive 6-digit OTP input interface
- Handle auto-focus, paste operations, and backspace navigation
- Implement countdown timer for resend functionality
- Verify OTP with backend and exchange for Matrix credentials
- Initialize Matrix client and navigate to chat interface

## 🏗️ Implementation Steps

### 1. Create OTP Verification Screen Structure

```dart
// lib/screens/auth/otp_verify_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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
  // Controllers and focus nodes for 6 OTP digits
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
    _autoFillDevOtp(); // For development mode
  }

  // Implementation continues...
}
```

### 2. Implement Custom OTP Input Fields

```dart
// lib/widgets/otp_digit_field.dart
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
          color: _getBorderColor(context),
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
        onChanged: onChanged,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }

  Color _getBorderColor(BuildContext context) {
    if (isActive) return Theme.of(context).primaryColor;
    if (controller.text.isNotEmpty) return Colors.green;
    return Colors.grey[300]!;
  }
}
```

### 3. Handle Input Navigation and Paste Operations

```dart
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

  // Handle paste operation (multiple digits)
  if (value.length > 1) {
    _handlePastedOtp(value, index);
    return;
  }

  if (value.isNotEmpty) {
    // Move to next field
    if (index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
      // Auto-verify when all fields are filled
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && _controllers.every((c) => c.text.isNotEmpty)) {
          _verify();
        }
      });
    }
  }
  setState(() {});
}

void _handlePastedOtp(String pastedValue, int startIndex) {
  // Clean pasted value (digits only)
  String cleanValue = pastedValue.replaceAll(RegExp(r'[^0-9]'), '');

  // Fill OTP fields with pasted digits
  for (int i = 0; i < cleanValue.length && (startIndex + i) < 6; i++) {
    _controllers[startIndex + i].text = cleanValue[i];
  }

  // Move focus to next empty field or auto-verify
  int nextEmptyIndex = _controllers.indexWhere((c) => c.text.isEmpty);
  if (nextEmptyIndex != -1) {
    _focusNodes[nextEmptyIndex].requestFocus();
  } else {
    _focusNodes.last.unfocus();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && _controllers.every((c) => c.text.isNotEmpty)) {
        _verify();
      }
    });
  }
  setState(() {});
}
```

### 4. Implement Countdown Timer for Resend

```dart
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
```

### 5. Implement OTP Verification and Matrix Integration

```dart
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

Future<void> _loginWithAuthData(Map<String, dynamic> authData) async {
  try {
    // Extract credentials
    final userId = authData['mxid'] as String?;
    final jwtToken = authData['access_token'] as String?;

    if (userId == null || jwtToken == null) {
      throw Exception('Missing credentials in auth response');
    }

    // Step 2: Exchange JWT for Matrix credentials
    final matrixTokenData = await HttpHelper.getMatrixToken(
      jwtToken: jwtToken,
      phoneNumber: widget.phoneNumber,
    );

    final matrixAccessToken = matrixTokenData['access_token'] as String;
    final matrixUserId = matrixTokenData['mxid'] as String?;
    final deviceId = matrixTokenData['device_id'] as String?;

    // Step 3: Initialize Matrix client
    await MatrixClientManager.initializeClient(
      userId: matrixUserId!,
      accessToken: matrixAccessToken,
      deviceId: deviceId ?? 'DEDI_MOBILE_APP',
      homeserverUrl: _extractHomeserverUrl(matrixUserId),
    );

    // Step 4: Save login state and navigate
    await _saveLoginState(matrixUserId);

    if (mounted) {
      _showSuccessMessage();
      context.go('/rooms');
    }
  } catch (e) {
    if (mounted) {
      _showErrorWithRetry(e.toString(), authData);
    }
    rethrow;
  }
}
```

### 6. Build the UI Layout

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('Doğrulama'),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildHeader(),
                const SizedBox(height: 40),
                _buildOtpInput(),
                const SizedBox(height: 40),
                _buildVerifyButton(),
                const SizedBox(height: 24),
                _buildResendSection(),
                if (_errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildErrorMessage(),
                ],
                const Spacer(),
              ],
            ),
          ),
        ),
        if (_loading) _buildLoadingOverlay(),
      ],
    ),
  );
}
```

### 7. Create UI Components

```dart
Widget _buildHeader() {
  return Column(
    children: [
      const Text(
        'Onay Kodunu Gir',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        '${widget.phoneNumber} numarasına bir onay kodu gönderdik.\nKodu aşağıdaki alana girin.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
          height: 1.4,
        ),
      ),
    ],
  );
}

Widget _buildOtpInput() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(6, (index) {
      return OtpDigitField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        onChanged: (value) => _onCodeChanged(index, value),
        isActive: _focusNodes[index].hasFocus,
      );
    }),
  );
}

Widget _buildVerifyButton() {
  final isEnabled = _controllers.every((c) => c.text.isNotEmpty) && !_loading;

  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: isEnabled ? _verify : null,
      child: _loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: Colors.white),
            )
          : const Text('Gönder'),
    ),
  );
}

Widget _buildResendSection() {
  return GestureDetector(
    onTap: _resendCountdown > 0 ? null : _resendCode,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Kodu alırken sorun mu yaşıyorsunuz?\n',
            style: TextStyle(color: Colors.grey[600]),
          ),
          TextSpan(
            text: _resendCountdown > 0
                ? 'Yeniden gönder (${_resendCountdown}s)'
                : 'Yeniden gönder',
            style: TextStyle(
              color: _resendCountdown > 0
                  ? Colors.grey[600]
                  : Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
```

## 🔧 Error Handling

### User-Friendly Error Messages

```dart
String _parseErrorMessage(String error) {
  if (error.contains('Invalid OTP')) {
    return 'Doğrulama kodu hatalı. Lütfen kontrol edin.';
  } else if (error.contains('expired')) {
    return 'Doğrulama kodu süresi dolmuş. Yeni kod isteyin.';
  } else if (error.contains('timeout') || error.contains('network')) {
    return 'Bağlantı hatası. İnternet bağlantınızı kontrol edin.';
  }
  return 'Bağlantı hatası. Lütfen tekrar deneyin.';
}

void _showErrorWithRetry(String error, Map<String, dynamic> authData) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(_parseErrorMessage(error)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Tekrar Dene',
        textColor: Colors.white,
        onPressed: () => _loginWithAuthData(authData),
      ),
    ),
  );
}
```

## 🎨 Advanced UI Features

### Loading Overlay

```dart
Widget _buildLoadingOverlay() {
  return Container(
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
  );
}
```

### Error Message Component

```dart
Widget _buildErrorMessage() {
  return Container(
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
  );
}
```

## 🧪 Development Features

### Auto-Fill Development OTP

```dart
void _autoFillDevOtp() {
  if (EnvConfig.autoFillDevOtp &&
      widget.devOtp != null &&
      widget.devOtp!.length == 6) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < 6; i++) {
        _controllers[i].text = widget.devOtp![i];
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dev OTP: ${widget.devOtp}'),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }
}
```

## 📱 Accessibility Support

### Screen Reader Support

```dart
Widget _buildOtpInput() {
  return Semantics(
    label: 'Doğrulama kodu giriş alanları',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Semantics(
          label: '${index + 1}. rakam',
          child: OtpDigitField(
            // ... properties
          ),
        );
      }),
    ),
  );
}
```

## 🧪 Testing

### Widget Tests

```dart
// test/widgets/otp_verify_page_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OtpVerifyPage', () {
    testWidgets('displays 6 OTP input fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: OtpVerifyPage(phoneNumber: '+905551234567'),
        ),
      );

      expect(find.byType(OtpDigitField), findsNWidgets(6));
    });

    testWidgets('auto-focuses next field on input', (tester) async {
      // Test auto-focus behavior
    });

    testWidgets('handles paste operation correctly', (tester) async {
      // Test paste handling
    });
  });
}
```

### Integration Tests

```dart
// integration_test/otp_verification_test.dart
void main() {
  group('OTP Verification Flow', () {
    testWidgets('complete verification flow', (tester) async {
      // Full flow integration test
    });
  });
}
```

## ✅ Checklist

- [ ] 6-digit OTP input with auto-focus
- [ ] Paste operation support
- [ ] Backspace navigation between fields
- [ ] Countdown timer for resend
- [ ] OTP verification with backend
- [ ] Matrix client initialization
- [ ] Error handling and user feedback
- [ ] Loading states and overlays
- [ ] Development mode auto-fill
- [ ] Accessibility support
- [ ] Unit and integration tests

## 🔄 Next Steps

After completing OTP verification, proceed to [Step 3: Matrix Integration](step3_matrix_integration.md) for detailed Matrix client setup and management.

## 📚 Resources

- [Flutter Form Validation](https://docs.flutter.dev/cookbook/forms/validation)
- [Matrix Dart SDK](https://pub.dev/packages/matrix)
- [Timer Class Documentation](https://api.dart.dev/stable/dart-async/Timer-class.html)
- [Accessibility in Flutter](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)