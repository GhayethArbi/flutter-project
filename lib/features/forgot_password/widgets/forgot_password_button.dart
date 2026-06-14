import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class ForgotPasswordButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  const ForgotPasswordButton({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return SizedBox(
      width: double.infinity,
      height: rs.adaptive(mobile: 48, tablet: 52, desktop: 54),
      child: OutlinedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.colorBtn : Colors.white,
          disabledBackgroundColor: Colors.white,
          side: const BorderSide(
            color: AppColors.colorBtn,
            width: 1.1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.black,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF222222),
                ),
              ),
      ),
    );
  }
}