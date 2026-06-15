import 'package:tunipark/core/constants/app_constants.dart';
import 'package:tunipark/features/parking_map/models/tariff_model.dart';

class ParkingAi {
  final int views;
  final int starts;
  final int extensions;
  final double distanceKm;
  final int score;
  final String recommendation;

  const ParkingAi({
    required this.views,
    required this.starts,
    required this.extensions,
    required this.distanceKm,
    required this.score,
    required this.recommendation,
  });

  factory ParkingAi.fromJson(Map<String, dynamic> json) {
    return ParkingAi(
      views: int.tryParse(json['views']?.toString() ?? '') ?? 0,
      starts: int.tryParse(json['starts']?.toString() ?? '') ?? 0,
      extensions: int.tryParse(json['extensions']?.toString() ?? '') ?? 0,
      distanceKm: _toDouble(json['distanceKm']),
      score: int.tryParse(json['score']?.toString() ?? '') ?? 0,
      recommendation: json['recommendation']?.toString() ?? 'LOW_PRIORITY',
    );
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
  final ParkingAi? ai;

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
    final rawPictures = List.from(json['pictures'] ?? []);
    final firstPicture =
        rawPictures.isNotEmpty ? rawPictures.first.toString() : '';

    return ParkingPlace(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      address: location['address']?.toString() ?? '',
      latitude: _toDouble(location['lat'] ?? location['latitude']),
      longitude: _toDouble(location['lng'] ?? location['longitude']),
      price: _toDouble(
        json['pricePerDay'] ?? json['tariff']?['pricePerDay'],
      ),
      rating: _toDouble(json['rating']),
      spots: int.tryParse(json['availablePlaces']?.toString() ?? '') ?? 0,
      imageUrl: _buildImageUrl(firstPicture),
      pictures: rawPictures.map((e) => _buildImageUrl(e.toString())).toList(),
      characteristics:
          List.from(json['characteristics'] ?? []).map((e) => e.toString()).toList(),
      tariff: json['tariff'] == null
          ? null
          : TariffModel.fromJson(Map<String, dynamic>.from(json['tariff'])),
      vehicleTypes:
          List.from(json['vehicleTypes'] ?? []).map((e) => e.toString()).toList(),
      ai: json['ai'] is Map
          ? ParkingAi.fromJson(Map<String, dynamic>.from(json['ai'] as Map))
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
    ParkingAi? ai,
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