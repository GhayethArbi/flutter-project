import 'package:flutter/material.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class HeroImage extends StatelessWidget {
  final String imageUrl;
  final dynamic rs;
  const HeroImage({required this.imageUrl, required this.rs});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          width: double.infinity,
          height: rs.adaptive(mobile: 260.0, tablet: 300.0, desktop: 340.0),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            height: rs.adaptive(mobile: 260.0, tablet: 300.0, desktop: 340.0),
            color: Colors.grey.shade300,
            child: const Icon(Icons.local_parking, size: 64, color: Colors.grey),
          ),
        ),
        Positioned(
          bottom: 14,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.black87),
                  SizedBox(width: 6),
                  Text(AppStrings.voirLesAutresPhotos,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
