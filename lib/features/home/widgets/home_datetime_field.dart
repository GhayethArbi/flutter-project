import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class HomeDateTimeField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  const HomeDateTimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final fieldHeight = rs.adaptive(
      mobile: rs.clampSize(rs.hp(0.065), 50, 56),
      tablet: 58,
      desktop: 62,
    );

    final radius = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);
    final labelSize = rs.adaptive(mobile: 14, tablet: 15, desktop: 16);
    final valueSize = rs.adaptive(mobile: 14, tablet: 15, desktop: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: const Color(0xFF8DA2B8),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: rs.adaptive(mobile: 6, tablet: 8, desktop: 10)),
        InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Container(
            height: fieldHeight,
            padding: EdgeInsets.symmetric(
              horizontal: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: const Color(0xFFD8E1E8)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _displayText(value),
                    style: TextStyle(
                      fontSize: valueSize,
                      color: value == null
                          ? const Color(0xFFB4B4B4)
                          : const Color(0xFF224466),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Color(0xFF224466),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _displayText(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Sélectionner la date et l’heure';
    }

    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$day/$month/$year à $hour:$minute';
    }
}