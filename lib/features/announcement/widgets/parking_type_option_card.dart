import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class ParkingTypeOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const ParkingTypeOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final horizontalPadding = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);
    final verticalPadding = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);
    final iconSize = rs.adaptive(mobile: 30, tablet: 34, desktop: 36);
    final titleSize = rs.adaptive(mobile: 16, tablet: 17, desktop: 18);
    final subtitleSize = rs.adaptive(mobile: 13, tablet: 14, desktop: 15);
    final checkSize = rs.adaptive(mobile: 22, tablet: 24, desktop: 24);
    final borderRadius = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);
    final spacing = rs.adaptive(mobile: 12, tablet: 14, desktop: 16);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3FFD6) : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFB7F000)
                : const Color(0xFFD6EA74),
            width: isSelected ? 2 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: rs.adaptive(mobile: 2, tablet: 2, desktop: 3)),
              child: Icon(
                icon,
                size: iconSize,
                color: const Color(0xFF444444),
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2B2B2B),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: rs.adaptive(mobile: 6, tablet: 7, desktop: 8)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: subtitleSize,
                      height: 1.4,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
              Padding(
                padding: EdgeInsets.only(top: rs.adaptive(mobile: 2, tablet: 2, desktop: 3)),
                child: Icon(
                  Icons.check_circle,
                  color: const Color(0xFFB7F000),
                  size: checkSize,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}