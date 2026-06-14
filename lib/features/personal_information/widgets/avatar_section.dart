import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/personal_information/cubit/personal_info_cubit.dart';

/// Circular avatar with initials, full name, and e-mail below it.
class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key, required this.state});

  final PersonalInfoState state;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Column(
      children: [
        _InitialsCircle(initials: state.avatarInitials),
        const SizedBox(height: 12),
        Text(
          state.fullName,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 18, tablet: 22),
            fontWeight: FontWeight.w700,
            color: AppTokens.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          state.email,
          style: const TextStyle(fontSize: 13, color: AppTokens.textSecondary),
        ),
      ],
    );
  }
}

class _InitialsCircle extends StatelessWidget {
  const _InitialsCircle({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final size = rs.adaptive(mobile: 84.0, tablet: 100.0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppTokens.limeLight,
        shape: BoxShape.circle,
        border: Border.all(color: AppTokens.lime, width: 2.5),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 28, tablet: 34),
            fontWeight: FontWeight.w700,
            color: AppTokens.limeDark,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}   