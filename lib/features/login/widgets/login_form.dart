import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/forgot_password/view/forgot_password_screen.dart';
import 'package:tunipark/features/login/cubit/login_cubit.dart';
import 'package:tunipark/features/login/cubit/login_state.dart';
import 'package:tunipark/features/login/widgets/login_button.dart';
import 'package:tunipark/features/login/widgets/login_footer.dart';
import 'package:tunipark/features/login/widgets/login_text_field.dart';
import 'package:tunipark/features/login/widgets/social_svg_button.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode _identifierFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _identifierFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final state = context.watch<LoginCubit>().state;
    final rs = context.rs;

    return Column(
      children: [
        // ── identifier ──────────────────────────────────────────────
        LoginTextField(
          hint: 'Email ou Numéro de téléphone',
          keyboardType: TextInputType.text,
          onChanged: cubit.identifierChanged,
          errorText: state.identifierError,
          focusNode: _identifierFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_passwordFocus),
        ),

        SizedBox(height: rs.adaptive(mobile: 14, tablet: 16, desktop: 18)),

        // ── Password ───────────────────────────────────────────
        LoginTextField(
          hint: 'Mot de passe',
          obscureText: !state.passwordVisible,
          onChanged: cubit.passwordChanged,
          errorText: state.passwordError,
          focusNode: _passwordFocus,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => cubit.submit(),
          suffix: GestureDetector(
            onTap: cubit.togglePasswordVisibility,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
              ),
              child: Icon(
                state.passwordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.colorBtn,
                size: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
              ),
            ),
          ),
        ),

        SizedBox(height: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),

        // ── Forgot password ────────────────────────────────────
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
            ),
            child: Text(AppStrings.motDePasseOublie,
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF555555),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF555555),
              ),
            ),
          ),
        ),

        SizedBox(height: rs.adaptive(mobile: 48, tablet: 56, desktop: 64)),

        // ── Login button ───────────────────────────────────────
        LoginButton(
          isLoading: state.status == LoginStatus.loading,
          isEnabled: state.status != LoginStatus.loading,
          onTap: cubit.submit,
        ),

        SizedBox(height: rs.adaptive(mobile: 32, tablet: 38, desktop: 44)),

        // ── Social login ───────────────────────────────────────
        _SocialLoginSection(),

        SizedBox(height: rs.adaptive(mobile: 32, tablet: 38, desktop: 44)),

        // ── Footer: go to signup ───────────────────────────────
        const LoginFooter(),

        SizedBox(height: rs.adaptive(mobile: 16, tablet: 20, desktop: 24)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SocialLoginSection extends StatelessWidget {
  const _SocialLoginSection();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Column(
      children: [
        // ── Divider row ────────────────────────────────────────
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppColors.colorBtn, thickness: 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: rs.adaptive(mobile: 12, tablet: 16, desktop: 18),
              ),
              child: Text(AppStrings.ou,
                style: TextStyle(
                  fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: AppColors.colorBtn, thickness: 1),
            ),
          ],
        ),

        SizedBox(height: rs.adaptive(mobile: 24, tablet: 28, desktop: 32)),

        // ── Social icons ───────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialSvgButton(
              assetPath: 'assets/icons/fb-icon.svg',
              iconSize: rs.adaptive(mobile: 24, tablet: 26, desktop: 28),
              boxSize: rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
              borderRadius: rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
            ),
            SizedBox(width: rs.adaptive(mobile: 20, tablet: 24, desktop: 28)),
            SocialSvgButton(
              assetPath: 'assets/icons/google-icon.svg',
              iconSize: rs.adaptive(mobile: 24, tablet: 26, desktop: 28),
              boxSize: rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
              borderRadius: rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
            ),
            SizedBox(width: rs.adaptive(mobile: 20, tablet: 24, desktop: 28)),
            SocialSvgButton(
              assetPath: 'assets/icons/apple-icon.svg',
              iconSize: rs.adaptive(mobile: 26, tablet: 28, desktop: 30),
              boxSize: rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
              borderRadius: rs.adaptive(mobile: 12, tablet: 14, desktop: 14),
            ),
          ],
        ),
      ],
    );
  }
}
