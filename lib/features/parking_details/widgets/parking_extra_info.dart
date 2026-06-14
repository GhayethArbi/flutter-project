import 'package:flutter/material.dart';

class ParkingExtraInfo extends StatelessWidget {
  const ParkingExtraInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Paiement sécurisé
        Row(
          children: const [
            Icon(Icons.lock_outline, size: 18, color: Colors.black87),
            SizedBox(width: 8),
            Text(
              "Paiement sécurisé via l'application",
              style: TextStyle(fontSize: 13.5, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Réservation 100% digitale
        Row(
          children: const [
            Icon(Icons.phone_android_outlined, size: 18, color: Colors.black87),
            SizedBox(width: 8),
            Text(
              'Réservation 100% digitale',
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
            children: const [
              Text(
                "Option carte d'accès",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Entrez et sortez de votre parking sans devoir utiliser l'application Tunipark",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '5DT / mois',
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