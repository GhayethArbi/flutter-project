import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class AnnouncementAddressField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const AnnouncementAddressField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final radius = rs.adaptive(mobile: 12, tablet: 14, desktop: 16);
    final verticalPadding = rs.adaptive(mobile: 12, tablet: 13, desktop: 14);
    final fontSize = rs.adaptive(mobile: 14, tablet: 15, desktop: 15);
    final iconSize = rs.adaptive(mobile: 20, tablet: 22, desktop: 22);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: fontSize,
        color: const Color(0xFF2A2A2A),
      ),
      decoration: InputDecoration(
        hintText: 'Saisissez votre adresse',
        hintStyle: TextStyle(
          fontSize: fontSize,
          color: const Color(0xFF8A8A8A),
        ),

        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
          ),
          child: Icon(
            Icons.search,
            size: iconSize,
            color: const Color(0xFF6B6B6B),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Color(0xFFD6EA74),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Color(0xFFB7F000),
            width: 1.4,
          ),
        ),
      ),
    );
  }
}