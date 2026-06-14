import 'package:flutter/material.dart';

class ParkingDimensions extends StatelessWidget {
  const ParkingDimensions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dimensions de la place',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF173B6C),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            _DimensionItem(label: 'Longueur : 5 m'),
            SizedBox(width: 16),
            _DimensionItem(label: 'Largeur : 2.4 m'),
            SizedBox(width: 16),
            _DimensionItem(label: 'Hauteur : 1.9 m'),
          ],
        ),
      ],
    );
  }
}

class _DimensionItem extends StatelessWidget {
  final String label;
  const _DimensionItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13.5,
        color: Colors.black87,
      ),
    );
  }
}