import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';

class UserService {
  const UserService({required this.dio});

  final Dio dio;

  Future<Map<String, dynamic>> updateUser({
    required String userId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
  }) async {
    try {
      final response = await dio.patch(
        ApiEndpoints.userById(userId),
        data: {
          if (firstName != null) 'firstName': firstName,
          if (lastName != null) 'lastName': lastName,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
          if (email != null) 'email': email,
        },
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
      if (message is List) return (message as List).join(', ');
    }

    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout =>
        'Network timeout. Please check your connection.',
      DioExceptionType.connectionError =>
        'Network error. Please check your connection.',
      _ => 'Update failed (${e.response?.statusCode ?? "unknown"})',
    };
  }
}