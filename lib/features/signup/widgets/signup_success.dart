import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunipark/core/theme/app_spacing.dart';
import 'package:tunipark/core/theme/app_text_scale.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/core/widgets/app_page_container.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class SignUpSuccess extends StatelessWidget {
  const SignUpSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rs = context.rs;

    final iconSize = rs.clampSize(0.33, 90, 140);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: AppPageContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/success_icon.svg',
              width: iconSize,
              height: iconSize,
            ),
            SizedBox(height: AppSpacing.sectionGap(context)),
            Text(AppStrings.inscriptionReussie,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: AppTextScale.title(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.itemGap(context)),
            Text(AppStrings.votreCompteAEteCreeAvec,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: AppTextScale.subtitle(context),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
