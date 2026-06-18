
import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/features/security/cubit/change_password_cubit.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

class PasswordChecklist extends StatelessWidget {
  const PasswordChecklist({required this.state});

  final ChangePasswordState state;

  @override
  Widget build(BuildContext context) {
    final checks = [
      (label: AppStrings2.text8caracteresminimum, met: state.hasMinLength),
      (label: AppStrings2.uneLettreMajuscule, met: state.hasUppercase),
      (label: AppStrings2.unChiffre, met: state.hasDigit),
      (label: 'Un caractère spécial (!@#\$...)', met: state.hasSpecial),
    ];

    return Column(
      children: checks.map((c) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Icon(
                c.met
                    ? Icons.check_circle_outline
                    : Icons.radio_button_unchecked,
                size: 14,
                color: c.met ? AppTokens.limeDark : Colors.black26,
              ),
              const SizedBox(width: 6),
              Text(
                c.label,
                style: TextStyle(
                  fontSize: 12,
                  color: c.met ? AppTokens.limeDark : Colors.black38,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
