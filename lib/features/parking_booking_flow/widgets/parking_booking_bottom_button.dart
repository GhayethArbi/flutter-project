import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class ParkingBookingBottomButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final VoidCallback onPressed;

  const ParkingBookingBottomButton({
    super.key,
    required this.label,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Container(
      padding: EdgeInsets.fromLTRB(
        rs.adaptive(mobile: 20, tablet: 28, desktop: 36),
        12,
        rs.adaptive(mobile: 20, tablet: 28, desktop: 36),
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: rs.adaptive(mobile: 48, tablet: 52, desktop: 56),
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB7F000),
            disabledBackgroundColor: Colors.white,
            foregroundColor: Colors.black,
            disabledForegroundColor: Colors.black38,
            elevation: 0,
            side: BorderSide(
              color: isEnabled
                  ? const Color(0xFFB7F000)
                  : const Color(0xFFDDE7A5),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}