import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class OtpCodeField extends StatefulWidget {
  final int length;
  final ValueChanged<String> onChanged;

  const OtpCodeField({
    super.key,
    required this.length,
    required this.onChanged,
  });

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _notifyChange() {
    final code = _controllers.map((e) => e.text).join();
    widget.onChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final boxSize = rs.adaptive(
      mobile: 48,
      tablet: 54,
      desktop: 58,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: boxSize,
          height: boxSize,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: TextStyle(
              fontSize: rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: const Color(0xFFEFFFBE),
              contentPadding: EdgeInsets.zero,
              enabledBorder: _border(context),
              focusedBorder: _border(context),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < widget.length - 1) {
                _focusNodes[index + 1].requestFocus();
              }

              if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }

              _notifyChange();
            },
          ),
        );
      }),
    );
  }

  OutlineInputBorder _border(BuildContext context) {
    final rs = context.rs;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        rs.adaptive(mobile: 8, tablet: 10, desktop: 12),
      ),
      borderSide: const BorderSide(
        color: AppColors.colorBtn,
        width: 1.1,
      ),
    );
  }
}