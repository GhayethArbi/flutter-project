import 'package:flutter/material.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final rs = context.rs;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous n'avez pas de compte ? ",
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
          child: Text(
            'Créer un compte',
            style: TextStyle(
              color: AppColors.colorBtn,
              fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}