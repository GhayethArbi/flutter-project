import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/di/service_locator.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/announcement/view/announcement_flow_screen.dart';
import 'package:tunipark/features/main_navigation/cubit/main_nav_cubit.dart';
import 'package:tunipark/features/main_navigation/cubit/main_nav_state.dart';
import 'package:tunipark/features/my_lots/view/edit_announcement_flow_screen.dart';
import 'package:tunipark/features/my_lots/widgets/my_lot_empty_state.dart';

import '../cubit/my_lots_cubit.dart';
import '../cubit/my_lots_state.dart';
import '../models/my_lot_model.dart';
import '../services/my_lots_service.dart';
import '../widgets/my_lot_card.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class MyLotsScreen extends StatelessWidget {
  const MyLotsScreen({super.key, required this.sl});
  final ServiceLocator sl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MyLotsCubit(myLotsService: MyLotsService(dio: sl.dio))..loadLots(),
      child: _MyLotsBody(sl: sl),
    );
  }
}

// ── MY_LOTS_TAB_INDEX must match your pages list index ─────────────────────
const int _kMyLotsTabIndex = 4;

class _MyLotsBody extends StatefulWidget {
  const _MyLotsBody({required this.sl});
  final ServiceLocator sl;

  @override
  State<_MyLotsBody> createState() => _MyLotsBodyState();
}

class _MyLotsBodyState extends State<_MyLotsBody> {
  // Track the last known tab so we only refresh on *entering* this tab
  int _lastTabIndex = -1;

