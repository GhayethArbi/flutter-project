import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';

class PaymentService {
  PaymentService({required this.dio});

  final Dio dio;

  Future<String> initFlouciPayment({
    required String sessionId,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.initFlouciPayment,
        data: {'sessionId': sessionId},
      );

      final data = response.data;

      final link =
          data['payLink'] ??
          data['paymentUrl'] ??
          data['link'] ??
          data['result']?['link'];

      if (link == null || link.toString().trim().isEmpty) {
        throw Exception('Lien de paiement Flouci introuvable.');
      }

      return link.toString();
    } on DioException catch (e) {
      throw Exception(_parseDioError(e, 'Impossible d’initialiser le paiement.'));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  String _parseDioError(DioException e, String fallback) {
    final data = e.response?.data;

    if (data is Map && data['message'] != null) {
      final message = data['message'];
      if (message is List) return message.join('\n');
      return message.toString();
    }

    if (data is Map && data['error'] != null) {
      return data['error'].toString();
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Le serveur ne répond pas. Veuillez réessayer.';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'Impossible de se connecter au serveur.';
    }

    return fallback;
  }
}