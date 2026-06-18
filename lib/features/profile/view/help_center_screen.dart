import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/profile/cubit/help_center_cubit.dart';
import 'package:tunipark/features/profile/profile_shared_widgets.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HelpCenterCubit(),
      child: const _HelpCenterView(),
    );
  }
}

class _HelpCenterView extends StatefulWidget {
  const _HelpCenterView();

  @override
  State<_HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<_HelpCenterView> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<HelpCenterCubit, HelpCenterState>(
      builder: (context, state) {
        final cubit = context.read<HelpCenterCubit>();

        return Scaffold(
          backgroundColor: AppTokens.background,
          body: SafeArea(
            child: Column(
              children: [
                // ── Header with embedded search ──────────────────────────
                AppScreenHeader(
                  title: "FAQ & Centre d'aide",
                  bottom: _SearchBar(
                    controller: _searchCtrl,
                    onChanged: cubit.updateSearch,
                    onClear: () {
                      _searchCtrl.clear();
                      cubit.clearSearch();
                    },
                  ),
                ),

                // ── Body ─────────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(
                      rs.adaptive(mobile: 20, tablet: 28),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: rs.adaptive(
                              mobile: double.infinity, tablet: 640),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Contact cards (hidden during search)
                            if (!state.hasSearch) ...[
                              const AppSectionLabel(label: 'Nous contacter'),
                              _ContactGrid(isTablet: rs.isTablet),
                              const SizedBox(height: 4),
                            ],

                            // FAQ section
                            AppSectionLabel(
                              label: state.hasSearch
                                  ? 'Résultats (${state.filteredFaqs.length})'
                                  : 'Questions fréquentes',
                            ),

                            if (state.filteredFaqs.isEmpty)
                              _EmptySearch()
                            else
                              AppMenuCard(
                                children: List.generate(
                                  state.filteredFaqs.length,
                                  (i) {
                                    final faq = state.filteredFaqs[i];
                                    return AppAccordionRow(
                                      title: faq.question,
                                      content: faq.answer,
                                      isExpanded: state.expandedIndex == i,
                                      isLast:
                                          i == state.filteredFaqs.length - 1,
                                      onTap: () => cubit.toggleFaq(i),
                                    );
                                  },
                                ),
                              ),

                            // More options (hidden during search)
                            if (!state.hasSearch) ...[
                              const AppSectionLabel(label: 'Autre chose ?'),
                              AppMenuCard(
                                children: [
                                  AppMenuRow(
                                    icon: Icons.bug_report_outlined,
                                    label: 'Signaler un problème',
                                    isLast: false,
                                    onTap: () =>
                                        _showReportSheet(context),
                                  ),
                                  AppMenuRow(
                                    icon: Icons.star_outline,
                                    label: "Évaluer l'application",
                                    isLast: false,
                                    onTap: () {},
                                  ),
                                  AppMenuRow(
                                    icon: Icons.share_outlined,
                                    label: 'Partager Tunipark',
                                    isLast: true,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
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

  void _showReportSheet(BuildContext context) {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTokens.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppStrings.signalerUnProbleme,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              maxLines: 4,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Décrivez votre problème ici...',
                hintStyle:
                    const TextStyle(fontSize: 14, color: Colors.black38),
                filled: true,
                fillColor: AppTokens.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
            AppPrimaryButton(
              label: 'Envoyer',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Search bar (embedded in header)
// ─────────────────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTokens.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black.withOpacity(0.08),
          width: 0.5,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14, color: AppTokens.textPrimary),
        decoration: InputDecoration(
          hintText: 'Rechercher une question...',
          hintStyle:
              const TextStyle(fontSize: 14, color: AppTokens.textHint),
          prefixIcon:
              const Icon(Icons.search, size: 20, color: Colors.black38),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18, color: Colors.black38),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Contact grid (2×2)
// ─────────────────────────────────────────────────────────────────────────────

class _ContactGrid extends StatelessWidget {
  const _ContactGrid({required this.isTablet});

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _ContactCardData(
        icon: Icons.chat_bubble_outline,
        label: 'Chat en direct',
        sublabel: 'Réponse en 5 min',
        color: AppTokens.lime,
        onTap: () {},
      ),
      _ContactCardData(
        icon: Icons.email_outlined,
        label: 'E-mail',
        sublabel: 'support@tunipark.tn',
        color: AppTokens.limeLight,
        onTap: () {},
      ),
      _ContactCardData(
        icon: Icons.phone_outlined,
        label: 'Téléphone',
        sublabel: '+216 71 000 000',
        color: AppTokens.background,
        onTap: () {},
      ),
      _ContactCardData(
        icon: Icons.access_time_outlined,
        label: 'Disponibilité',
        sublabel: 'Lun–Sam 8h–20h',
        color: AppTokens.background,
        onTap: null,
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: isTablet ? 1.6 : 1.4,
      padding: const EdgeInsets.only(bottom: 20),
      children: cards.map((d) => _ContactCard(data: d)).toList(),
    );
  }
}

class _ContactCardData {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;
  final VoidCallback? onTap;

  const _ContactCardData({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.onTap,
  });
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.data});

  final _ContactCardData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: data.color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black.withOpacity(0.06),
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data.icon, size: 22, color: AppTokens.textPrimary),
            const SizedBox(height: 8),
            Text(
              data.label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              data.sublabel,
              style: const TextStyle(
                fontSize: 11,
                color: AppTokens.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty search state
// ─────────────────────────────────────────────────────────────────────────────

class _EmptySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 40, color: Colors.black26),
            SizedBox(height: 12),
            Text(AppStrings.aucunResultatTrouve,
              style: TextStyle(fontSize: 14, color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}