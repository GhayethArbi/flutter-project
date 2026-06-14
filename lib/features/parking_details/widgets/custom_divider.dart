import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Divider(color: Colors.grey.shade200, thickness: 1),
    );
  }
}
