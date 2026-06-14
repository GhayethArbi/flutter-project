class VehicleModel {
  final String id;
  final String plate;
  final bool isSelected;

  const VehicleModel({
    required this.id,
    required this.plate,
    this.isSelected = false,
  });

  VehicleModel copyWith({
    String? id,
    String? plate,
    bool? isSelected,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      plate: plate ?? this.plate,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}