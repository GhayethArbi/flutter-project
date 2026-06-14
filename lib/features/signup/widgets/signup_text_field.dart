import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class SignUpTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final void Function(String) onChanged;
  final String? errorText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;

  const SignUpTextField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.errorText,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme    = Theme.of(context);
    final rs       = context.rs;
    final hasError = errorText != null;

    final radius = rs.adaptive(mobile: 12.0, tablet: 14.0, desktop: 14.0);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: rs.adaptive(mobile: 14.0, tablet: 15.0, desktop: 16.0),
      ),
      cursorColor: AppColors.colorBtn,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        errorMaxLines: 2,
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: rs.adaptive(mobile: 11.0, tablet: 12.0, desktop: 13.0),
        ),
        hintStyle: TextStyle(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: rs.adaptive(mobile: 13.0, tablet: 14.0, desktop: 15.0),
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        contentPadding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(mobile: 18.0, tablet: 20.0, desktop: 22.0),
          vertical:   rs.adaptive(mobile: 16.0, tablet: 18.0, desktop: 20.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: hasError ? Colors.red : AppColors.colorBtn,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: hasError ? Colors.red : AppColors.colorBtn,
            width: 1.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.red, width: 1.8),
        ),
      ),
    );
  }
}