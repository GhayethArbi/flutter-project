import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:tunipark/core/models/parking_spot_type.dart';

enum EditAnnouncementStatus { idle, loading, success, failure }

class EditAnnouncementState extends Equatable {
  const EditAnnouncementState({
    this.currentStep = 1,
    this.status = EditAnnouncementStatus.idle,
    this.errorMessage,
    // pre-filled fields
    this.parkingType,
    this.address = '',
    this.latitude,
    this.longitude,
    this.title = '',
    this.description = '',
    this.characteristics = const [],
    this.existingPictureUrls = const [],
    this.newPhotos = const [],
    this.pricePerDay = 18,
    this.pricePerMonth = 180,
    this.openingTime,
    this.closingTime,
  });

  final int currentStep;
  final EditAnnouncementStatus status;
  final String? errorMessage;

  final ParkingSpotType? parkingType;
  final String address;
  final double? latitude;
  final double? longitude;
  final String title;
  final String description;
  final List<String> characteristics;

  /// URLs already on server (shown as network images)
  final List<String> existingPictureUrls;

  /// New files picked locally (to upload)
  final List<File> newPhotos;

  final double pricePerDay;
  final double pricePerMonth;
  final String? openingTime;
  final String? closingTime;

  bool get isSubmitting => status == EditAnnouncementStatus.loading;

  EditAnnouncementState copyWith({
    int? currentStep,
    EditAnnouncementStatus? status,
    String? errorMessage,
    ParkingSpotType? parkingType,
    String? address,
    double? latitude,
    double? longitude,
    String? title,
    String? description,
    List<String>? characteristics,
    List<String>? existingPictureUrls,
    List<File>? newPhotos,
    double? pricePerDay,
    double? pricePerMonth,
    String? openingTime,
    String? closingTime,
  }) {
    return EditAnnouncementState(
      currentStep: currentStep ?? this.currentStep,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      parkingType: parkingType ?? this.parkingType,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      title: title ?? this.title,
      description: description ?? this.description,
      characteristics: characteristics ?? this.characteristics,
      existingPictureUrls: existingPictureUrls ?? this.existingPictureUrls,
      newPhotos: newPhotos ?? this.newPhotos,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
    );
  }

  @override
  List<Object?> get props => [
        currentStep,
        status,
        errorMessage,
        parkingType,
        address,
        latitude,
        longitude,
        title,
        description,
        characteristics,
        existingPictureUrls,
        newPhotos,
        pricePerDay,
        pricePerMonth,
        openingTime,
        closingTime,
      ];
}