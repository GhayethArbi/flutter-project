enum VehicleType {
  car,
  motorcycle,
  utility,
}

extension VehicleTypeX on VehicleType {
  String get label {
    switch (this) {
      case VehicleType.car:
        return 'Voiture';
      case VehicleType.motorcycle:
        return 'Moto';
      case VehicleType.utility:
        return 'Utilitaire';
    }
  }
}