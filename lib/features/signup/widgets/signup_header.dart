import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_assets.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Image.asset(
          AppAssets.logo,
          width: 272,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.local_parking_rounded,
            size: 72,
            color: AppColors.colorBtn,
          ),
        ),
      
        const SizedBox(height: 36),
        Text(AppStrings.creerUnCompte,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(AppStrings.inscrivezVousPourAccederAVotre,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}