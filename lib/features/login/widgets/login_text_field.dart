import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class LoginTextField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final void Function(String) onChanged;
  final String? errorText;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;

  const LoginTextField({
    super.key,
    required this.hint,
    required this.onChanged,
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
    final theme = Theme.of(context);
    final rs = context.rs;
    final bool hasError = errorText != null;

    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
      ),
      cursorColor: AppColors.colorBtn,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: rs.adaptive(mobile: 11, tablet: 12, desktop: 13),
        ),
        hintStyle: TextStyle(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.textFieldBackgound,
        contentPadding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
          vertical: rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
          ),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
          ),
          borderSide: BorderSide(
            color: hasError ? Colors.red : AppColors.colorBtn,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
          ),
          borderSide: BorderSide(
            color: hasError ? Colors.red : AppColors.colorBtn,
            width: 1.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
          ),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
          ),
          borderSide: const BorderSide(color: Colors.red, width: 1.8),
        ),
      ),
    );
  }
}