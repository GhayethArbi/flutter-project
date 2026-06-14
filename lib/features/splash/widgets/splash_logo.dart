import 'package:flutter/material.dart';

import '../../../core/theme/core.dart';

/// Fades in the TuniPark logo + name after the parking animation completes.
class SplashLogo extends StatelessWidget {
  final Animation<double> opacity;

  const SplashLogo({super.key, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.logo,
              width: 180,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.local_parking_rounded,
                size: 80,
                color: AppColors.lime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}