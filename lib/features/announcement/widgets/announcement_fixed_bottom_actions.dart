import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class AnnouncementFixedBottomActions extends StatelessWidget {
  final Widget child;

  const AnnouncementFixedBottomActions({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        rs.adaptive(mobile: 16, tablet: 24, desktop: 32),
        rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
        rs.adaptive(mobile: 16, tablet: 24, desktop: 32),
        rs.adaptive(mobile: 20, tablet: 24, desktop: 28),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
      ),
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}