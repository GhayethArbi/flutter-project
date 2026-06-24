import 'package:tunipark/core/constants/app_strings.dart';
// lib/features/bookings/models/booking_model.dart

enum BookingStatus { active, expired, cancelled }

class BookingParking {
  const BookingParking({
    required this.id,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.pictures = const [],
  });

  final String id;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> pictures;

  factory BookingParking.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>?;
    return BookingParking(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Parking',
      address: location?['address'] as String? ?? '',
      latitude: (location?['lat'] as num?)?.toDouble() ?? 0,
      longitude: (location?['lng'] as num?)?.toDouble() ?? 0,
      pictures: List<String>.from(json['pictures'] ?? []),
    );
  }
}

class BookingModel {
  const BookingModel({
    required this.sessionId,
    required this.parking,
    required this.vehiclePlate,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.status,
    required this.startedAt,
    this.endedAt,
    this.pricePerDay,
    this.pricePerMonth,
    this.paymentId,
    this.paymentAmount,
  });

  final String sessionId;
  final BookingParking parking;
  final String vehiclePlate;
  final String vehicleBrand;
  final String vehicleModel;
  final BookingStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
  final double? pricePerDay;
  final double? pricePerMonth;
  final String? paymentId;
  final double? paymentAmount;

  bool get isActive => status == BookingStatus.active;

  /// Days elapsed since session started
  int get daysElapsed => DateTime.now().difference(startedAt).inDays;

  /// If monthly: days remaining until endedAt; else null
  int? get daysRemaining {
    if (endedAt == null) return null;
    final remaining = endedAt!.difference(DateTime.now()).inDays;
    return remaining < 0 ? 0 : remaining;
  }

  /// Progress 0.0 → 1.0 for the ring (based on endedAt vs startedAt)
  double get sessionProgress {
    if (endedAt == null) return 0.5; // unknown duration
    final total = endedAt!.difference(startedAt).inSeconds;
    if (total <= 0) return 1.0;
    final elapsed = DateTime.now().difference(startedAt).inSeconds;
    final progress = elapsed / total;
    return progress.clamp(0.0, 1.0);
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final parkingJson = json['parking'] as Map<String, dynamic>?;
    final tariff = json['tariff'] as Map<String, dynamic>?;
    final payment = json['payment'] as Map<String, dynamic>?;

    return BookingModel(
      sessionId: json['id'] as String,
      parking: parkingJson != null
          ? BookingParking.fromJson(parkingJson)
          : BookingParking(id: '', title: AppStrings.parking, address: '', latitude: 0, longitude: 0),
      vehiclePlate: json['vehiclePlate'] as String? ?? '',
      vehicleBrand: json['vehicleBrand'] as String? ?? '',
      vehicleModel: json['vehicleModel'] as String? ?? '',
      status: _parseStatus(json['status'] as String?),
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'] as String)
          : DateTime.now(),
      endedAt: json['endedAt'] != null
          ? DateTime.parse(json['endedAt'] as String)
          : null,
      pricePerDay:
          (tariff?['pricePerDay'] as num?)?.toDouble(),
      pricePerMonth:
          (tariff?['pricePerMonth'] as num?)?.toDouble(),
      paymentId: payment?['id'] as String?,
      paymentAmount: (payment?['amount'] as num?)?.toDouble(),
    );
  }

  static BookingStatus _parseStatus(String? raw) {
    switch (raw) {
      case 'ACTIVE':
        return BookingStatus.active;
      case 'EXPIRED':
        return BookingStatus.expired;
      case 'CANCELLED':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.expired;
    }
  }
}