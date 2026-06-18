import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_assets.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/constants/app_strings.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  static const double _logoSize = 72;
  static const double _titleFontSize = 22;
  static const double _subtitleFontSize = 14;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Image.asset(
          AppAssets.logo,
          width: _logoSize+200,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.local_parking_rounded,
            size: _logoSize,
            color: AppColors.colorBtn,
          ),
        ),
      
        const SizedBox(height: 10),
        Text(AppStrings.seConnecter2,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: _titleFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(AppStrings.connectezVousPourAccederAVotre,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: _subtitleFontSize,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}