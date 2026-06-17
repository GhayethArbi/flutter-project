import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/di/service_locator.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/announcement/services/parking_service.dart';
import 'package:tunipark/features/my_lots/cubit/edit_announcement/edit_announcement_cubit.dart';
import 'package:tunipark/features/my_lots/cubit/edit_announcement/edit_announcement_state.dart';
import 'package:tunipark/features/my_lots/models/my_lot_model.dart';
import 'package:tunipark/features/my_lots/services/my_lots_service.dart';
import 'package:tunipark/core/constants/app_strings.dart';


// ─────────────────────────────────────────────────────────────────────────────
//  Edit flow has 4 meaningful steps (type, info, photos+prices, location)
//  We reuse the same visual language as AnnouncementFlowScreen.
// ─────────────────────────────────────────────────────────────────────────────

class EditAnnouncementFlowScreen extends StatelessWidget {
  const EditAnnouncementFlowScreen({
    super.key,
    required this.sl,
    required this.lot,
  });

  final ServiceLocator sl;
  final MyLotModel lot;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditAnnouncementCubit(
        lot: lot,
        myLotsService: MyLotsService(dio: sl.dio),
        parkingService: ParkingService(dio: sl.dio),
      ),
      child: BlocConsumer<EditAnnouncementCubit, EditAnnouncementState>(
        listenWhen: (prev, curr) => curr.status != prev.status,
        listener: (context, state) {
          if (state.status == EditAnnouncementStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.parkingMisAJourAvecSucces),
                backgroundColor: AppColors.limeDark,
              ),
            );
            Navigator.of(context).pop(); // go back to MyLotsScreen
          }
          if (state.status == EditAnnouncementStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Une erreur est survenue'),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: context.rs.adaptive(
                      mobile: context.rs.w,
                      tablet: 700,
                      desktop: 900,
                    ),
                  ),
                  child: _buildStep(context, state),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStep(BuildContext context, EditAnnouncementState state) {
    switch (state.currentStep) {
      case 1:
        return const _EditStepType();
      case 2:
        return const _EditStepInfo();
      case 3:
        return const _EditStepPricing();
      case 4:
        return const _EditStepLocation();
      default:
        return const _EditStepType();
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Shared header for edit steps
// ─────────────────────────────────────────────────────────────────────────────

class _EditHeader extends StatelessWidget {
  const _EditHeader({required this.step, required this.totalSteps});
  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditAnnouncementCubit>();
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (step == 1) {
                  Navigator.of(context).pop();
                } else {
                  cubit.previousStep();
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 20, color: Color(0xFF2F2F2F)),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, size: 20, color: Color(0xFF2F2F2F)),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.limeLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Modification — Étape $step / $totalSteps',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ),
      ],
    );
  }
}

// Bottom actions bar (same as AnnouncementFixedBottomActions)
class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
      child: SafeArea(top: false, child: child),
    );
  }
}

// Primary button reused
class _PrimaryBtn extends StatelessWidget {
  const _PrimaryBtn({required this.label, required this.onPressed, this.enabled = true});
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorBtn,
          foregroundColor: AppColors.textPrimary,
          disabledBackgroundColor: AppColors.border,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Step 1 — Parking type
// ─────────────────────────────────────────────────────────────────────────────

class _EditStepType extends StatelessWidget {
  const _EditStepType();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditAnnouncementCubit>();

    return BlocBuilder<EditAnnouncementCubit, EditAnnouncementState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const _EditHeader(step: 1, totalSteps: 4),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quel type d\'emplacement ?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _TypeCard(
                      icon: Icons.apartment_rounded,
                      title: 'Sous-sol d\'immeuble',
                      subtitle: 'Place dans un parking souterrain',
                      selected: state.parkingType == 'UNDERGROUND',
                      onTap: () => cubit.selectParkingType(
                          _spotTypeFromApi('UNDERGROUND')),
                    ),
                    const SizedBox(height: 16),
                    _TypeCard(
                      icon: Icons.home_rounded,
                      title: 'Garage de maison',
                      subtitle: 'Garage individuel attenant ou séparé',
                      selected: state.parkingType == 'GARAGE',
                      onTap: () =>
                          cubit.selectParkingType(_spotTypeFromApi('GARAGE')),
                    ),
                    const SizedBox(height: 16),
                    _TypeCard(
                      icon: Icons.local_parking_rounded,
                      title: 'Parking extérieur',
                      subtitle: 'Emplacement en plein air ou cour ouverte',
                      selected: state.parkingType == 'OUTDOOR',
                      onTap: () =>
                          cubit.selectParkingType(_spotTypeFromApi('OUTDOOR')),
                    ),
                  ],
                ),
              ),
            ),
            _BottomActions(
              child: _PrimaryBtn(
                label: 'Suivant',
                enabled: state.parkingType != null,
                onPressed: () => cubit.goToStep(2),
              ),
            ),
          ],
        );
      },
    );
  }

  // Inline helper — avoids coupling to internal ParkingSpotType constructors
  dynamic _spotTypeFromApi(String raw) {
    // Reuse your existing enum from core/models/parking_spot_type.dart
    // This matches what AnnouncementStepOneScreen does via
    // context.read<AnnouncementFlowCubit>().selectParkingType(ParkingSpotType.xxx)
    switch (raw) {
      case 'UNDERGROUND':
        return _ParkingSpotTypeHelper.underground;
      case 'GARAGE':
        return _ParkingSpotTypeHelper.garage;
      case 'OUTDOOR':
        return _ParkingSpotTypeHelper.outdoor;
      default:
        return _ParkingSpotTypeHelper.garage;
    }
  }
}

