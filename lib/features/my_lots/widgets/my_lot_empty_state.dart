import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class MyLotsEmptyState extends StatelessWidget {
  const MyLotsEmptyState({super.key, required this.onAddPressed});
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Illustration ──────────────────────────────────────────
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.limeLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_parking_rounded,
                size: 64,
                color: AppColors.limeDark,
              ),
            ),

            const SizedBox(height: 24),

            // ── Headline ─────────────────────────────────────────────
            Text(AppStrings.vousNAvezAucunParking,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),

            // ── Sub-text ─────────────────────────────────────────────
            Text(AppStrings.devenezPartenaireTuniparkEtCommencezA,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            // ── CTA button ───────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAddPressed,
                icon: const Icon(Icons.add_rounded, size: 20),
                label: Text(AppStrings.publierMonPremierParking,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorBtn,
                  foregroundColor: AppColors.textPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}