// enum ParkingSpotType { underground, garage, outdoor, covered }

// extension ParkingSpotTypeX on ParkingSpotType {
//   String get apiValue {
//     switch (this) {
//       case ParkingSpotType.underground:
//         return 'UNDERGROUND';
//       case ParkingSpotType.garage:
//         return 'GARAGE';
//       case ParkingSpotType.outdoor:
//         return 'OUTDOOR';
//       case ParkingSpotType.covered:
//         return 'COVERED';
//     }
//   }
// }
enum ParkingSpotType { underground, garage, outdoor, covered }
 
extension ParkingSpotTypeX on ParkingSpotType {
  String get apiValue {
    switch (this) {
      case ParkingSpotType.underground: return 'UNDERGROUND';
      case ParkingSpotType.garage:      return 'GARAGE';
      case ParkingSpotType.outdoor:     return 'OUTDOOR';
      case ParkingSpotType.covered:     return 'COVERED';
    }
  }
}
