import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/models/parking_spot_type.dart';
import 'package:tunipark/features/announcement/services/parking_service.dart';
import 'package:tunipark/features/my_lots/models/my_lot_model.dart';
import 'package:tunipark/features/my_lots/services/my_lots_service.dart';

import 'edit_announcement_state.dart';

class EditAnnouncementCubit extends Cubit<EditAnnouncementState> {
  EditAnnouncementCubit({
    required MyLotModel lot,
    required MyLotsService myLotsService,
    required ParkingService parkingService,
  })  : _lotId = lot.id,
        _myLotsService = myLotsService,
        _parkingService = parkingService,
        super(
          EditAnnouncementState(
            // Pre-fill from existing lot
            parkingType: lot.spotType,
            address: lot.address,
            latitude: lot.latitude,
            longitude: lot.longitude,
            title: lot.title,
            description: lot.description,
            characteristics: List<String>.from(lot.characteristics),
            existingPictureUrls: List<String>.from(lot.pictures),
            pricePerDay: lot.pricePerDay ?? 18,
            pricePerMonth: lot.pricePerMonth ?? 180,
            openingTime: lot.openingTime,
            closingTime: lot.closingTime,
          ),
        );

  final String _lotId;
  final MyLotsService _myLotsService;
  final ParkingService _parkingService;

  // ── Navigation ───────────────────────────────────────────────────────────

  void goToStep(int step) => emit(state.copyWith(currentStep: step));
  void nextStep() => emit(state.copyWith(currentStep: state.currentStep + 1));
  void previousStep() {
    if (state.currentStep > 1) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  // ── Field updates (mirror your AnnouncementFlowCubit) ────────────────────

  void selectParkingType(ParkingSpotType type) =>
      emit(state.copyWith(parkingType: type));

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

  void updateTitle(String value) => emit(state.copyWith(title: value));

  void updateDescription(String value) =>
      emit(state.copyWith(description: value));

  void toggleCharacteristic(String value) {
    final updated = List<String>.from(state.characteristics);
    updated.contains(value) ? updated.remove(value) : updated.add(value);
    emit(state.copyWith(characteristics: updated));
  }

  /// Remove a picture that is already on the server
  void removeExistingPicture(String url) {
    final updated = List<String>.from(state.existingPictureUrls)..remove(url);
    emit(state.copyWith(existingPictureUrls: updated));
  }

  /// Add newly picked local files
  void addNewPhotos(List<File> files) {
    final updated = List<File>.from(state.newPhotos)..addAll(files);
    emit(state.copyWith(newPhotos: updated));
  }

  void removeNewPhoto(File file) {
    final updated = List<File>.from(state.newPhotos)..remove(file);
    emit(state.copyWith(newPhotos: updated));
  }

  void updatePricePerDay(double value) =>
      emit(state.copyWith(pricePerDay: value));

  void updatePricePerMonth(double value) =>
      emit(state.copyWith(pricePerMonth: value));

  void updateOpeningTime(String value) =>
      emit(state.copyWith(openingTime: value));

  void updateClosingTime(String value) =>
      emit(state.copyWith(closingTime: value));

  // ── Submit (PATCH) ───────────────────────────────────────────────────────

  Future<void> saveChanges() async {
    emit(state.copyWith(status: EditAnnouncementStatus.loading));

    try {
      // 1. Upload any new photos → get new URLs
      List<String> uploadedUrls = [];
      if (state.newPhotos.isNotEmpty) {
        uploadedUrls = await _parkingService.uploadParkingPictures(
          photos: state.newPhotos,
        );
      }

      // 2. Combine kept existing + new uploads
      final allPictures = [
        ...state.existingPictureUrls,
        ...uploadedUrls,
      ];

      // 3. PATCH parking
      await _myLotsService.updateLot(_lotId, {
        'title': state.title,
        'spotType': state.parkingType?.apiValue,
        'description': state.description,
        'characteristics': state.characteristics,
        'pictures': allPictures,
        'location': {
          'address': state.address,
          'lat': state.latitude,
          'lng': state.longitude,
        },
        if (state.openingTime != null) 'openingTime': state.openingTime,
        if (state.closingTime != null) 'closingTime': state.closingTime,
      });

      // 4. PATCH tariff
      await _myLotsService.updateTariff(_lotId, {
        'pricePerDay': state.pricePerDay,
        'pricePerMonth': state.pricePerMonth,
      });

      emit(state.copyWith(status: EditAnnouncementStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: EditAnnouncementStatus.failure,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}