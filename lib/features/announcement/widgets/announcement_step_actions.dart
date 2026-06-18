import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class AnnouncementStepActions extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
  final bool isNextEnabled;

  const AnnouncementStepActions({
    super.key,
    required this.onBack,
    required this.onNext,
    required this.isNextEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final buttonHeight = rs.adaptive(mobile: 50, tablet: 52, desktop: 54);
    final fontSize = rs.adaptive(mobile: 15, tablet: 16, desktop: 16);
    final spacing = rs.adaptive(mobile: 12, tablet: 14, desktop: 16);
    final radius = rs.adaptive(mobile: 24, tablet: 28, desktop: 30);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: buttonHeight,
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                side: const BorderSide(
                  color: Color(0xFFD6EA74),
                  width: 1.2,
                ),
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: rs.adaptive(mobile: 12, tablet: 16, desktop: 18),
                ),
              ),
              child: Text(AppStrings.retour,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2A2A2A),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: SizedBox(
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: isNextEnabled ? onNext : null,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFB7F000),
                disabledBackgroundColor: const Color(0xFFE3E3E3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: rs.adaptive(mobile: 12, tablet: 16, desktop: 18),
                ),
              ),
              child: Text(AppStrings.suivant,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}