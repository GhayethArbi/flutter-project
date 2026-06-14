import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';
import 'package:tunipark/features/security/cubit/security_cubit.dart';
import 'package:tunipark/features/security/cubit/security_state.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecurityCubit(),
      child: const _SecurityView(),
    );
  }
}

class _SecurityView extends StatelessWidget {
  const _SecurityView();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocConsumer<SecurityCubit, SecurityState>(
      listener: (context, state) {
        if (state.status == SecurityStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appareils déconnectés avec succès'),
              backgroundColor: AppTokens.limeDark,
            ),
          );
        }
        if (state.status == SecurityStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Une erreur est survenue'),
              backgroundColor: AppTokens.danger,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SecurityCubit>();

        return Scaffold(
          backgroundColor: AppTokens.background,
          body: SafeArea(
            child: Column(
              children: [
                const AppScreenHeader(title: 'Sécurité'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(
                      rs.adaptive(mobile: 20, tablet: 28),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: rs.adaptive(mobile: double.infinity, tablet: 560),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Mot de passe ─────────────────────────────
                            const AppSectionLabel(label: 'Mot de passe'),
                            AppMenuCard(
                              children: [
                                AppMenuRow(
                                  icon: Icons.lock_outline,
                                  label: 'Changer le mot de passe',
                                  isLast: true,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.changePasswordSec,
                                  ),
                                ),
                              ],
                            ),

                            // ── Connexion ─────────────────────────────────
                            const AppSectionLabel(label: 'Connexion'),
                            AppMenuCard(
                              children: [
                                AppMenuRow(
                                  icon: Icons.fingerprint,
                                  label: 'Authentification biométrique',
                                  isLast: false,
                                  showChevron: false,
                                  trailing: AppToggle(
                                    value: state.biometricEnabled,
                                    onChanged: (v) =>
                                        cubit.toggleBiometric(value: v),
                                  ),
                                ),
                                AppMenuRow(
                                  icon: Icons.phone_android_outlined,
                                  label: 'Vérification en deux étapes',
                                  isLast: true,
                                  showChevron: false,
                                  trailing: AppToggle(
                                    value: state.twoFactorEnabled,
                                    onChanged: (v) =>
                                        cubit.toggleTwoFactor(value: v),
                                  ),
                                ),
                              ],
                            ),

                            // ── Sessions ──────────────────────────────────
                            const AppSectionLabel(label: 'Sessions actives'),
                            AppMenuCard(
                              children: [
                                AppMenuRow(
                                  icon: Icons.devices_outlined,
                                  label: 'Appareils connectés',
                                  isLast: false,
                                  onTap: () {},
                                ),
                                AppMenuRow(
                                  icon: Icons.logout,
                                  label: 'Déconnecter tous les appareils',
                                  labelColor: AppTokens.danger,
                                  iconColor: AppTokens.danger,
                                  iconBackground: AppTokens.dangerLight,
                                  isLast: true,
                                  onTap: state.isLoading
                                      ? null
                                      : () async {
                                          final confirmed =
                                              await showAppConfirmDialog(
                                            context,
                                            title:
                                                'Déconnecter tous les appareils',
                                            message:
                                                'Vous serez déconnecté de tous vos appareils sauf celui-ci.',
                                            confirmLabel: 'Déconnecter',
                                            isDanger: true,
                                          );
                                          if (confirmed == true &&
                                              context.mounted) {
                                            cubit.disconnectAllDevices();
                                          }
                                        },
                                ),
                              ],
                            ),
                          ],
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
}
