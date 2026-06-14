import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

import '../../../core/theme/app_assets.dart';

class AnimatedParkingCar extends StatelessWidget {
  final AnimationController controller;
  final double carW;
  final double carH;

  // Keyframe positions
  final Offset p0;
  final Offset p1;
  final Offset p2;
  final Offset p3;

  // Keyframe angles (radians)
  final double a0;
  final double a1;
  final double a2;
  final double a3;

  const AnimatedParkingCar({
    super.key,
    required this.controller,
    required this.carW,
    required this.carH,
    required this.p0,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.a0,
    required this.a1,
    required this.a2,
    required this.a3,
  });

  @override
  Widget build(BuildContext context) {
    final t = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOutCubic,
    );

    return AnimatedBuilder(
      animation: t,
      builder: (context, _) {
        final v = t.value;

        // Segments:
        // 0.00 – 0.60 : drive down lane   (p0 → p1)
        // 0.60 – 0.86 : turn + enter slot (p1 → p2)
        // 0.86 – 1.00 : final settle      (p2 → p3)
        final Offset pos;
        final double ang;

        if (v < 0.60) {
          final u = v / 0.60;
          pos = _lerp(p0, p1, u);
          ang = lerpDouble(a0, a1, u)!;
        } else if (v < 0.86) {
          final u = (v - 0.60) / 0.26;
          pos = _lerp(p1, p2, u);
          ang = lerpDouble(a1, a2, u)!;
        } else {
          final u = (v - 0.86) / 0.14;
          pos = _lerp(p2, p3, u);
          ang = lerpDouble(a2, a3, u)!;
        }

        return Positioned(
          left: pos.dx - carH / 2,
          top: pos.dy - carW / 2,
          child: Transform.rotate(
            angle: ang,
            alignment: Alignment.center,
            child: SizedBox(
              width: carH,
              height: carW,
              child: Image.asset(AppAssets.greenCar, fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  Offset _lerp(Offset a, Offset b, double t) => Offset(
        lerpDouble(a.dx, b.dx, t)!,
        lerpDouble(a.dy, b.dy, t)!,
      );
}