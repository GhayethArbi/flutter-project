import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/signup/widgets/signup_text_field.dart';
import 'package:tunipark/features/signup/cubit/signup_cubit.dart';
import 'package:tunipark/features/signup/cubit/signup_state.dart';
import 'package:tunipark/features/signup/widgets/signup_button.dart';
import 'package:tunipark/features/signup/widgets/signup_header.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

class SignUpStep2 extends StatefulWidget {
  const SignUpStep2({super.key});

  @override
  State<SignUpStep2> createState() => _SignUpStep2State();
}

class _SignUpStep2State extends State<SignUpStep2> {
  final _passwordNode        = FocusNode();
  final _confirmPasswordNode = FocusNode();

  @override
  void dispose() {
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    final state = context.watch<SignUpCubit>().state;
    final theme = Theme.of(context);
    final rs    = context.rs;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: rs.clampSize(0.07, 22, 36)),
          child: Column(
            children: [
              SizedBox(height: rs.clampSize(0.10, 32, 56)),
              const SignUpHeader(),
              SizedBox(height: rs.clampSize(0.08, 28, 44)),

              SignUpTextField(
                hint: 'Mot de passe',
                errorText: state.passwordError,
                obscureText: !state.passwordVisible,
                focusNode: _passwordNode,
                textInputAction: TextInputAction.next,
                onChanged: cubit.passwordChanged,
                onSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_confirmPasswordNode),
                suffix: IconButton(
                  icon: Icon(
                    state.passwordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: rs.clampSize(0.05, 18, 22),
                  ),
                  onPressed: cubit.togglePasswordVisibility,
                ),
              ),

              SizedBox(height: rs.clampSize(0.035, 12, 18)),

              SignUpTextField(
                hint: 'Valider mot de passe',
                errorText: state.confirmPasswordError,
                obscureText: !state.confirmPasswordVisible,
                focusNode: _confirmPasswordNode,
                textInputAction: TextInputAction.done,
                onChanged: cubit.confirmPasswordChanged,
                onSubmitted: (_) {
                  _confirmPasswordNode.unfocus();
                  cubit.submit();
                },
                suffix: IconButton(
                  icon: Icon(
                    state.confirmPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: rs.clampSize(0.05, 18, 22),
                  ),
                  onPressed: cubit.toggleConfirmPasswordVisibility,
                ),
              ),

              if (state.errorMessage != null) ...[
                SizedBox(height: rs.clampSize(0.04, 14, 20)),
                Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: rs.clampSize(0.035, 13, 15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],

              SizedBox(height: rs.clampSize(0.09, 36, 56)),

              SignUpButton(
                label: AppStrings2.confirmer,
                isLoading: state.status == SignUpStatus.loading,
                onTap: cubit.submit,
              ),

              SizedBox(height: rs.clampSize(0.07, 24, 36)),

              GestureDetector(
                onTap: cubit.goBack,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: AppColors.colorBtn,
                      size: rs.clampSize(0.05, 18, 22),
                    ),
                    const SizedBox(width: 6),
                    Text(AppStrings.retour,
                      style: TextStyle(
                        color: AppColors.colorBtn,
                        fontSize: rs.clampSize(0.045, 16, 20),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: rs.clampSize(0.05, 18, 28)),
            ],
          ),
        ),
      ),
    );
  }
}