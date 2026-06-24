// lib/features/bookings/services/booking_service.dart

import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';
import '../models/booking_model.dart';

class BookingService {
  BookingService({required this.dio});

  final Dio dio;

  Future<List<BookingModel>> fetchMySessions() async {
    try {
      final response = await dio.get(ApiEndpoints.myparkingSessions);
      final list = response.data as List<dynamic>;
      return list
          .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _parseError(e, 'Impossible de charger vos réservations');
    }
  }

  /// GET /parking-sessions/:id
  Future<BookingModel> fetchSessionById(String id) async {
    try {
      final response =
          await dio.get('${ApiEndpoints.parkingSessions}/$id');
      return BookingModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e, 'Session introuvable');
    }
  }

  /// PATCH /parking-sessions/:id/end  — mark session EXPIRED
  Future<void> endSession(String sessionId) async {
    try {
      await dio.patch(
        '${ApiEndpoints.parkingSessions}/$sessionId/end',
        data: {},
      );
    } on DioException catch (e) {
      throw _parseError(e, 'Impossible de terminer la session');
    }
  }

  /// PATCH /parking-sessions/:id/cancel
  Future<void> cancelSession(String sessionId) async {
    try {
      await dio.patch(
        '${ApiEndpoints.parkingSessions}/$sessionId/cancel',
      );
    } on DioException catch (e) {
      throw _parseError(e, 'Impossible d\'annuler la session');
    }
  }

  // ── Payments / Flouci ─────────────────────────────────────────────────────

  /// POST /payments/init/flouci  → returns { payLink, paymentId, ... }
  Future<FlouciInitResult> initFlouciPayment(String sessionId) async {
    try {
      final response = await dio.post(
        ApiEndpoints.initFlouciPayment,
        data: {'sessionId': sessionId},
      );
      return FlouciInitResult.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e, 'Impossible d\'initialiser le paiement');
    }
  }

  /// GET /payments/:id  — poll payment status
  Future<PaymentStatusResult> getPaymentStatus(String paymentId) async {
    try {
      final response =
          await dio.get('${ApiEndpoints.payments}/$paymentId');
      return PaymentStatusResult.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e, 'Impossible de vérifier le paiement');
    }
  }

  Exception _parseError(DioException e, String fallback) {
    final data = e.response?.data;
    final message = data is Map && data['message'] != null
        ? data['message'].toString()
        : fallback;
    return Exception(message);
  }
}

// ── Small result models ────────────────────────────────────────────────────

class FlouciInitResult {
  const FlouciInitResult({
    required this.paymentId,
    required this.payLink,
    required this.amount,
  });

  final String paymentId;
  final String payLink;
  final double amount;

  factory FlouciInitResult.fromJson(Map<String, dynamic> json) {
    return FlouciInitResult(
      paymentId: json['paymentId'] as String? ?? '',
      payLink: json['payLink'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
    );
  }
}

class PaymentStatusResult {
  const PaymentStatusResult({
    required this.id,
    required this.status,
  });

  final String id;
  final String status; // PENDING | PAID | FAILED

  bool get isPaid => status == 'PAID';
  bool get isFailed => status == 'FAILED';

  factory PaymentStatusResult.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResult(
      id: json['id'] as String? ?? '',
      status: json['status'] as String? ?? 'PENDING',
    );
  }
}