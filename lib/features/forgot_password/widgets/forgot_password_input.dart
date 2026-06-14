import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class ForgotPasswordInput extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const ForgotPasswordInput({
    super.key,
    required this.hint,
    required this.onChanged,
    this.obscureText = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
        fontWeight: FontWeight.w500,
        color: const Color(0xFF222222),
      ),
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        hintStyle: TextStyle(
          fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
          color: const Color(0xFF777777),
        ),
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        contentPadding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
          vertical: rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
        ),
        enabledBorder: _border(context, false),
        focusedBorder: _border(context, false),
        errorBorder: _border(context, true),
        focusedErrorBorder: _border(context, true),
      ),
    );
  }

  OutlineInputBorder _border(BuildContext context, bool error) {
    final rs = context.rs;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
      ),
      borderSide: BorderSide(
        color: error ? Colors.red : AppColors.colorBtn,
        width: 1.1,
      ),
    );
  }
}