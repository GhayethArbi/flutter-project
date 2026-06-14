import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_spacing.dart';

class AppPageContainer extends StatelessWidget {
  final Widget child;

  const AppPageContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding(context),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: child,
          ),
        ),
      ),
    );
  }
}