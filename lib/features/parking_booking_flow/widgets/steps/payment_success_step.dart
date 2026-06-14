import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class PaymentSuccessStep extends StatelessWidget {
  const PaymentSuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    debugPrint('💚 PaymentSuccessStep building, hp=${rs.hp(0.08)}');

    return Padding(
      // padding: EdgeInsets.only(top: rs.hp(0.08)),
      padding: const EdgeInsets.only(top: 60),

      child: Column(
        children: [
          Container(
            width: rs.adaptive(mobile: 92, tablet: 104, desktop: 116),
            height: rs.adaptive(mobile: 92, tablet: 104, desktop: 116),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFB7F000), width: 2),
            ),
            child: const Icon(Icons.check, color: Color(0xFFB7F000), size: 40),
          ),
          SizedBox(height: rs.adaptive(mobile: 28, tablet: 32, desktop: 36)),
          Text(
            'Paiement réussi !',
            style: TextStyle(
              fontSize: rs.adaptive(mobile: 22, tablet: 24, desktop: 26),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22)),
          Text(
            'Votre session d’un mois commence dés\naujourd’hui\nUn reçu a été envoyé à votre email',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
