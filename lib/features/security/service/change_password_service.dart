import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';

class ChangePasswordService {
  ChangePasswordService({required this.dio});

  final Dio dio;

  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await dio.patch(
        ApiEndpoints.changePassword(userId),
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map && data['message'] != null
          ? data['message'].toString()
          : 'Une erreur est survenue. Veuillez réessayer.';

      throw Exception(message);
    }
  }
}