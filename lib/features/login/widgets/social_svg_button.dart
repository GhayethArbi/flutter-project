import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunipark/core/theme/app_colors.dart';

class SocialSvgButton extends StatelessWidget {
  final String assetPath;
  final double iconSize;
  final double boxSize;
  final double borderRadius;
  final VoidCallback? onTap;

  const SocialSvgButton({
    required this.assetPath,
    required this.iconSize,
    required this.boxSize,
    required this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppColors.colorBtn, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}