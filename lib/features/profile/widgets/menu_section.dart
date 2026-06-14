
import 'package:flutter/material.dart';
import 'package:tunipark/features/profile/widgets/menu_item.dart';

class MenuSection extends StatelessWidget {
  final List<MenuItem> items;
  const MenuSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 0.5),
        ),
        child: Column(children: items),
      ),
    );
  }
}
