import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class AnnouncementIntroStepItem extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final bool showDivider;

  const AnnouncementIntroStepItem({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    const dividerColor = Color(0xFF2B2B2B);
    const titleColor = Color(0xFF1F1F1F);
    const subtitleColor = Color(0xFF6F6F6F);

    final titleSize = rs.adaptive(mobile: 15, tablet: 16, desktop: 17);
    final subtitleSize = rs.adaptive(mobile: 13, tablet: 14, desktop: 15);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number- $title',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            color: titleColor,
            height: 1.3,
          ),
        ),

        SizedBox(
          height: rs.adaptive(mobile: 8, tablet: 9, desktop: 10),
        ),

        Text(
          subtitle,
          style: TextStyle(
            fontSize: subtitleSize,
            height: 1.4,
            color: subtitleColor,
            fontWeight: FontWeight.w400,
          ),
        ),

        if (showDivider) ...[
          SizedBox(
            height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
          ),

          const Divider(
            thickness: 1,
            color: dividerColor,
          ),

          SizedBox(
            height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
          ),
        ],
      ],
    );
  }
}