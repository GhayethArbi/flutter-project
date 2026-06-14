import 'package:flutter/material.dart';
import 'package:tunipark/features/parking_details/widgets/features_item.dart';
import 'package:tunipark/features/parking_details/widgets/trustpilot_item.dart';

class FeaturesGrid extends StatelessWidget {
  final dynamic rs;
  const FeaturesGrid({required this.rs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(rs.adaptive(mobile: 14.0, tablet: 16.0, desktop: 18.0)),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              FeatureItem(icon: Icons.shield_outlined, label: 'Secure private\nparking'),
              const SizedBox(width: 12),
              FeatureItem(icon: Icons.lock_open_outlined, label: 'No\ncommitment'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeatureItem(icon: Icons.local_parking, label: 'Your\ndedicated\nspace'),
              const SizedBox(width: 12),
              TrustpilotItem(),
            ],
          ),
        ],
      ),
    );
  }
}
