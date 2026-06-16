import 'package:tunipark/core/constants/app_constants.dart';
import 'package:tunipark/features/parking_map/models/tariff_model.dart';

class ParkingAiInfo {
  final int views;
  final int starts;
  final int extensions;
  final int? rank;
  final double distanceKm;
  final double conversionRate;
  final double extensionRate;
  final double availabilityScore;
  final double behaviorScore;
  final double price;
  final double score;
  final String recommendation;
  final String source;

  const ParkingAiInfo({
    required this.views,
    required this.starts,
    required this.extensions,
    this.rank,
    required this.distanceKm,
    required this.conversionRate,
    required this.extensionRate,
    required this.availabilityScore,
    required this.behaviorScore,
    required this.price,
    required this.score,
    required this.recommendation,
    required this.source,
  });

  factory ParkingAiInfo.fromJson(Map<String, dynamic> json) {
    return ParkingAiInfo(
      views: int.tryParse(json['views']?.toString() ?? '') ?? 0,
      starts: int.tryParse(json['starts']?.toString() ?? '') ?? 0,
      extensions: int.tryParse(json['extensions']?.toString() ?? '') ?? 0,
      rank: int.tryParse(json['rank']?.toString() ?? ''),
      distanceKm: _toDouble(json['distanceKm']),
      conversionRate: _toDouble(json['conversionRate']),
      extensionRate: _toDouble(json['extensionRate']),
      availabilityScore: _toDouble(json['availabilityScore']),
      behaviorScore: _toDouble(json['behaviorScore']),
      price: _toDouble(json['price']),
      score: _toDouble(json['score']),
      recommendation: json['recommendation']?.toString() ?? '',
      source: json['source']?.toString() ?? '',
    );
  }

  int get matchPercent => score.clamp(0, 100).round();

  bool get isRecommended {
    return recommendation == 'HIGHLY_RECOMMENDED' ||
        recommendation == 'RECOMMENDED' ||
        score >= 60;
  }

  String get label {
    if (score >= 75) return 'Recommended';
    if (score >= 55) return 'Good match';
    return 'Possible option';
  }

  String get distanceLabel {
    if (distanceKm <= 1) return 'Close to your destination';
    if (distanceKm <= 3) return 'Near your destination';
    return 'Available option';
  }

  String get availabilityLabel {
    if (availabilityScore >= 0.7) return 'Good availability';
    if (availabilityScore >= 0.35) return 'Limited availability';
    return 'Few places left';
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}

class ParkingPlace {
  final String id;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final double price;
  final double rating;
  final int spots;
  final String imageUrl;
  final List<String> characteristics;
  final List<String> pictures;
  final TariffModel? tariff;
  final List<String> vehicleTypes;
  final ParkingAiInfo? ai;

  const ParkingPlace({
    required this.id,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.rating,
    required this.spots,
    required this.imageUrl,
    required this.characteristics,
    required this.pictures,
    required this.vehicleTypes,
    this.tariff,
    this.ai,
  });

  factory ParkingPlace.fromJson(Map json) {
    final location = json['location'] as Map? ?? {};
    final pictures = List.from(json['pictures'] ?? []);
    final firstPicture = pictures.isNotEmpty ? pictures.first : '';

    return ParkingPlace(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      address: location['address']?.toString() ?? '',
      latitude: _toDouble(location['lat']),
      longitude: _toDouble(location['lng']),
      price: _toDouble(json['pricePerDay']),
      rating: _toDouble(json['rating']),
      spots: int.tryParse(json['availablePlaces']?.toString() ?? '') ?? 0,
      imageUrl: _buildImageUrl(firstPicture),
      pictures: pictures
          .map((picture) => _buildImageUrl(picture.toString()))
          .toList(),
      characteristics: List<String>.from(json['characteristics'] ?? []),
      tariff: null,
      vehicleTypes: List<String>.from(json['vehicleTypes'] ?? []),
      ai: json['ai'] is Map
          ? ParkingAiInfo.fromJson(Map<String, dynamic>.from(json['ai']))
          : null,
    );
  }

  ParkingPlace copyWith({
    double? price,
    int? spots,
    double? rating,
    TariffModel? tariff,
    List<String>? characteristics,
    List<String>? pictures,
    List<String>? vehicleTypes,
    ParkingAiInfo? ai,
  }) {
    return ParkingPlace(
      id: id,
      title: title,
      address: address,
      latitude: latitude,
      longitude: longitude,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      spots: spots ?? this.spots,
      imageUrl: imageUrl,
      characteristics: characteristics ?? this.characteristics,
      pictures: pictures ?? this.pictures,
      tariff: tariff ?? this.tariff,
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
      ai: ai ?? this.ai,
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static String _buildImageUrl(String path) {
    if (path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '${AppConstants.baseUrlNest}$path';
  }
}
