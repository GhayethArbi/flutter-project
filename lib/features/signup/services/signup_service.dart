import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';

class SignUpService {
  const SignUpService({required this.dio});

  final Dio dio;

  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      await dio.post(
        ApiEndpoints.signup,
        data: {
          'firstName': firstName.trim(),
          'lastName': lastName.trim(),
          'phoneNumber': phone.trim(),
          'email': email.trim(),
          'password': password,
        },
      );
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  String _extractMessage(DioException e) {
    if (e.response?.data is Map) {
      final message = e.response!.data['message'];
      if (message is String) return message;
      if (message is List) return (message as List).join(', ');
    }

    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout =>
        'Network timeout. Please check your connection.',
      DioExceptionType.connectionError =>
        'Network error. Please check your connection.',
      _ => "Erreur lors de l'inscription (${e.response?.statusCode ?? 'unknown'})",
    };
  }
}