  void _goToAddNew() {
    final mainNavCubit = context.read<MainNavCubit>();

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: mainNavCubit,
              child: AnnouncementFlowScreen(sl: widget.sl),
            ),
          ),
        )
        .then((_) => context.read<MyLotsCubit>().refresh());
  }

  void _goToEdit(MyLotModel lot) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => EditAnnouncementFlowScreen(sl: widget.sl, lot: lot),
          ),
        )
        .then((_) => context.read<MyLotsCubit>().refresh());
  }

  Future<void> _confirmArchive(MyLotModel lot) async {
    final cubit = context.read<MyLotsCubit>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(AppStrings.archiverCeParking),
        content: Text(
          'Le parking « ${lot.title} » sera désactivé et ne sera plus visible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppStrings.annuler),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Archiver',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await MyLotsService(dio: widget.sl.dio).archiveLot(lot.id);
        cubit.removeLot(lot.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.parkingArchiveAvecSucces)),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceFirst('Exception: ', '')),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    // ── Listen to tab changes; refresh when this tab becomes active ─────
    return BlocListener<MainNavCubit, MainNavState>(
      listener: (context, navState) {
        final current = navState.currentIndex;
        if (current == _kMyLotsTabIndex && _lastTabIndex != _kMyLotsTabIndex) {
          context.read<MyLotsCubit>().refresh();
        }
        _lastTabIndex = current;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: rs.adaptive(mobile: rs.w, tablet: 700, desktop: 850),
              ),
              child: BlocBuilder<MyLotsCubit, MyLotsState>(
                builder: (context, state) {
                  // ── Loading ────────────────────────────────────────
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorBtn,
                      ),
                    );
                  }

                  // ── Error ──────────────────────────────────────────
                  if (state.status == MyLotsStatus.failure) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 48,
                              color: AppColors.danger,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              state.errorMessage ?? 'Une erreur est survenue',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<MyLotsCubit>().loadLots(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.colorBtn,
                                foregroundColor: AppColors.textPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(AppStrings.reessayer),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // ── Empty ──────────────────────────────────────────
                  if (state.isEmpty) {
                    return MyLotsEmptyState(onAddPressed: _goToAddNew);
                  }

                  // ── Lots list with stats header ────────────────────
                  return CustomScrollView(
                    slivers: [
                      // ── Page title + add button ────────────────────
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            rs.adaptive(mobile: 16, tablet: 24),
                            rs.adaptive(mobile: 20, tablet: 24),
                            rs.adaptive(mobile: 16, tablet: 24),
                            rs.adaptive(mobile: 4, tablet: 8),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Mes annonces',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: _goToAddNew,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.colorBtn,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add_rounded,
                                        size: 18,
                                        color: AppColors.textPrimary,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Ajouter',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ── Statistics banner ──────────────────────────
                      SliverToBoxAdapter(
                        child: _StatsBanner(lots: state.lots, rs: rs),
                      ),

                      // ── Lot cards ──────────────────────────────────
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: rs.adaptive(mobile: 16, tablet: 24),
                          vertical: 12,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((ctx, i) {
                            final lot = state.lots[i];
                            return MyLotCard(
                              lot: lot,
                              onEdit: () => _goToEdit(lot),
                              onArchive: () => _confirmArchive(lot),
                            );
                          }, childCount: state.lots.length),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Statistics Banner
// ════════════════════════════════════════════════════════════════════════════

class _StatsBanner extends StatelessWidget {
  const _StatsBanner({required this.lots, required this.rs});

  final List<MyLotModel> lots;
  final dynamic rs; // ResponsiveSize

  @override
  Widget build(BuildContext context) {
    final totalLots = lots.length;
    final activeLots = lots.where((l) => l.status == LotStatus.active).length;
    final totalPlaces = lots.fold<int>(0, (sum, l) => sum + l.maxPlaces);
    final availablePlaces = lots.fold<int>(
      0,
      (sum, l) => sum + l.availablePlaces,
    );

    // Best daily price across all lots
    final prices = lots
        .where((l) => l.pricePerDay != null)
        .map((l) => l.pricePerDay!)
        .toList();
    final avgPrice = prices.isEmpty
        ? null
        : prices.reduce((a, b) => a + b) / prices.length;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        rs.adaptive(mobile: 16.0, tablet: 24.0),
        rs.adaptive(mobile: 12.0, tablet: 16.0),
        rs.adaptive(mobile: 16.0, tablet: 24.0),
        rs.adaptive(mobile: 4.0, tablet: 8.0),
      ),
      child: Column(
        children: [
          // ── Row 1: Total / Active / Inactive ────────────────────────
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.local_parking_rounded,
                  iconBg: AppColors.limeLight,
                  iconColor: AppColors.limeDark,
                  value: '$totalLots',
                  label: 'Annonce${totalLots > 1 ? 's' : ''}',
                ),
              ),
              SizedBox(width: rs.adaptive(mobile: 10.0, tablet: 12.0)),
              Expanded(
                child: _StatCard(
                  icon: Icons.check_circle_outline_rounded,
                  iconBg: AppColors.limeLight,
                  iconColor: AppColors.limeDark,
                  value: '$activeLots',
                  label: 'Active${activeLots > 1 ? 's' : ''}',
                ),
              ),
              SizedBox(width: rs.adaptive(mobile: 10.0, tablet: 12.0)),
              Expanded(
                child: _StatCard(
                  icon: Icons.pause_circle_outline_rounded,
                  iconBg: AppColors.dangerLight,
                  iconColor: AppColors.danger,
                  value: '${totalLots - activeLots}',
                  label: 'Inactive${(totalLots - activeLots) > 1 ? 's' : ''}',
                ),
              ),
            ],
          ),

          SizedBox(height: rs.adaptive(mobile: 10.0, tablet: 12.0)),

          // ── Row 2: Places / Avg price ────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.directions_car_outlined,
                  iconBg: const Color(0xFFEEF2FF),
                  iconColor: const Color(0xFF4F6FD8),
                  value: '$availablePlaces/$totalPlaces',
                  label: 'Places libres',
                ),
              ),
              SizedBox(width: rs.adaptive(mobile: 10.0, tablet: 12.0)),
              Expanded(
                flex: 2,
                child: _StatCard(
                  icon: Icons.payments_outlined,
                  iconBg: const Color(0xFFFFF8E1),
                  iconColor: const Color(0xFFF59E0B),
                  value: avgPrice != null
                      ? '${avgPrice.toStringAsFixed(0)} DT/j'
                      : '—',
                  label: 'Prix moy. / jour',
                  wide: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.value,
    required this.label,
    this.wide = false,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String label;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
