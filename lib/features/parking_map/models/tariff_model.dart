class TariffModel {
  final String id;
  final double? pricePerUnit;
  final double pricePerDay;
  final double pricePerMonth;
  final int? minDuration;
  final int? maxDuration;
  final String parkingId;

  const TariffModel({
    required this.id,
    required this.pricePerUnit,
    required this.pricePerDay,
    required this.pricePerMonth,
    required this.minDuration,
    required this.maxDuration,
    required this.parkingId,
  });

  factory TariffModel.fromJson(Map<String, dynamic> json) {
    return TariffModel(
      id: json['id']?.toString() ?? '',
      pricePerUnit: json['pricePerUnit'] != null
          ? _toDouble(json['pricePerUnit'])
          : null,
      pricePerDay: _toDouble(json['pricePerDay']),
      pricePerMonth: _toDouble(json['pricePerMonth']),
      minDuration: json['minDuration'] != null
          ? int.tryParse(json['minDuration'].toString())
          : null,
      maxDuration: json['maxDuration'] != null
          ? int.tryParse(json['maxDuration'].toString())
          : null,
      parkingId: json['parkingId']?.toString() ?? '',
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}
