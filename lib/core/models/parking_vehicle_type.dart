/// Mirrors the backend ParkingVehicleType enum.
enum ParkingVehicleType {
  small('SMALL'),
  medium('MEDIUM'),
  large('LARGE'),
  high('HIGH'),
  moto('MOTO'),
  bike('BIKE');

  const ParkingVehicleType(this.apiValue);
  final String apiValue;

  String get label {
    switch (this) {
      case ParkingVehicleType.small:
        return 'Petite voiture';
      case ParkingVehicleType.medium:
        return 'Voiture moyenne';
      case ParkingVehicleType.large:
        return 'Grand véhicule';
      case ParkingVehicleType.high:
        return 'Véhicule haut';
      case ParkingVehicleType.moto:
        return 'Moto';
      case ParkingVehicleType.bike:
        return 'Vélo';
    }
  }

  String get emoji {
    switch (this) {
      case ParkingVehicleType.small:
        return '🚗';
      case ParkingVehicleType.medium:
        return '🚙';
      case ParkingVehicleType.large:
        return '🚐';
      case ParkingVehicleType.high:
        return '🚌';
      case ParkingVehicleType.moto:
        return '🏍️';
      case ParkingVehicleType.bike:
        return '🚲';
    }
  }
}