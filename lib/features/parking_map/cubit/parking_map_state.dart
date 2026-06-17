import 'package:tunipark/features/parking_map/models/parking_place.dart';
import 'package:tunipark/features/parking_map/models/parking_view_mode.dart';
import 'package:tunipark/features/parking_map/models/selected_place.dart';

class ParkingMapState {
  final SelectedPlace? selectedPlace;
  final List<ParkingPlace> parkings;
  final int selectedIndex;
  final ParkingViewMode viewMode;
  final bool loading;
  final String? error;

  const ParkingMapState({
    required this.selectedPlace,
    required this.parkings,
    required this.selectedIndex,
    required this.viewMode,
    required this.loading,
    required this.error,
  });

  ParkingMapState copyWith({
    SelectedPlace? selectedPlace,
    List<ParkingPlace>? parkings,
    int? selectedIndex,
    ParkingViewMode? viewMode,
    bool? loading,
    String? error,
  }) {
    return ParkingMapState(
      selectedPlace: selectedPlace ?? this.selectedPlace,
      parkings: parkings ?? this.parkings,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      viewMode: viewMode ?? this.viewMode,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  factory ParkingMapState.initial() {
    return const ParkingMapState(
      selectedPlace: null,
      parkings: [],
      selectedIndex: 0,
      viewMode: ParkingViewMode.map,
      loading: false,
      error: null,
    );
  }

  ParkingPlace? get selectedParking {
    if (parkings.isEmpty ||
        selectedIndex < 0 ||
        selectedIndex >= parkings.length) {
      return null;
    }
    return parkings[selectedIndex];
  }

  bool get isMapMode => viewMode == ParkingViewMode.map;
  bool get isListMode => viewMode == ParkingViewMode.list;
}
