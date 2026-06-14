class VehicleOption {
  final String id;
  final String title;
  final String subtitle;
  final String iconAsset;
  final bool enabled;

  const VehicleOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
    this.enabled = true,
  });

  VehicleOption copyWith({bool? enabled}) => VehicleOption(
    id: id,
    title: title,
    subtitle: subtitle,
    iconAsset: iconAsset,
    enabled: enabled ?? this.enabled,
  );
}
