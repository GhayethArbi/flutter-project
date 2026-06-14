import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_assets.dart';

class RightParkingColumn extends StatelessWidget {
  final int rows;
  final int targetIndex;
  final double topInset;
  final double rowH;
  final double carW;
  final double carH;
  final double hLineH;

  const RightParkingColumn({
    super.key,
    required this.rows,
    required this.targetIndex,
    required this.topInset,
    required this.rowH,
    required this.carW,
    required this.carH,
    required this.hLineH,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < rows; i++) ...[

          // Parked white car — every row except the empty target slot
          if (i != targetIndex)
            Positioned(
              top: topInset + i * rowH + (rowH - carH) / 2,
              right: 0,
              width: carW,
              height: carH,
              child: Image.asset(AppAssets.whiteCar, fit: BoxFit.contain),
            ),

          // Empty slot marker — always visible; green car parks on top of it
          if (i == targetIndex)
            Positioned(
              top: topInset + targetIndex * rowH + (rowH - hLineH) / 2,
              left: 0,
              right: 0,
              height: hLineH * 3.5,
              child: SvgPicture.asset(
                AppAssets.vectorPos,
                fit: BoxFit.fill,
                alignment: Alignment.centerRight,
              ),
            ),

          // Horizontal divider (except after last row)
          if (i < rows - 1)
            Positioned(
              top: topInset + (i + 1) * rowH - hLineH / 2,
              left: 0,
              right: 0,
              height: hLineH,
              child: SvgPicture.asset(
                AppAssets.hLine,
                fit: BoxFit.fill,
                alignment: Alignment.centerRight,
              ),
            ),
        ],
      ],
    );
  }
}