import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../parking_map/models/selected_place.dart';
import '../../services/location_search_service.dart';
import 'address_search_state.dart';

class AddressSearchCubit extends Cubit<AddressSearchState> {
  AddressSearchCubit({
    required this.locationSearchService,
  }) : super(const AddressSearchState());

  final LocationSearchService locationSearchService;

  Timer? _debounce;

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  void loadRecentPlaces(List<SelectedPlace> recentPlaces) {
    emit(state.copyWith(recentPlaces: recentPlaces));
  }

  void onQueryChanged(String value) {
    emit(
      state.copyWith(
        query: value,
        clearError: true,
      ),
    );

    _debounce?.cancel();

    final trimmed = value.trim();

    if (trimmed.length < 3) {
      emit(
        state.copyWith(
          status: AddressSearchStatus.initial,
          suggestions: const [],
        ),
      );
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      await search(trimmed);
    });
  }

  Future<void> search(String query) async {
    emit(
      state.copyWith(
        status: AddressSearchStatus.loading,
        clearError: true,
      ),
    );

    try {
      final suggestions =
          await locationSearchService.searchPlaces(query: query);

      if (suggestions.isEmpty) {
        emit(
          state.copyWith(
            status: AddressSearchStatus.empty,
            suggestions: const [],
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: AddressSearchStatus.success,
          suggestions: suggestions,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressSearchStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
          suggestions: const [],
        ),
      );
    }
  }

  Future<SelectedPlace> useCurrentLocation() async {
    emit(
      state.copyWith(
        status: AddressSearchStatus.currentLocationLoading,
        clearError: true,
      ),
    );

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Le service de localisation est désactivé.');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw Exception('La permission de localisation a été refusée.');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'La permission de localisation est refusée définitivement.',
        );
      }

      final position = await Geolocator.getCurrentPosition();

      final place = await locationSearchService.reverseGeocode(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      emit(
        state.copyWith(
          status: AddressSearchStatus.success,
        ),
      );

      return place;
    } catch (e) {
      emit(
        state.copyWith(
          status: AddressSearchStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
      rethrow;
    }
  }
}