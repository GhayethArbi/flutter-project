import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tunipark/core/constants/app_constants.dart';

enum ForgotPasswordIdentifierType { email, phone }

class ForgotPasswordService {
  ForgotPasswordIdentifierType detectIdentifierType(String value) {
    final input = value.trim();

    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');

    if (emailRegex.hasMatch(input)) {
      return ForgotPasswordIdentifierType.email;
    }

    return ForgotPasswordIdentifierType.phone;
  }

  Future<void> requestResetOtp({required String identifier}) async {
    final input = identifier.trim();
    final type = detectIdentifierType(input);

    final uri = type == ForgotPasswordIdentifierType.email
        ? Uri.parse(
            '${AppConstants.baseUrlNest}/auth/password/reset/email/request',
          )
        : Uri.parse(
            '${AppConstants.baseUrlNest}/auth/password/reset/phone/request',
          );

    final body = type == ForgotPasswordIdentifierType.email
        ? {'email': input}
        : {'phoneNumber': input};

    await _post(uri: uri, body: body);
  }

  Future<String> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    final input = identifier.trim();
    final type = detectIdentifierType(input);

    final uri = type == ForgotPasswordIdentifierType.email
        ? Uri.parse(
            '${AppConstants.baseUrlNest}/auth/password/reset/email/verify',
          )
        : Uri.parse(
            '${AppConstants.baseUrlNest}/auth/password/reset/phone/verify',
          );

    final body = type == ForgotPasswordIdentifierType.email
        ? {'email': input, 'otp': otp.trim()}
        : {'phoneNumber': input, 'otp': otp.trim()};

    final decoded = await _post(uri: uri, body: body);

    return decoded['resetToken'] ?? decoded['token'];
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final uri = Uri.parse('${AppConstants.baseUrlNest}/auth/password/reset');

    await _post(
      uri: uri,
      body: {'token': token.trim(), 'newPassword': newPassword},
    );
  }

 Future<Map<String, dynamic>> _post({
  required Uri uri,
  required Map<String, dynamic> body,
}) async {
  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );

    final decoded = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : <String, dynamic>{};

    if (response.statusCode == 200 || response.statusCode == 201) {
      return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
    }

    String errorMessage = 'Request failed';

    if (decoded is Map<String, dynamic>) {
      final message = decoded['message'];

      if (message is String) {
        errorMessage = message;
      } else if (message is List && message.isNotEmpty) {
        errorMessage = message.join(', ');
      }
    }

    throw Exception(errorMessage);
  } catch (e) {
    throw Exception(e.toString().replaceFirst('Exception: ', ''));
  }
}}
