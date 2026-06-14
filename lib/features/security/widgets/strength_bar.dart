import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_tokens.dart';

class StrengthBar extends StatelessWidget {
  const StrengthBar({required this.score});

  final int score;

  Color get _color {
    switch (score) {
      case 1:
        return AppTokens.danger;
      case 2:
        return const Color(0xFFEF9F27);
      case 3:
        return AppTokens.lime;
      case 4:
        return AppTokens.limeDark;
      default:
        return AppTokens.danger;
    }
  }

  String get _label {
    switch (score) {
      case 1:
        return 'Faible';
      case 2:
        return 'Moyen';
      case 3:
        return 'Fort';
      case 4:
        return 'Très fort';
      default:
        return 'Faible';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(4, (i) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
              height: 4,
              decoration: BoxDecoration(
                color: i < score ? _color : AppTokens.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
        const SizedBox(width: 10),
        Text(
          _label,
          style: TextStyle(
            fontSize: 12,
            color: _color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
