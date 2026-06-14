import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class ForgotPasswordLayout extends StatelessWidget {
  final Widget child;
  final VoidCallback onBack;
  final bool showBack;

  const ForgotPasswordLayout({
    super.key,
    required this.child,
    required this.onBack,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: rs.adaptive(
          mobile: 24,
          tablet: 36,
          desktop: 44,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: rs.adaptive(
              mobile: 22,
              tablet: 30,
              desktop: 36,
            ),
          ),

          if (showBack)
            IconButton(
              onPressed: onBack,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                color: const Color(0xFF222222),
              ),
            ),

          SizedBox(
            height: rs.adaptive(
              mobile: 22,
              tablet: 28,
              desktop: 34,
            ),
          ),

          child,
        ],
      ),
    );
  }
}