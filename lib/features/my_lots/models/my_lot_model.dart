import 'package:tunipark/core/models/parking_spot_type.dart';

// Maps the ParkingStatus enum from backend
enum LotStatus { active, inactive }

// Maps ParkingSpotType from backend
// already defined in core/models/parking_spot_type.dart — reuse it

class MyLotModel {
  const MyLotModel({
    required this.id,
    required this.title,
    required this.spotType,
    required this.description,
    required this.characteristics,
    required this.pictures,
    required this.address,
    required this.status,
    required this.maxPlaces,
    required this.availablePlaces,
    this.openingTime,
    this.closingTime,
    this.pricePerDay,
    this.pricePerMonth,
    this.latitude,
    this.longitude,
  });

  final String id;
  final String title;
  final ParkingSpotType spotType;
  final String description;
  final List<String> characteristics;
  final List<String> pictures;
  final String address;
  final LotStatus status;
  final int maxPlaces;
  final int availablePlaces;
  final String? openingTime;
  final String? closingTime;
  final double? pricePerDay;
  final double? pricePerMonth;
  final double? latitude;
  final double? longitude;

  factory MyLotModel.fromJson(Map<String, dynamic> json) {
    // location can be { address, lat, lng }
    final location = json['location'] as Map<String, dynamic>?;

    return MyLotModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      spotType: _parseSpotType(json['spotType'] as String?),
      description: json['description'] as String? ?? '',
      characteristics: List<String>.from(json['characteristics'] ?? []),
      pictures: List<String>.from(json['pictures'] ?? []),
      address: location?['address'] as String? ?? '',
      status: (json['status'] as String?) == 'INACTIVE'
          ? LotStatus.inactive
          : LotStatus.active,
      maxPlaces: json['maxPlaces'] as int? ?? 0,
      availablePlaces: json['availablePlaces'] as int? ?? 0,
      openingTime: json['openingTime'] as String?,
      closingTime: json['closingTime'] as String?,
      pricePerDay: (json['pricePerDay'] as num?)?.toDouble(),
      pricePerMonth: (json['pricePerMonth'] as num?)?.toDouble(),
      latitude: (location?['lat'] as num?)?.toDouble(),
      longitude: (location?['lng'] as num?)?.toDouble(),
    );
  }

  static ParkingSpotType _parseSpotType(String? raw) {
    switch (raw) {
      case 'UNDERGROUND':
        return ParkingSpotType.underground;
      case 'GARAGE':
        return ParkingSpotType.garage;
      case 'OUTDOOR':
        return ParkingSpotType.outdoor;
      case 'COVERED':
        return ParkingSpotType.covered;
      default:
        return ParkingSpotType.garage;
    }
  }
}