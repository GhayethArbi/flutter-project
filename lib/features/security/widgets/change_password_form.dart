import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';
import 'package:tunipark/features/security/cubit/change_password_cubit.dart';
import 'package:tunipark/features/security/widgets/password_checklist.dart';
import 'package:tunipark/features/security/widgets/strength_bar.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm();

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.motDePasseModifieAvecSucces),
              backgroundColor: AppTokens.limeDark,
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ChangePasswordCubit>();

        return Scaffold(
          backgroundColor: AppTokens.background,
          body: SafeArea(
            child: Column(
              children: [
                const AppScreenHeader(title: 'Changer le mot de passe'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(
                      rs.adaptive(mobile: 20, tablet: 28),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                              rs.adaptive(mobile: double.infinity, tablet: 520),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Info banner
                              const AppInfoBanner(
                                text:
                                    'Votre nouveau mot de passe doit contenir au moins 8 caractères.',
                              ),
                              const SizedBox(height: 24),

                              // Current password
                              const AppFieldLabel(
                                  label: 'Mot de passe actuel'),
                              AppPasswordField(
                                controller: _currentCtrl,
                                hintText: '••••••••',
                                isVisible: state.showCurrent,
                                onToggleVisibility:
                                    cubit.toggleCurrentVisibility,
                                onChanged: cubit.updateCurrentPassword,
                                textInputAction: TextInputAction.next,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Champ requis'
                                    : null,
                              ),
                              const SizedBox(height: 20),

                              // New password
                              const AppFieldLabel(
                                  label: 'Nouveau mot de passe'),
                              AppPasswordField(
                                controller: _newCtrl,
                                hintText: '••••••••',
                                isVisible: state.showNew,
                                onToggleVisibility: cubit.toggleNewVisibility,
                                onChanged: cubit.updateNewPassword,
                                textInputAction: TextInputAction.next,
                                validator: (v) =>
                                    (v == null || v.length < 8)
                                        ? 'Minimum 8 caractères'
                                        : null,
                              ),

                              // Strength indicator
                              if (state.newPassword.isNotEmpty) ...[
                                const SizedBox(height: 10),
                                StrengthBar(score: state.strengthScore),
                                const SizedBox(height: 8),
                                PasswordChecklist(state: state),
                              ],
                              const SizedBox(height: 20),

                              // Confirm password
                              const AppFieldLabel(
                                  label:
                                      'Confirmer le nouveau mot de passe'),
                              AppPasswordField(
                                controller: _confirmCtrl,
                                hintText: '••••••••',
                                isVisible: state.showConfirm,
                                onToggleVisibility:
                                    cubit.toggleConfirmVisibility,
                                onChanged: cubit.updateConfirmPassword,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _submit(cubit),
                                validator: (v) => v != _newCtrl.text
                                    ? 'Les mots de passe ne correspondent pas'
                                    : null,
                              ),

                              // Error message
                              if (state.errorMessage != null) ...[
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppTokens.dangerLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.error_outline,
                                          size: 16, color: AppTokens.danger),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          state.errorMessage!,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppTokens.danger,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              const SizedBox(height: 36),

                              AppPrimaryButton(
                                label: 'Enregistrer le nouveau mot de passe',
                                isLoading: state.isLoading,
                                onPressed: state.canSubmit
                                    ? () => _submit(cubit)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submit(ChangePasswordCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.submit();
    }
  }
}
