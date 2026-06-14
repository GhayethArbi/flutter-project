import 'package:equatable/equatable.dart';
import '../models/vehicle_model.dart';

class VehiclesState extends Equatable {
  final List<VehicleModel> vehicles;
  final bool isLoading;

  const VehiclesState({
    required this.vehicles,
    required this.isLoading,
  });

  factory VehiclesState.initial() {
    return const VehiclesState(
      vehicles: [],
      isLoading: false,
    );
  }

  bool get canConfirm =>
      vehicles.any((v) => v.isSelected);

  VehiclesState copyWith({
    List<VehicleModel>? vehicles,
    bool? isLoading,
  }) {
    return VehiclesState(
      vehicles: vehicles ?? this.vehicles,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [vehicles, isLoading];
}