import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback onTap;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return GestureDetector(
      onTap: isEnabled && !isLoading ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        height: rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
        decoration: BoxDecoration(
          color: isEnabled
              ? AppColors.colorBtn
              : const Color.fromARGB(255, 99, 126, 17),
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 28, tablet: 32, desktop: 32),
          ),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: AppColors.boxShadow,
                    blurRadius: 20,
                    offset: const Offset(0, 7),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                height: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.black,
                ),
              )
            : Text(AppStrings.seConnecter,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
      ),
    );
  }
}