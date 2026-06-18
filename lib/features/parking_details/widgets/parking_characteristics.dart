import 'package:flutter/material.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ParkingCharacteristics extends StatelessWidget {
  final List<String> characteristics;

  const ParkingCharacteristics({super.key, required this.characteristics});

  @override
  Widget build(BuildContext context) {
    if (characteristics.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.caracteristiques,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF173B6C),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFD0D5DD)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: characteristics
                .map((item) => _Item(_iconForCharacteristic(item), item))
                .toList(),
          ),
        ),
      ],
    );
  }

  IconData _iconForCharacteristic(String value) {
    switch (value.toLowerCase()) {
      case 'couvert':
        return Icons.roofing_outlined;
      case 'sécurisé':
        return Icons.security_outlined;
      case 'éclairé':
        return Icons.light_mode_outlined;
      case 'accès 24h':
        return Icons.access_time_outlined;
      case 'portail automatique':
        return Icons.door_sliding_outlined;
      case 'place large':
        return Icons.open_in_full_outlined;
      case 'caméras':
        return Icons.videocam_outlined;
      case 'gardien':
        return Icons.person_outline;
      default:
        return Icons.check_circle_outline;
    }
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Item(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13.5, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
