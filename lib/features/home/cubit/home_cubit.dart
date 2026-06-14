import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/parking_map/models/selected_place.dart';

import '../models/vehicle_option.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final List<VehicleOption> vehicleOptions = const [
    VehicleOption(
      id: 'small',
      title: 'Petit',
      subtitle: 'Long<4m, Larg<1.75m, Haut<1.5m',
      iconAsset: 'assets/vehicules/car_small.svg',
    ),
    VehicleOption(
      id: 'medium',
      title: 'Moyen',
      subtitle: 'Golf - Polo - Peugeot 308 -etc.',
      iconAsset: 'assets/vehicules/car_moyen.svg',
    ),
    VehicleOption(
      id: 'large',
      title: 'Grand',
      subtitle: 'Range Rover - Peugeot 3008 -etc.',
      iconAsset: 'assets/vehicules/range.svg',
    ),
    VehicleOption(
      id: 'high',
      title: 'Haut',
      subtitle: 'Camion -etc.',
      iconAsset: 'assets/vehicules/truck.svg',
    ),
    VehicleOption(
      id: 'moto',
      title: 'Moto',
      subtitle: 'Moto - Scooter -etc.',
      iconAsset: 'assets/vehicules/motorcyclle.svg',
    ),
    VehicleOption(
      id: 'bike',
      title: 'Vélo/trotinette',
      subtitle: 'Simple - Cargo - Biplace -etc.',
      iconAsset: 'assets/vehicules/bike.svg',
    ),
  ];

  void updateAddress(String value) {
    emit(state.copyWith(address: value));
  }

  void toggleVehicleDropdown() {
    emit(state.copyWith(isVehicleDropdownOpen: !state.isVehicleDropdownOpen));
  }

  void setSelectedPlace(SelectedPlace place) {
    emit(state.copyWith(address: place.label, selectedPlace: place));
  }

  void closeVehicleDropdown() {
    emit(state.copyWith(isVehicleDropdownOpen: false));
  }

  void toggleElectricVehicle() {
    emit(state.copyWith(isElectricVehicle: !state.isElectricVehicle));
  }

  void selectVehicle(VehicleOption option) {
    emit(state.copyWith(selectedVehicle: option, isVehicleDropdownOpen: false));
  }

  void changeBottomNav(int index) {
    emit(state.copyWith(bottomNavIndex: index));
  }

  Future<SelectedPlace?> search() async {
    if (!state.canSearch || state.selectedPlace == null) return null;

    emit(state.copyWith(isSubmitting: true));

    await Future.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(isSubmitting: false));

    return state.selectedPlace;
  }




  void applyDuration(Duration duration) {
    final start = state.startDateTime ?? DateTime.now();

    emit(
      state.copyWith(startDateTime: start, endDateTime: start.add(duration)),
    );
  }
void setStartDateTime(DateTime value) {
  DateTime? updatedEnd = state.endDateTime;

  if (updatedEnd != null && !updatedEnd.isAfter(value)) {
    updatedEnd = null;
  }

  emit(
    state.copyWith(
      startDateTime: value,
      endDateTime: updatedEnd,
    ),
  );
}

void setEndDateTime(DateTime value) {
  emit(state.copyWith(endDateTime: value));
}

void changeMode(HomeMode mode) {
  emit(
    state.copyWith(
      selectedMode: mode,
      clearDateRange: mode == HomeMode.monthly,
    ),
  );
}

}
