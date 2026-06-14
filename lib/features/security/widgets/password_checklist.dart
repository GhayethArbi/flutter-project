
import 'package:flutter/material.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/features/security/cubit/change_password_cubit.dart';

class PasswordChecklist extends StatelessWidget {
  const PasswordChecklist({required this.state});

  final ChangePasswordState state;

  @override
  Widget build(BuildContext context) {
    final checks = [
      (label: '8 caractères minimum', met: state.hasMinLength),
      (label: 'Une lettre majuscule', met: state.hasUppercase),
      (label: 'Un chiffre', met: state.hasDigit),
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