/// Tiny helper so we don't import the enum twice with conflicts.
/// Replace the values with your actual ParkingSpotType enum values.
class _ParkingSpotTypeHelper {
  static final underground = _buildType('UNDERGROUND');
  static final garage = _buildType('GARAGE');
  static final outdoor = _buildType('OUTDOOR');

  // This returns the actual ParkingSpotType — keep in sync with your enum file.
  // If ParkingSpotType is: enum ParkingSpotType { underground, garage, outdoor, covered }
  // replace with: ParkingSpotType.underground etc.
  static dynamic _buildType(String v) {
    // ⚠️ Replace these with your actual enum values:
    // import 'package:tunipark/core/models/parking_spot_type.dart';
    // return ParkingSpotType.underground; etc.
    return v; // placeholder — see NOTE below
  }
}
// NOTE: In the real file, replace _ParkingSpotTypeHelper with direct
// ParkingSpotType.xxx references from your existing enum, exactly as you do
// in AnnouncementStepOneScreen. The pattern is identical.

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.limeSubtle : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.borderColor : AppColors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: selected ? AppColors.limeLight : AppColors.iconBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon,
                  size: 22,
                  color: selected ? AppColors.limeDark : AppColors.textSecondary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? AppColors.limeDark
                              : AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded,
                  size: 20, color: AppColors.limeDark),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Step 2 — Title, description, characteristics
// ─────────────────────────────────────────────────────────────────────────────

class _EditStepInfo extends StatefulWidget {
  const _EditStepInfo();

  @override
  State<_EditStepInfo> createState() => _EditStepInfoState();
}

