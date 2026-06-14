import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/personal_information/cubit/personal_info_cubit.dart';
import 'package:tunipark/features/personal_information/widgets/avatar_section.dart';
import 'package:tunipark/features/personal_information/widgets/info_row.dart';
import 'package:tunipark/features/personal_information/widgets/sheets/edit_email_sheet.dart';
import 'package:tunipark/features/personal_information/widgets/sheets/edit_name_sheet.dart';
import 'package:tunipark/features/personal_information/widgets/sheets/edit_phone_sheet.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';


/// Scrollable content of the Personal Information screen.
///
/// Receives [state] from the parent [BlocBuilder] — no Bloc reads here,
/// which makes each section trivial to test or preview in isolation.
class PersonalInfoBody extends StatelessWidget {
  const PersonalInfoBody({super.key, required this.state});

  final PersonalInfoState state;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final cubit = context.read<PersonalInfoCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.all(rs.adaptive(mobile: 20, tablet: 32)),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: rs.adaptive(mobile: double.infinity, tablet: 560),
          ),
          child: Column(
            children: [
              AvatarSection(state: state),
              SizedBox(height: rs.adaptive(mobile: 28, tablet: 36)),

              // ── Identity ────────────────────────────────────────────
              const AppSectionLabel(label: 'Identité'),
              AppMenuCard(
                children: [
                  InfoRow(
                    icon: Icons.person_outline,
                    label: 'Prénom',
                    value: state.firstName,
                    isLast: false,
                    onTap: () => EditNameSheet.show(
                      context,
                      cubit: cubit,
                      initialFirst: state.firstName,
                      initialLast: state.lastName,
                    ),
                  ),
                  InfoRow(
                    icon: Icons.badge_outlined,
                    label: 'Nom',
                    value: state.lastName,
                    isLast: true,
                    onTap: () => EditNameSheet.show(
                      context,
                      cubit: cubit,
                      initialFirst: state.firstName,
                      initialLast: state.lastName,
                    ),
                  ),
                ],
              ),

              // ── Contact ─────────────────────────────────────────────
              const AppSectionLabel(label: 'Contact'),
              AppMenuCard(
                children: [
                  InfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Téléphone',
                    value: state.phone,
                    isLast: false,
                    onTap: () => EditPhoneSheet.show(
                      context,
                      cubit: cubit,
                      initialPhone: state.phone,
                    ),
                  ),
                  InfoRow(
                    icon: Icons.email_outlined,
                    label: 'Adresse e-mail',
                    value: state.email,
                    isLast: true,
                    onTap: () => EditEmailSheet.show(
                      context,
                      cubit: cubit,
                      initialEmail: state.email,
                    ),
                  ),
                ],
              ),

              const AppSectionLabel(label: 'Compte'),
              AppMenuCard(
                children: [
                  InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Membre depuis',
                    value: 'Janvier 2024',
                    isLast: false,
                    isEditable: false,
                  ),
                  InfoRow(
                    icon: Icons.verified_outlined,
                    label: 'Statut',
                    value: 'Vérifié',
                    isLast: true,
                    isEditable: false,
                    valueColor: AppTokens.limeDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}