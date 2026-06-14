import 'package:flutter_bloc/flutter_bloc.dart';
import 'vehicles_state.dart';
import '../models/vehicle_model.dart';

class VehiclesCubit extends Cubit<VehiclesState> {
  VehiclesCubit() : super(VehiclesState.initial());

  void loadVehicles() {
    final data = [
      const VehicleModel(id: '1', plate: '123 تونس 1234'),
      const VehicleModel(id: '2', plate: '212 تونس 1204'),
    ];

    emit(state.copyWith(vehicles: data));
  }

  void selectVehicle(String id) {
    final updated =
        state.vehicles.map((v) {
          return v.copyWith(isSelected: v.id == id);
        }).toList();

    emit(state.copyWith(vehicles: updated));
  }

  void addVehicle(String plate) {
    final newVehicle = VehicleModel(
      id: DateTime.now().toString(),
      plate: plate,
    );

    emit(
      state.copyWith(
        vehicles: [...state.vehicles, newVehicle],
      ),
    );
  }
}