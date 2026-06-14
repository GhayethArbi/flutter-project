import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/forgot_password_cubit.dart';
import '../cubit/forgot_password_state.dart';
import 'forgot_password_button.dart';
import 'forgot_password_input.dart';
import 'otp_code_field.dart';
import 'success_badge.dart';

class ForgotPasswordContent extends StatelessWidget {
  const ForgotPasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ForgotPasswordCubit>().state;

    switch (state.step) {
      case ForgotPasswordStep.identifier:
        return const _IdentifierStep();

      case ForgotPasswordStep.verifyCode:
        return const _VerifyCodeStep();

      case ForgotPasswordStep.newPassword:
        return const _NewPasswordStep();

      case ForgotPasswordStep.resetSuccess:
        return const _SuccessStep();
    }
  }
}

class _IdentifierStep extends StatelessWidget {
  const _IdentifierStep();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final cubit = context.read<ForgotPasswordCubit>();
    final state = context.watch<ForgotPasswordCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(text: 'Mot de passe oublié'),

        SizedBox(height: rs.adaptive(mobile: 30, tablet: 36, desktop: 42)),

        _Description(
          text:
              'Saisissez votre e-mail ou numéro de téléphone\npour réinitialiser le mot de passe',
        ),

        SizedBox(height: rs.adaptive(mobile: 28, tablet: 34, desktop: 40)),

        ForgotPasswordInput(
          hint: 'Email ou Numéro de téléphone',
          onChanged: cubit.identifierChanged,
          errorText: state.identifierError,
        ),

        SizedBox(height: rs.adaptive(mobile: 42, tablet: 48, desktop: 54)),

        ForgotPasswordButton(
          text: 'Continuer',
          isEnabled: state.canContinue,
          isLoading: state.status == ForgotPasswordStatus.loading,
          onPressed: cubit.continuePressed,
        ),
      ],
    );
  }
}

class _VerifyCodeStep extends StatelessWidget {
  const _VerifyCodeStep();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final cubit = context.read<ForgotPasswordCubit>();
    final state = context.watch<ForgotPasswordCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(text: 'Vérifiez votre téléphone'),

        SizedBox(height: rs.adaptive(mobile: 30, tablet: 36, desktop: 42)),

        _Description(
          text:
              'Nous avons envoyé un lien de réinitialisation à\n23*****3.\nSaisissez le code à 6 chiffres indiqué dans le\nmessage.',
        ),

        SizedBox(height: rs.adaptive(mobile: 28, tablet: 34, desktop: 40)),

        OtpCodeField(
          length: 6,
          onChanged: cubit.codeChanged,
        ),

        SizedBox(height: rs.adaptive(mobile: 42, tablet: 48, desktop: 54)),

        ForgotPasswordButton(
          text: 'Vérifier le code',
          isEnabled: state.canContinue,
          isLoading: state.status == ForgotPasswordStatus.loading,
          onPressed: cubit.continuePressed,
        ),

        SizedBox(height: rs.adaptive(mobile: 18, tablet: 22, desktop: 26)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vous n’avez pas encore reçu le code ? ',
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
                color: const Color(0xFF555555),
              ),
            ),
            GestureDetector(
              onTap: cubit.resendCode,
              child: Text(
                'Renvoyer le code',
                style: TextStyle(
                  fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  color: const Color(0xFF222222),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NewPasswordStep extends StatelessWidget {
  const _NewPasswordStep();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final cubit = context.read<ForgotPasswordCubit>();
    final state = context.watch<ForgotPasswordCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(text: 'Créer un nouveau mot de passe'),

        SizedBox(height: rs.adaptive(mobile: 30, tablet: 36, desktop: 42)),

        _Description(
          text:
              'Pour des raisons de sécurité, veuillez noter un mot\nde passe peut varier',
        ),

        SizedBox(height: rs.adaptive(mobile: 28, tablet: 34, desktop: 40)),

        ForgotPasswordInput(
          hint: 'Entrer un mot de passe',
          obscureText: true,
          onChanged: cubit.passwordChanged,
          errorText: state.passwordError,
        ),

        SizedBox(height: rs.adaptive(mobile: 14, tablet: 16, desktop: 18)),

        ForgotPasswordInput(
          hint: 'Confirmer le mot de passe',
          obscureText: true,
          onChanged: cubit.confirmPasswordChanged,
          errorText: state.confirmPasswordError,
        ),

        SizedBox(height: rs.adaptive(mobile: 42, tablet: 48, desktop: 54)),

        ForgotPasswordButton(
          text: 'Confirmer',
          isEnabled: state.canContinue,
          isLoading: state.status == ForgotPasswordStatus.loading,
          onPressed: cubit.continuePressed,
        ),
      ],
    );
  }
}

class _SuccessStep extends StatelessWidget {
  const _SuccessStep();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Expanded(
      child: Column(
        children: [
          const Spacer(flex: 2),

          const SuccessBadge(),

          SizedBox(height: rs.adaptive(mobile: 54, tablet: 62, desktop: 68)),

          Text(
            'Mot de passe réinitialisé !',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: rs.adaptive(mobile: 20, tablet: 24, desktop: 26),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111111),
            ),
          ),

          SizedBox(height: rs.adaptive(mobile: 22, tablet: 26, desktop: 28)),

          Text(
            'Votre mot de passe a été modifié\n'
            'avec succès. Vous pouvez maintenant\n'
            'vous connecter',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: rs.adaptive(mobile: 16, tablet: 18, desktop: 18),
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF555555),
            ),
          ),

          const Spacer(flex: 3),

          ForgotPasswordButton(
            text: 'Se connecter',
            isEnabled: true,
            isLoading: false,
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          SizedBox(height: rs.adaptive(mobile: 36, tablet: 44, desktop: 52)),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String text;

  const _Title({required this.text});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Text(
      text,
      style: TextStyle(
        fontSize: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
        fontWeight: FontWeight.w800,
        color: const Color(0xFF222222),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String text;

  const _Description({required this.text});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Text(
      text,
      style: TextStyle(
        fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
        height: 1.45,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF555555),
      ),
    );
  }
}