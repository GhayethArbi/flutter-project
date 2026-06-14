import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class AnnouncementSingleActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AnnouncementSingleActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final width = rs.adaptive(
      mobile: double.infinity,   // full width on mobile
      tablet: 220,
      desktop: 240,
    );

    final height = rs.adaptive(mobile: 48, tablet: 50, desktop: 52);
    final fontSize = rs.adaptive(mobile: 15, tablet: 16, desktop: 16);
    final radius = rs.adaptive(mobile: 24, tablet: 28, desktop: 30);

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          side: const BorderSide(
            color: Color(0xFFD6EA74),
            width: 1.2,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: rs.adaptive(mobile: 16, tablet: 20, desktop: 24),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2A2A2A),
          ),
        ),
      ),
    );
  }
}