import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class SignUpButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  final String label;

  const SignUpButton({
    super.key,
    required this.isLoading,
    required this.onTap,
    this.label = 'Créer un compte',
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    return GestureDetector(
      onTap: !isLoading ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
        decoration: BoxDecoration(
          color: AppColors.colorBtn,
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 26, tablet: 30, desktop: 34),
          ),
          boxShadow: [
                  BoxShadow(
                    color: AppColors.colorBtnOpacity,
                    blurRadius: rs.adaptive(
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                    offset: Offset(
                      0,
                      rs.adaptive(mobile: 5, tablet: 6, desktop: 7),
                    ),
                  ),
                ]
              ,
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.black,
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
      ),
    );
  }
}
