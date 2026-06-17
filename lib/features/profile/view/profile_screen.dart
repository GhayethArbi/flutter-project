import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
import 'package:tunipark/core/storage/dev_session_service.dart';
import 'package:tunipark/features/profile/cubit/profile_cubit.dart';
import 'package:tunipark/features/profile/cubit/profile_state.dart';
import 'package:tunipark/features/profile/view/mode_screen.dart';
import 'package:tunipark/features/profile/widgets/logout_tile.dart';
import 'package:tunipark/features/profile/widgets/menu_item.dart';
import 'package:tunipark/features/profile/widgets/menu_section.dart';
import 'package:tunipark/features/profile/widgets/profile_header.dart';
import 'package:tunipark/features/profile/widgets/section_label.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(
        devSessionService: DevSessionService(),
        authStorageService: AuthStorageService(
          storage: const FlutterSecureStorage(),
        ),
      ),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.signedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
        if (state.status == ProfileStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Déconnexion échouée')),
          );
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      ProfileHeader(state: state),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionLabel(label: 'Compte'),
                              MenuSection(
                                items: [
                                  MenuItem(
                                    icon: Icons.person_outline,
                                    label: 'Informations personnelles',
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.personalInfo),
                                  ),
                                  // MenuItem(
                                  //   icon: Icons.notifications_none_outlined,
                                  //   label: 'Notifications',
                                  //   onTap: () => Navigator.pushNamed(
                                  //     context, AppRoutes.notifications),
                                  // ),
                                  MenuItem(
                                    icon: Icons.directions_car_outlined,
                                    label: 'Mes véhicules',
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.myVehicles),
                                  ),
                                  MenuItem(
                                    icon: Icons.credit_card_outlined,
                                    label: 'Mes paiements',
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.payments),
                                  ),
                                  // MenuItem(
                                  //   icon: Icons.business_center_outlined,
                                  //   label: 'Gérer mes places',
                                  //   onTap: () => Navigator.pushNamed(
                                  //     context, AppRoutes.parkingProfessionals),
                                  // ),
                                  MenuItem(
                                    icon: Icons.shield_outlined,
                                    label: 'Sécurité',
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.security),
                                  ),
                                  MenuItem(
                                    icon: Icons.delete_outline,
                                    label: 'Supprimer le compte',
                                    labelColor: const Color(0xFFE24B4A),
                                    iconColor: const Color(0xFFE24B4A),
                                    iconBackground: const Color(0xFFFFF0F0),
                                    isLast: true,
                                    onTap: () => _showDeleteAccountDialog(context, cubit),
                                  ),
                                ],
                              ),

                              // ── Paramètres de l'app ─────────────────────
                              SectionLabel(label: "Paramètres de l'app"),
                              MenuSection(
                                items: [
                                  MenuItem(
                                    icon: Icons.brightness_2_outlined,
                                    label: 'Mode',
                                    trailing: Text(
                                      state.themeMode == AppThemeMode.day ? 'Jour' : 'Nuit',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<ProfileCubit>(),
                                          child: const ModeScreen(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  MenuItem(
                                    icon: Icons.language_outlined,
                                    label: 'Langue',
                                    trailing: const Text(
                                      'Français',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    isLast: true,
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.language),
                                  ),
                                ],
                              ),

                              // ── Aide & support ───────────────────────────
                              SectionLabel(label: 'Aide & support'),
                              MenuSection(
                                items: [
                                  MenuItem(
                                    icon: Icons.help_outline,
                                    label: "FAQ & Centre d'aide",
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.helpCenter),
                                  ),
                                  MenuItem(
                                    icon: Icons.privacy_tip_outlined,
                                    label: 'Politique de confidentialité',
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.privacyPolicy),
                                  ),
                                  MenuItem(
                                    icon: Icons.description_outlined,
                                    label: "Conditions d'utilisation",
                                    onTap: () => Navigator.pushNamed(
                                      context, AppRoutes.termsOfUse),
                                  ),
                                  MenuItem(
                                    icon: Icons.groups_2_outlined,
                                    label: 'Devenir partenaire',
                                    iconColor: const Color(0xFF3B6D11),
                                    iconBackground: const Color(0xFFF0FFF0),
                                    labelColor: const Color(0xFF3B6D11),
                                    isLast: true,
                                    onTap: () {},
                                  ),
                                ],
                              ),

                              // ── Déconnexion ──────────────────────────────
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: LogoutTile(
                                  isLoading: state.isSigningOut,
                                  onTap: state.isSigningOut ? null : () => cubit.signOut(),
                                ),
                              ),

                              // Version
                              const SizedBox(height: 16),
                              const Center(
                                child: Text(
                                  'Tunipark v1.0.0',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isSigningOut)
                  Container(
                    color: Colors.black.withOpacity(0.25),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, ProfileCubit cubit) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.supprimerLeCompte),
        content: const Text(
          'Cette action est irréversible. Voulez-vous vraiment supprimer votre compte ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.annuler),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // cubit.deleteAccount(); // à implémenter
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Color(0xFFE24B4A)),
            ),
          ),
        ],
      ),
    );
  }
}

