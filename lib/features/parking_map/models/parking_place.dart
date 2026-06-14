import 'package:tunipark/core/constants/app_constants.dart';
import 'package:tunipark/features/parking_map/models/tariff_model.dart';

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
  });

  factory ParkingPlace.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final pictures = List<String>.from(json['pictures'] ?? []);
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
      pictures: pictures.map(_buildImageUrl).toList(),
      characteristics: List<String>.from(json['characteristics'] ?? []),
      tariff: null,
      vehicleTypes: List<String>.from(json['vehicleTypes'] ?? []),
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
