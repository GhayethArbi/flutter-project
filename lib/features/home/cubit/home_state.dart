import 'package:equatable/equatable.dart';
import 'package:tunipark/features/parking_map/models/selected_place.dart';

import '../models/vehicle_option.dart';

enum HomeMode { monthly, hourlyDaily }

class HomeState extends Equatable {
  final HomeMode selectedMode;
  final String address;
  final int bottomNavIndex;
  final bool isSubmitting;

  final bool isVehicleDropdownOpen;
  final bool isElectricVehicle;
  final VehicleOption? selectedVehicle;
  final SelectedPlace? selectedPlace;

  final DateTime? startDateTime;
  final DateTime? endDateTime;

  const HomeState({
    this.selectedMode = HomeMode.monthly,
    this.address = '',
    this.bottomNavIndex = 0,
    this.isSubmitting = false,
    this.isVehicleDropdownOpen = false,
    this.isElectricVehicle = false,
    this.selectedVehicle,
    this.selectedPlace,
    this.startDateTime,
    this.endDateTime,
  });

  bool get shouldShowBookingFields => selectedMode == HomeMode.hourlyDaily;

  bool get hasValidBookingRange {
    if (!shouldShowBookingFields) return true;
    if (startDateTime == null || endDateTime == null) return false;
    return endDateTime!.isAfter(startDateTime!);
  }

  bool get canSearch =>
      selectedPlace != null &&
      selectedVehicle != null &&
      hasValidBookingRange;

  HomeState copyWith({
    HomeMode? selectedMode,
    String? address,
    int? bottomNavIndex,
    bool? isSubmitting,
    bool? isVehicleDropdownOpen,
    bool? isElectricVehicle,
    VehicleOption? selectedVehicle,
    bool clearSelectedVehicle = false,
    SelectedPlace? selectedPlace,
    DateTime? startDateTime,
    DateTime? endDateTime,
    bool clearDateRange = false,
    bool clearSelectedPlace = false,
  }) {
    return HomeState(
      selectedMode: selectedMode ?? this.selectedMode,
      address: address ?? this.address,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isVehicleDropdownOpen:
          isVehicleDropdownOpen ?? this.isVehicleDropdownOpen,
      isElectricVehicle: isElectricVehicle ?? this.isElectricVehicle,
      selectedVehicle: clearSelectedVehicle
          ? null
          : (selectedVehicle ?? this.selectedVehicle),
      selectedPlace:
          clearSelectedPlace ? null : (selectedPlace ?? this.selectedPlace),
      startDateTime:
          clearDateRange ? null : (startDateTime ?? this.startDateTime),
      endDateTime: clearDateRange ? null : (endDateTime ?? this.endDateTime),
    );
  }

  @override
  List<Object?> get props => [
        selectedMode,
        address,
        bottomNavIndex,
        isSubmitting,
        isVehicleDropdownOpen,
        isElectricVehicle,
        selectedVehicle,
        selectedPlace,
        startDateTime,
        endDateTime,
      ];
}