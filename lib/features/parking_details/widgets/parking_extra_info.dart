import 'package:flutter/material.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ParkingExtraInfo extends StatelessWidget {
  const ParkingExtraInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Paiement sécurisé
        Row(
          children: [
            Icon(Icons.lock_outline, size: 18, color: Colors.black87),
            SizedBox(width: 8),
            Text(
              AppStrings.paiementSecuriseViaLApplication,
              style: TextStyle(fontSize: 13.5, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Réservation 100% digitale
        Row(
          children: [
            Icon(Icons.phone_android_outlined, size: 18, color: Colors.black87),
            SizedBox(width: 8),
            Text(
              AppStrings.reservation100Digitale,
              style: TextStyle(fontSize: 13.5, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Option carte d'accès card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.optionCarteDAcces,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppStrings.entrezEtSortezDeVotreParking,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
              Text(
                AppStrings.text5dtmois,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
