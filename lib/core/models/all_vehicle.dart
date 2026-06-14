
import 'package:tunipark/core/models/Vehicules_option.dart';

const allVehicles = [
  VehicleOption(
    id: 'SMALL',
    title: 'Petit',
    subtitle: 'Long<4m, Larg<1.75m, Haut<1.5m',
    iconAsset: 'assets/vehicules/car_small.svg',
  ),
  VehicleOption(
    id: 'MEDIUM',
    title: 'Moyen',
    subtitle: 'Golf - Polo - Peugeot 308 -etc.',
    iconAsset: 'assets/vehicules/car_moyen.svg',
  ),
  VehicleOption(
    id: 'LARGE',
    title: 'Grand',
    subtitle: 'Range Rover - Peugeot 3008 -etc.',
    iconAsset: 'assets/vehicules/range.svg',
  ),
  VehicleOption(
    id: 'HIGH',
    title: 'Haut',
    subtitle: 'Camion -etc.',
    iconAsset: 'assets/vehicules/truck.svg',
  ),
  VehicleOption(
    id: 'MOTO',
    title: 'Moto',
    subtitle: 'Moto - Scooter -etc.',
    iconAsset: 'assets/vehicules/motorcyclle.svg',
  ),
  VehicleOption(
    id: 'BIKE',
    title: 'Vélo/trotinette',
    subtitle: 'Simple - Cargo - Biplace -etc.',
    iconAsset: 'assets/vehicules/bike.svg',
  ),
];