class _EditStepInfoState extends State<_EditStepInfo> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;

  static const _chars = [
    'Caméra de surveillance',
    'Accès sécurisé',
    'Couvert',
    'Éclairé',
    'Gardienné',
    'Chargeur EV',
    'Accès handicapé',
  ];

  @override
  void initState() {
    super.initState();
    final state = context.read<EditAnnouncementCubit>().state;
    _titleCtrl = TextEditingController(text: state.title);
    _descCtrl = TextEditingController(text: state.description);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditAnnouncementCubit>();

    return BlocBuilder<EditAnnouncementCubit, EditAnnouncementState>(
      builder: (context, state) {
        final canNext = _titleCtrl.text.trim().isNotEmpty &&
            _descCtrl.text.trim().isNotEmpty;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const _EditHeader(step: 2, totalSteps: 4),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informations de l\'annonce',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF222222)),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    Text(AppStrings.titre,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _titleCtrl,
                      onChanged: (v) {
                        cubit.updateTitle(v);
                        setState(() {});
                      },
                      decoration: _inputDeco('Ex: Garage sécurisé centre-ville'),
                    ),

                    const SizedBox(height: 16),

                    // Description
                    Text(AppStrings.description,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _descCtrl,
                      onChanged: (v) {
                        cubit.updateDescription(v);
                        setState(() {});
                      },
                      maxLines: 4,
                      decoration: _inputDeco(
                          'Décrivez votre emplacement, les accès, les équipements…'),
                    ),

                    const SizedBox(height: 20),

                    // Characteristics
                    Text(AppStrings.caracteristiques,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _chars.map((c) {
                        final sel = state.characteristics.contains(c);
                        return GestureDetector(
                          onTap: () => cubit.toggleCharacteristic(c),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: sel
                                  ? AppColors.limeSubtle
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: sel
                                    ? AppColors.borderColor
                                    : AppColors.border,
                              ),
                            ),
                            child: Text(
                              c,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: sel
                                    ? AppColors.limeDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _BottomActions(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => cubit.previousStep(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(AppStrings.retour),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: _PrimaryBtn(
                      label: 'Suivant',
                      enabled: canNext,
                      onPressed: () => cubit.goToStep(3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      filled: true,
      fillColor: AppColors.textFieldBackgound,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.borderColor, width: 1.5),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Step 3 — Pricing (+ hours)
// ─────────────────────────────────────────────────────────────────────────────

class _EditStepPricing extends StatefulWidget {
  const _EditStepPricing();

  @override
  State<_EditStepPricing> createState() => _EditStepPricingState();
}

class _EditStepPricingState extends State<_EditStepPricing> {
  late final TextEditingController _dayCtrl;
  late final TextEditingController _monthCtrl;
  late final TextEditingController _openCtrl;
  late final TextEditingController _closeCtrl;

  @override
  void initState() {
    super.initState();
    final s = context.read<EditAnnouncementCubit>().state;
    _dayCtrl =
        TextEditingController(text: s.pricePerDay.toStringAsFixed(0));
    _monthCtrl =
        TextEditingController(text: s.pricePerMonth.toStringAsFixed(0));
    _openCtrl = TextEditingController(text: s.openingTime ?? '');
    _closeCtrl = TextEditingController(text: s.closingTime ?? '');
  }

  @override
  void dispose() {
    _dayCtrl.dispose();
    _monthCtrl.dispose();
    _openCtrl.dispose();
    _closeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditAnnouncementCubit>();

    return BlocBuilder<EditAnnouncementCubit, EditAnnouncementState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const _EditHeader(step: 3, totalSteps: 4),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tarifs et horaires',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF222222)),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: _PriceField(
                            label: 'Prix / jour (DT)',
                            controller: _dayCtrl,
                            onChanged: (v) {
                              final d = double.tryParse(v) ?? 0;
                              cubit.updatePricePerDay(d);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _PriceField(
                            label: 'Prix / mois (DT)',
                            controller: _monthCtrl,
                            onChanged: (v) {
                              final d = double.tryParse(v) ?? 0;
                              cubit.updatePricePerMonth(d);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'Horaires d\'accès',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _PriceField(
                            label: 'Ouverture (ex: 07:00)',
                            controller: _openCtrl,
                            onChanged: cubit.updateOpeningTime,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _PriceField(
                            label: 'Fermeture (ex: 22:00)',
                            controller: _closeCtrl,
                            onChanged: cubit.updateClosingTime,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _BottomActions(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => cubit.previousStep(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(AppStrings.retour),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: _PrimaryBtn(
                      label: 'Suivant',
                      onPressed: () => cubit.goToStep(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PriceField extends StatelessWidget {
  const _PriceField({
    required this.label,
    required this.controller,
    required this.onChanged,
    this.keyboardType = TextInputType.number,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.textFieldBackgound,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.borderColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Step 4 — Location (address text only; map is optional enhancement)
//  Keep simple: just an editable text field for address + save button
// ─────────────────────────────────────────────────────────────────────────────

class _EditStepLocation extends StatefulWidget {
  const _EditStepLocation();

  @override
  State<_EditStepLocation> createState() => _EditStepLocationState();
}

class _EditStepLocationState extends State<_EditStepLocation> {
  late final TextEditingController _addrCtrl;

  @override
  void initState() {
    super.initState();
    final s = context.read<EditAnnouncementCubit>().state;
    _addrCtrl = TextEditingController(text: s.address);
  }

  @override
  void dispose() {
    _addrCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditAnnouncementCubit>();

    return BlocBuilder<EditAnnouncementCubit, EditAnnouncementState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const _EditHeader(step: 4, totalSteps: 4),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adresse du parking',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF222222)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Mettez à jour l\'adresse si nécessaire.',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 20),
                    Text(AppStrings.adresse,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _addrCtrl,
                      onChanged: cubit.updateAddress,
                      decoration: InputDecoration(
                        hintText: 'Ex: 14 Rue des Jasmins, El Menzah 6',
                        hintStyle: const TextStyle(
                            color: AppColors.textSecondary, fontSize: 13),
                        prefixIcon: const Icon(Icons.location_on_outlined,
                            color: AppColors.textSecondary),
                        filled: true,
                        fillColor: AppColors.textFieldBackgound,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.borderColor, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Info note
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.limeLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 18, color: AppColors.limeDark),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Pour modifier la position GPS, utilisez la carte dans l\'application.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.limeDark,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _BottomActions(
              child: Column(
                children: [
                  // Submit button
                  BlocBuilder<EditAnnouncementCubit, EditAnnouncementState>(
                    builder: (context, state) {
                      return state.isSubmitting
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.colorBtn))
                          : _PrimaryBtn(
                              label: 'Enregistrer les modifications',
                              onPressed: () => cubit.saveChanges(),
                            );
                    },
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => cubit.previousStep(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(AppStrings.retour),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}