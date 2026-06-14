import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class AnnouncementPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AnnouncementPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final height = rs.adaptive(mobile: 50, tablet: 52, desktop: 54);
    final fontSize = rs.adaptive(mobile: 15, tablet: 16, desktop: 16);
    final radius = rs.adaptive(mobile: 24, tablet: 26, desktop: 28);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB7F000),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
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
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}