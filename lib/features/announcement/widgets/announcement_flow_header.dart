import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class AnnouncementFlowHeader extends StatelessWidget {
  final int step;
  final int totalSteps;
  final VoidCallback onBack;
  final VoidCallback onClose;

  const AnnouncementFlowHeader({
    super.key,
    required this.step,
    required this.totalSteps,
    required this.onBack,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final iconSize = rs.adaptive(mobile: 20, tablet: 22, desktop: 22);
    final textSize = rs.adaptive(mobile: 13, tablet: 14, desktop: 14);
    final verticalPadding = rs.adaptive(mobile: 6, tablet: 7, desktop: 8);
    final radius = rs.adaptive(mobile: 8, tablet: 10, desktop: 12);

    return Column(
      children: [
        /// Top row (Back + Close)
        Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: iconSize,
                color: const Color(0xFF2F2F2F),
              ),
            ),

            const Spacer(),

            IconButton(
              onPressed: onClose,
              icon: Icon(
                Icons.close,
                size: iconSize,
                color: const Color(0xFF2F2F2F),
              ),
            ),
          ],
        ),

        /// Step indicator
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          decoration: BoxDecoration(
            color: const Color(0xFFE7F2C5),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Text(
            'Étape $step / $totalSteps',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4A4A4A),
            ),
          ),
        ),
      ],
    );
  }
}