import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_tokens.dart';


class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({super.key});

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (_, __) => Opacity(
        opacity: _opacity.value,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const _Bone(width: 84, height: 84, radius: 42),
              const SizedBox(height: 12),
              const _Bone(width: 140, height: 18),
              const SizedBox(height: 8),
              const _Bone(width: 180, height: 13),
              const SizedBox(height: 32),
              _SkeletonCard(rows: 2),
              const SizedBox(height: 20),
              _SkeletonCard(rows: 2),
              const SizedBox(height: 20),
              _SkeletonCard(rows: 2),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single rounded rectangle placeholder bone.
class _Bone extends StatelessWidget {
  const _Bone({this.width, required this.height, this.radius = 6});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// A card-shaped group of skeleton rows.
class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.rows});

  final int rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTokens.border, width: 0.5),
      ),
      child: Column(
        children: List.generate(rows, (i) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Row(
                  children: [
                    const _Bone(width: 32, height: 32, radius: 8),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Bone(width: 60, height: 10),
                          SizedBox(height: 6),
                          _Bone(width: 120, height: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (i < rows - 1)
                Padding(
                  padding: const EdgeInsets.only(left: 58),
                  child: Divider(height: 0.5, color: AppTokens.divider),
                ),
            ],
          );
        }),
      ),
    );
  }
}