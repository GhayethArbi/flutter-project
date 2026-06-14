import 'package:flutter/material.dart';

class TrustpilotItem extends StatelessWidget {
  const TrustpilotItem();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trustpilot', style: TextStyle(fontSize: 13, color: Color(0xFF173B6C))),
          const SizedBox(height: 4),
          Row(
            children: List.generate(5, (i) {
              return Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: i < 4 ? const Color(0xFF00B67A) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 12),
              );
            }),
          ),
        ],
      ),
    );
  }
}
