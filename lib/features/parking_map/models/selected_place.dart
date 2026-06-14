import 'package:equatable/equatable.dart';

class SelectedPlace extends Equatable {
  final String id;
  final String label;
  final double latitude;
  final double longitude;

  const SelectedPlace({
    required this.id,
    required this.label,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [id, label, latitude, longitude];
}
