import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_text_styles.dart';

class OnboardingContent extends StatelessWidget {
  final String asset;
  final String title;
  final String description;
  final double imageHeight;

  const OnboardingContent({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 44),

        SizedBox(
          height: imageHeight,
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              Icons.image_not_supported_outlined,
              size: imageHeight * 0.4,
              color: theme.colorScheme.primary.withOpacity(0.4),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.onboardingTitle.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          description,
          textAlign: TextAlign.center,
          style: AppTextStyles.onboardingDescription.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}