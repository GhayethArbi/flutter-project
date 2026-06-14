import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';

class LoginService {
  const LoginService({required this.dio});

  final Dio dio;

  Future<Map<String, dynamic>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await dio.post(ApiEndpoints.login,
        data: {'identifier': identifier, 'password': password},
      );
      return response.data as Map<String, dynamic>; 
    } on DioException catch (e) {
      throw Exception(_extractMessage(e));
    }
  }

  String _extractMessage(DioException e) {
    if (e.response?.data is Map) {
      final message = e.response!.data['message'];
      if (message is String) return message;
      if (message is List) return message.join(', ');
    }

    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout =>
        'Network timeout. Please check your connection.',
      DioExceptionType.connectionError =>
        'Network error. Please check your connection.',
      _ => 'Login failed (${e.response?.statusCode ?? "unknown"})',
    };
  }
}