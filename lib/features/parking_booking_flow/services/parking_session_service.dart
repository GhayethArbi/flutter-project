import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';

class ParkingSessionService {
  ParkingSessionService({required this.dio});

  final Dio dio;

  Future<String> createSession({
    required String parkingId,
    required String vehiclePlate,
    required DateTime startDate,
    required DateTime endDate,
    required double pricePerMonth,
    required double serviceFee,
    required double totalPrice,
    String? tariffId,
    String? vehicleBrand,
    String? vehicleModel,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.parkingSessions,
        data: {
          'parkingId': parkingId,
          'vehiclePlate': vehiclePlate,
          'startTime': startDate.toIso8601String(),
          'endTime': endDate.toIso8601String(),
          'paidDuration': endDate.difference(startDate).inMinutes,

          // 'pricePerMonth': pricePerMonth,
          // 'serviceFee': serviceFee,
          // 'totalPrice': totalPrice,
          // if (tariffId != null) 'tariffId': tariffId,
          if (vehicleBrand != null) 'vehicleBrand': vehicleBrand,
          if (vehicleModel != null) 'vehicleModel': vehicleModel,
        },
      );

      final id = response.data['id'];

      if (id == null || id.toString().trim().isEmpty) {
        throw Exception('Session créée mais identifiant introuvable.');
      }

      return id.toString();
    } on DioException catch (e) {
      throw Exception(_parseDioError(e, 'Impossible de créer la session.'));
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

    if (e.response?.statusCode == 401) {
      return 'Session expirée. Veuillez vous reconnecter.';
    }

    if (e.response?.statusCode == 404) {
      return 'Parking introuvable.';
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