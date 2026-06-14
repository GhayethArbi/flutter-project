import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_assets.dart';
import 'animated_parking_car.dart';
import 'parking_layout.dart';
import 'right_parking_column.dart';

class ParkingScene extends StatefulWidget {
  final VoidCallback? onAnimationComplete;

  const ParkingScene({super.key, this.onAnimationComplete});

  @override
  State<ParkingScene> createState() => _ParkingSceneState();
}

class _ParkingSceneState extends State<ParkingScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const int _rows        = 6;
  static const int _targetRow   = 4; // 1-based
  static const int _targetIndex = _targetRow - 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onAnimationComplete?.call();
        }
      });

    // Small delay so the first frame renders before animation starts
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = ParkingLayout.compute(
          screenW: constraints.maxWidth,
          screenH: constraints.maxHeight,
          rows: _rows,
        );

        final targetCenterY = layout.rowCenterY(_targetIndex);
        final slotCenterX   = layout.parkedCarLeft + layout.carW * 0.5;

        // Animation keyframe positions
        final p0 = Offset(layout.leftLaneW * 0.55, layout.topInset - layout.carH);
        final p1 = Offset(layout.leftLaneW * 0.55, targetCenterY);
        final p2 = Offset(slotCenterX - layout.carW * 0.20, targetCenterY);
        final p3 = Offset(slotCenterX, targetCenterY);

        // 90° clockwise turn
        const a0 = 0.0;
        const a1 = 0.0;
        const a2 = -math.pi / 2;
        const a3 = -math.pi / 2;

        return Stack(
          children: [
            // ── Static parked cars + divider lines ──────────
            Positioned(
              top: 0,
              bottom: 0,
              right: layout.rightPadding + layout.vLineW,
              width: layout.rightColW - layout.rightPadding,
              child: RightParkingColumn(
                rows: _rows,
                targetIndex: _targetIndex,
                topInset: layout.topInset,
                rowH: layout.rowH,
                carW: layout.carW,
                carH: layout.carH,
                hLineH: layout.hLineH,
              ),
            ),

            // ── Vertical lane separator ──────────────────────
            Positioned(
              top: 0,
              bottom: 0,
              right: layout.rightPadding,
              width: layout.vLineW,
              child: SvgPicture.asset(AppAssets.vLine, fit: BoxFit.fill),
            ),

            // ── Animated green car ───────────────────────────
            AnimatedParkingCar(
              controller: _controller,
              carW: layout.carW,
              carH: layout.carH,
              p0: p0, p1: p1, p2: p2, p3: p3,
              a0: a0, a1: a1, a2: a2, a3: a3,
            ),
          ],
        );
      },
    );
  }
}