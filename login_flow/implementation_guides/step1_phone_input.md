# Step 1: Phone Input Implementation

## 📱 Overview

This guide shows how to implement the first step of the authentication flow: phone number collection and OTP request.

## 🎯 Goals

- Create a user-friendly phone input screen
- Validate phone number format
- Send OTP request to backend
- Handle loading states and errors
- Navigate to OTP verification

## 🏗️ Implementation Steps

### 1. Create Phone Input Screen

```dart
// lib/screens/auth/phone_input_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/http_helper.dart';

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _controller = TextEditingController();
  bool _loading = false;
  String _errorMessage = '';

  // Implementation continues...
}
```

### 2. Add Phone Number Validation

```dart
bool _isValidPhoneNumber(String phone) {
  // Remove all non-digit characters
  final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');

  // Check for Turkish phone numbers (10 digits after country code)
  if (digitsOnly.length < 10) return false;

  // Additional validations can be added here
  return true;
}

String _formatPhoneNumber(String input) {
  // Remove all non-digit characters
  final digitsOnly = input.replaceAll(RegExp(r'\D'), '');

  // Add country code (+90 for Turkey)
  return '+90$digitsOnly';
}
```

### 3. Implement OTP Request Logic

```dart
Future<void> _requestOtp() async {
  // Validate input
  if (!_isValidPhoneNumber(_controller.text)) {
    setState(() => _errorMessage = 'Geçerli bir telefon numarası giriniz');
    return;
  }

  setState(() {
    _loading = true;
    _errorMessage = '';
  });

  try {
    final phone = _formatPhoneNumber(_controller.text);
    final response = await HttpHelper.sendOtpRequest(phone);

    if (mounted) {
      // Navigate to OTP verification
      context.push('/auth/otp-verify', extra: {
        'phoneNumber': phone,
        'devOtp': response['dev_otp'], // Only in development
      });
    }
  } catch (e) {
    setState(() => _errorMessage = _parseError(e));
  } finally {
    setState(() => _loading = false);
  }
}

String _parseError(dynamic error) {
  if (error.toString().contains('network')) {
    return 'Bağlantı hatası. İnternet bağlantınızı kontrol edin.';
  }
  return 'Bir hata oluştu. Lütfen tekrar deneyin.';
}
```

### 4. Design the UI

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('Giriş'),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            _buildLogo(),

            const SizedBox(height: 40),

            // Title and Subtitle
            _buildHeader(),

            const SizedBox(height: 40),

            // Phone Input Field
            _buildPhoneInput(),

            const SizedBox(height: 32),

            // Continue Button
            _buildContinueButton(),

            const SizedBox(height: 24),

            // Terms and Privacy
            _buildTermsText(),
          ],
        ),
      ),
    ),
  );
}
```

### 5. Create Reusable Components

```dart
Widget _buildLogo() {
  return Container(
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
  );
}

Widget _buildHeader() {
  return Column(
    children: [
      const Text(
        "Giriş Yap",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        "Telefon numaranızı girerek devam edin",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _buildPhoneInput() {
  return TextField(
    controller: _controller,
    keyboardType: TextInputType.phone,
    enabled: !_loading,
    decoration: InputDecoration(
      labelText: "Telefon Numarası",
      prefixText: "+90 ",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      errorText: _errorMessage.isEmpty ? null : _errorMessage,
    ),
    onSubmitted: (_) => _requestOtp(),
  );
}

Widget _buildContinueButton() {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: _loading ? null : _requestOtp,
      child: _loading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Doğrulama Kodu Al"),
    ),
  );
}
```

## 🔧 Configuration

### Environment Setup

```dart
// lib/config/env_config.dart
class EnvConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.yourapp.com',
  );

  static const bool autoFillDevOtp = bool.fromEnvironment(
    'AUTO_FILL_DEV_OTP',
    defaultValue: false,
  );
}
```

### HTTP Helper Integration

```dart
// lib/services/http_helper.dart
static Future<Map<String, dynamic>> sendOtpRequest(String phone) async {
  final response = await post(
    endpoint: '/otp/request',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    body: json.encode({'phone': phone}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('OTP request failed');
  }
}
```

## 🎨 Styling and Theming

### Custom Input Field Theme

```dart
// lib/theme/input_theme.dart
class InputTheme {
  static InputDecorationTheme get theme => InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
  );
}
```

### Button Theme

```dart
// lib/theme/button_theme.dart
class ButtonTheme {
  static ElevatedButtonThemeData get theme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
```

## 📱 Platform Considerations

### iOS Specific Features

```dart
// lib/utils/platform_utils.dart
class PlatformUtils {
  static bool get isIOS => Theme.of(context).platform == TargetPlatform.iOS;

  static void configureIOSKeyboard() {
    if (isIOS) {
      // Configure iOS-specific keyboard settings
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarStyle: StatusBarStyle.dark,
        ),
      );
    }
  }
}
```

### Android Specific Features

```dart
// Configure Android autofill
Widget _buildPhoneInput() {
  return TextField(
    controller: _controller,
    keyboardType: TextInputType.phone,
    autofillHints: const [AutofillHints.telephoneNumber],
    // ... other properties
  );
}
```

## 🧪 Testing

### Unit Tests

```dart
// test/screens/phone_input_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/screens/auth/phone_input_page.dart';

void main() {
  group('PhoneInputPage', () {
    testWidgets('displays phone input field', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: PhoneInputPage()),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Telefon Numarası'), findsOneWidget);
    });

    testWidgets('validates phone number format', (tester) async {
      // Test implementation
    });
  });
}
```

### Integration Tests

```dart
// integration_test/auth_flow_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Flow', () {
    testWidgets('complete phone input flow', (tester) async {
      // Full integration test
    });
  });
}
```

## 🚨 Error Handling

### Common Error Scenarios

```dart
class PhoneInputErrors {
  static const Map<String, String> messages = {
    'INVALID_FORMAT': 'Geçerli bir telefon numarası giriniz',
    'NETWORK_ERROR': 'Bağlantı hatası. İnternet bağlantınızı kontrol edin.',
    'SERVER_ERROR': 'Sunucu hatası. Lütfen daha sonra tekrar deneyin.',
    'RATE_LIMITED': 'Çok fazla deneme. Lütfen bekleyin.',
  };

  static String getLocalizedMessage(String errorCode) {
    return messages[errorCode] ?? 'Bilinmeyen hata oluştu.';
  }
}
```

## 🔗 Navigation Integration

### Route Configuration

```dart
// lib/router/app_router.dart
final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/auth/phone',
      builder: (context, state) => const PhoneInputPage(),
    ),
    GoRoute(
      path: '/auth/otp-verify',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return OtpVerifyPage(
          phoneNumber: extra['phoneNumber'],
          devOtp: extra['devOtp'],
        );
      },
    ),
  ],
);
```

## ✅ Checklist

- [ ] Phone input field with validation
- [ ] Loading states during API calls
- [ ] Error handling and user feedback
- [ ] Navigation to OTP verification
- [ ] Platform-specific optimizations
- [ ] Accessibility support
- [ ] Unit and integration tests
- [ ] Proper error messages in Turkish
- [ ] Development mode support

## 🔄 Next Steps

Once phone input is complete, proceed to [Step 2: OTP Verification](step2_otp_verification.md) to implement the OTP verification screen.

## 📚 Resources

- [Flutter TextField Documentation](https://docs.flutter.dev/cookbook/forms/text-input)
- [Go Router Navigation](https://pub.dev/packages/go_router)
- [HTTP Package](https://pub.dev/packages/http)
- [Form Validation Best Practices](https://docs.flutter.dev/cookbook/forms/validation)