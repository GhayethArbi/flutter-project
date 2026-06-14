import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/models/parking_spot_type.dart';
import 'package:tunipark/core/models/parking_vehicle_type.dart';
import 'package:tunipark/features/announcement/services/parking_service.dart';
import 'announcement_flow_state.dart';

class AnnouncementFlowCubit extends Cubit<AnnouncementFlowState> {
  AnnouncementFlowCubit({required ParkingService parkingService})
      : _parkingService = parkingService,
        super(const AnnouncementFlowState());

  final ParkingService _parkingService;

  // ── Navigation ──────────────────────────────────────────────
  void goToStep(int step) => emit(state.copyWith(currentStep: step));
  void nextStep() => emit(state.copyWith(currentStep: state.currentStep + 1));
  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  // ── Step 1: parking type ─────────────────────────────────────
  void selectParkingType(ParkingSpotType type) =>
      emit(state.copyWith(parkingType: type));

  // ── Step 2: location ─────────────────────────────────────────
  void updateAddress(String value) => emit(state.copyWith(address: value));
  void updateLocation({required double latitude, required double longitude}) =>
      emit(state.copyWith(latitude: latitude, longitude: longitude));
  void updateAddressAndLocation({
    required String address,
    required double latitude,
    required double longitude,
  }) =>
      emit(state.copyWith(
          address: address, latitude: latitude, longitude: longitude));

  // ── Step 3: description ──────────────────────────────────────
  void updateTitle(String value) => emit(state.copyWith(title: value));
  void updateDescription(String value) =>
      emit(state.copyWith(description: value));
  void toggleCharacteristic(String value) {
    final updated = List<String>.from(state.characteristics);
    updated.contains(value) ? updated.remove(value) : updated.add(value);
    emit(state.copyWith(characteristics: updated));
  }

  // ── Step 3b: capacity & schedule (NEW) ──────────────────────
  void updateMaxPlaces(int value) => emit(state.copyWith(maxPlaces: value));
  void updateOpeningTime(String value) =>
      emit(state.copyWith(openingTime: value));
  void updateClosingTime(String value) =>
      emit(state.copyWith(closingTime: value));
  void toggleVehicleType(ParkingVehicleType type) {
    final updated = List<ParkingVehicleType>.from(state.vehicleTypes);
    updated.contains(type) ? updated.remove(type) : updated.add(type);
    emit(state.copyWith(vehicleTypes: updated));
  }

  // ── Step 4: photos ───────────────────────────────────────────
  void addPhotos(List<File> files) {
    final updated = List<File>.from(state.photos)..addAll(files);
    emit(state.copyWith(photos: updated));
  }

  void removePhoto(File file) {
    final updated = List<File>.from(state.photos)..remove(file);
    emit(state.copyWith(photos: updated));
  }

  // ── Step 5: legal docs ───────────────────────────────────────
  void addLegalDocuments(List<File> files) {
    final updated = List<File>.from(state.legalDocuments)..addAll(files);
    emit(state.copyWith(legalDocuments: updated));
  }

  void removeLegalDocument(File file) {
    final updated = List<File>.from(state.legalDocuments)..remove(file);
    emit(state.copyWith(legalDocuments: updated));
  }

  // ── Step 6: pricing ──────────────────────────────────────────
  void updatePricePerDay(double value) =>
      emit(state.copyWith(pricePerDay: value));
  void updatePricePerMonth(double value) =>
      emit(state.copyWith(pricePerMonth: value));
  void updatePricePerUnit(double? value) =>
      emit(state.copyWith(pricePerUnit: value));

  // ── Misc ─────────────────────────────────────────────────────
  void clearError() => emit(state.copyWith(errorMessage: '', isLoading: false));
  void resetFlow() => emit(const AnnouncementFlowState());

  // ── Publish ──────────────────────────────────────────────────
  Future<void> publishAnnouncement() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      // 1. Upload images
      final uploadedPictures = await _parkingService.uploadParkingPictures(
        photos: state.photos,
      );

      // 2. Create parking – payload now includes new fields
      final parkingPayload = {
        'title': state.title,
        'type': 'PRIVATE',
        'spotType': state.parkingType!.apiValue,
        'description': state.description,
        'characteristics': state.characteristics,
        'pictures': uploadedPictures,
        'location': {
          'address': state.address,
          'lat': state.latitude,
          'lng': state.longitude,
        },
        'accessMode': 'FREQUENT',
        // ── NEW ──
        'maxPlaces': state.maxPlaces,
        'openingTime': state.openingTime,
        'closingTime': state.closingTime,
        'vehicleTypes':
            state.vehicleTypes.map((v) => v.apiValue).toList(),
      };

      final parking =
          await _parkingService.createParking(data: parkingPayload);

      // 3. Create tariff – payload now includes optional pricePerUnit
      final tariffPayload = <String, dynamic>{
        'pricePerDay': state.pricePerDay,
        'pricePerMonth': state.pricePerMonth,
        'minDuration': 30,
        'maxDuration': 1440,
        'parkingId': parking['id'],
        if (state.pricePerUnit != null && state.pricePerUnit! > 0)
          'pricePerUnit': state.pricePerUnit,
      };

      await _parkingService.createTariff(data: tariffPayload);

      emit(state.copyWith(isLoading: false, currentStep: 8));
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: message.isNotEmpty
            ? message
            : 'Une erreur est survenue. Veuillez réessayer.',
      ));
    }
  }
}