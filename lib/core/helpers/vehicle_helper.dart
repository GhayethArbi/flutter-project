import 'package:tunipark/core/models/Vehicules_option.dart';
import 'package:tunipark/core/models/all_vehicle.dart';

List<VehicleOption> buildVehicleCompatibility(
  List<String> parkingVehicleTypes,
) {
  return allVehicles.map((vehicle) {
    final isEnabled = parkingVehicleTypes.contains(vehicle.id);

    return vehicle.copyWith(enabled: isEnabled);
  }).toList();
}