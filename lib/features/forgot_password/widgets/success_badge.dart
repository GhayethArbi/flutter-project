import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final size = rs.adaptive(
      mobile: 110,
      tablet: 130,
      desktop: 140,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFEFFFBE),
        border: Border.all(
          color: AppColors.colorBtn,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_rounded,
        size: rs.adaptive(mobile: 46, tablet: 56, desktop: 60),
        color: AppColors.colorBtn,
      ),
    );
  }
}