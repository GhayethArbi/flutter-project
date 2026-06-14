import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class HomeDurationChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const HomeDurationChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
          vertical: rs.adaptive(mobile: 8, tablet: 10, desktop: 12),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF224466)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF224466),
          ),
        ),
      ),
    );
  }
}