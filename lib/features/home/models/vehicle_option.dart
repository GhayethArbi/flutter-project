import 'package:equatable/equatable.dart';

class VehicleOption extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String iconAsset;

  const VehicleOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
  });

  @override
  List<Object> get props => [id, title, subtitle, iconAsset];

}