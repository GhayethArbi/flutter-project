import 'package:flutter/material.dart';
import 'package:tunipark/features/history/models/history_item_model.dart';

class HistoryCard extends StatelessWidget {
  final HistoryItemModel item;
  final VoidCallback onParkHere;

  const HistoryCard({
    super.key,
    required this.item,
    required this.onParkHere,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFD5EB63),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.address,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5A5A5A),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5A5A5A),
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Durée : ',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: item.duration),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Paiement : ',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: item.payment),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: onParkHere,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB7F000),
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Stationner ici',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}