import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:tunipark/core/models/parking_spot_type.dart';
import 'package:tunipark/core/models/parking_vehicle_type.dart';

class AnnouncementFlowState extends Equatable {
  final int currentStep;
  final ParkingSpotType? parkingType;

  final String address;
  final double? latitude;
  final double? longitude;
  final String? markerId;

  final String title;
  final String description;
  final List<String> characteristics;
  final List<File> photos;

  // ── NEW fields ──────────────────────────────────────────────
  final int maxPlaces;
  final String openingTime;
  final String closingTime;
  final List<ParkingVehicleType> vehicleTypes;
  // ────────────────────────────────────────────────────────────

  final List<File> legalDocuments;
  final double pricePerDay;
  final double pricePerMonth;
  final double? pricePerUnit; // NEW – optional hourly price

  // Publishing state
  final bool isLoading;
  final String errorMessage;

  const AnnouncementFlowState({
    this.currentStep = 0,
    this.parkingType,
    this.address = '',
    this.latitude,
    this.longitude,
    this.markerId,
    this.title = '',
    this.description = '',
    this.characteristics = const [],
    this.photos = const [],
    // NEW defaults
    this.maxPlaces = 1,
    this.openingTime = '08:00',
    this.closingTime = '22:00',
    this.vehicleTypes = const [],
    // ─────────────
    this.legalDocuments = const [],
    this.pricePerDay = 18,
    this.pricePerMonth = 180,
    this.pricePerUnit,
    this.isLoading = false,
    this.errorMessage = '',
  });

  AnnouncementFlowState copyWith({
    int? currentStep,
    ParkingSpotType? parkingType,
    String? address,
    double? latitude,
    double? longitude,
    String? markerId,
    String? title,
    String? description,
    List<String>? characteristics,
    List<File>? photos,
    int? maxPlaces,
    String? openingTime,
    String? closingTime,
    List<ParkingVehicleType>? vehicleTypes,
    List<File>? legalDocuments,
    double? pricePerDay,
    double? pricePerMonth,
    double? pricePerUnit,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AnnouncementFlowState(
      currentStep: currentStep ?? this.currentStep,
      parkingType: parkingType ?? this.parkingType,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      markerId: markerId ?? this.markerId,
      title: title ?? this.title,
      description: description ?? this.description,
      characteristics: characteristics ?? this.characteristics,
      photos: photos ?? this.photos,
      maxPlaces: maxPlaces ?? this.maxPlaces,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
      legalDocuments: legalDocuments ?? this.legalDocuments,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        parkingType,
        address,
        latitude,
        longitude,
        markerId,
        title,
        description,
        characteristics,
        photos,
        maxPlaces,
        openingTime,
        closingTime,
        vehicleTypes,
        legalDocuments,
        pricePerDay,
        pricePerMonth,
        pricePerUnit,
        isLoading,
        errorMessage,
      ];
}