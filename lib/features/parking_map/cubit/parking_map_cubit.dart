import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tunipark/features/parking_map/models/parking_view_mode.dart';
import 'package:tunipark/features/parking_map/models/selected_place.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:tunipark/features/parking_map/services/parking_map_service.dart';

import 'parking_map_state.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ParkingMapCubit extends Cubit<ParkingMapState> {
  final ParkingMapService parkingMapService;

  ParkingMapCubit(this.parkingMapService) : super(ParkingMapState.initial());

  MapboxMap? mapboxMap;

  Future<void> initialize({
    required SelectedPlace selectedPlace,
    String? zoneId,
  }) async {
    emit(
      state.copyWith(selectedPlace: selectedPlace, loading: true, error: null),
    );

    try {
      final parkings = await parkingMapService.getRecommendedParkings(
        lat: selectedPlace.latitude,
        lng: selectedPlace.longitude,
      );
      emit(
        state.copyWith(
          parkings: parkings,
          selectedIndex: 0,
          loading: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Failed to load parkings'));
    }
  }

  Future<void> onMapCreated(MapboxMap map) async {
    mapboxMap = map;

    await mapboxMap!.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    await moveToSelectedPlace(animated: false);
  }

  void showMap() {
    if (state.viewMode == ParkingViewMode.map) return;
    emit(state.copyWith(viewMode: ParkingViewMode.map));
  }

  void showList() {
    if (state.viewMode == ParkingViewMode.list) return;
    emit(state.copyWith(viewMode: ParkingViewMode.list));
  }

  Future<void> moveToSelectedPlace({bool animated = true}) async {
    if (mapboxMap == null || state.selectedPlace == null) return;

    final place = state.selectedPlace!;

    final camera = CameraOptions(
      center: Point(coordinates: Position(place.longitude, place.latitude)),
      zoom: 14,
      padding: MbxEdgeInsets(top: 140, left: 40, bottom: 260, right: 40),
    );

    if (animated) {
      await mapboxMap!.flyTo(camera, MapAnimationOptions(duration: 800));
    } else {
      await mapboxMap!.setCamera(camera);
    }
  }

  Future<void> moveToParking(int index, {bool animated = true}) async {
    if (mapboxMap == null || index < 0 || index >= state.parkings.length)
      return;

    final parking = state.parkings[index];

    final camera = CameraOptions(
      center: Point(coordinates: Position(parking.longitude, parking.latitude)),
      zoom: 15,
      padding: MbxEdgeInsets(top: 140, left: 40, bottom: 260, right: 40),
    );

    if (animated) {
      await mapboxMap!.flyTo(camera, MapAnimationOptions(duration: 800));
    } else {
      await mapboxMap!.setCamera(camera);
    }
  }

  Future<void> selectParkingFromMarker(int index) async {
    if (index < 0 || index >= state.parkings.length) return;
    if (index == state.selectedIndex) return;

    emit(state.copyWith(selectedIndex: index));
    await moveToParking(index);
  }

  Future<void> selectParkingFromCard(int index) async {
    if (index < 0 || index >= state.parkings.length) return;
    if (index == state.selectedIndex) return;

    emit(state.copyWith(selectedIndex: index));
    await moveToParking(index);
  }

  Future<void> selectParkingFromList(int index) async {
    if (index < 0 || index >= state.parkings.length) return;

    emit(state.copyWith(selectedIndex: index, viewMode: ParkingViewMode.map));

    // Wait until Mapbox widget is rebuilt
    await Future.delayed(const Duration(milliseconds: 400));

    if (isClosed || mapboxMap == null) return;

    await moveToParking(index);
  }

  Future<void> moveToCurrentLocation(BuildContext context) async {
    if (mapboxMap == null) return;

    final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.gpsIsDisabledPleaseEnableLocation),
        ),
      );
      await geo.Geolocator.openLocationSettings();
      return;
    }

    var permission = await geo.Geolocator.checkPermission();

    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();

      if (permission == geo.LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.locationPermissionDenied)),
        );
        return;
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permission permanently denied. Open app settings.',
          ),
        ),
      );
      await geo.Geolocator.openAppSettings();
      return;
    }

    final position = await geo.Geolocator.getCurrentPosition(
      locationSettings: const geo.LocationSettings(
        accuracy: geo.LocationAccuracy.high,
      ),
    );

    await mapboxMap!.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position(position.longitude, position.latitude),
        ),
        zoom: 16,
        padding: MbxEdgeInsets(top: 140, left: 40, bottom: 260, right: 40),
      ),
      MapAnimationOptions(duration: 800),
    );
  }
}
