import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class AnnouncementSuccessScreen extends StatelessWidget {
  const AnnouncementSuccessScreen({super.key, required this.onFinish});

  final VoidCallback onFinish;
  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final maxWidth = rs.adaptive(mobile: rs.w, tablet: 520, desktop: 560);

    final horizontalPadding = rs.adaptive(mobile: 28, tablet: 40, desktop: 48);

    final circleSize = rs.adaptive(mobile: 110, tablet: 130, desktop: 140);

    final iconSize = rs.adaptive(mobile: 46, tablet: 56, desktop: 60);

    final titleSize = rs.adaptive(mobile: 20, tablet: 24, desktop: 26);

    final descSize = rs.adaptive(mobile: 16, tablet: 18, desktop: 18);

    final buttonHeight = rs.adaptive(mobile: 48, tablet: 52, desktop: 54);

    final buttonWidth = rs.adaptive(
      mobile: double.infinity,
      tablet: 320,
      desktop: 340,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFFFBE),
                      border: Border.all(
                        color: const Color(0xFFB7F000),
                        width: rs.adaptive(
                          mobile: 2,
                          tablet: 2.4,
                          desktop: 2.6,
                        ),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: iconSize,
                      color: const Color(0xFFB7F000),
                    ),
                  ),

                  SizedBox(
                    height: rs.adaptive(mobile: 54, tablet: 62, desktop: 68),
                  ),

                  Text(
                    AppStrings.annoncePubliee,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111111),
                    ),
                  ),

                  SizedBox(
                    height: rs.adaptive(mobile: 22, tablet: 26, desktop: 28),
                  ),

                  Text(
                    AppStrings.votreEspaceEstDesormaisVisiblePar,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: descSize,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF555555),
                    ),
                  ),

                  const Spacer(flex: 3),

                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        onFinish();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB7F000),
                        foregroundColor: const Color(0xFF111111),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(buttonHeight / 2),
                        ),
                      ),
                      child: Text(AppStrings.retourALaccueil,
                        style: TextStyle(
                          fontSize: rs.adaptive(
                            mobile: 16,
                            tablet: 17,
                            desktop: 18,
                          ),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: rs.adaptive(mobile: 36, tablet: 44, desktop: 52),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
