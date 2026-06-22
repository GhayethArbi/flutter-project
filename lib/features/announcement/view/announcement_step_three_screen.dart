import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_flow_header.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class AnnouncementStepThreeScreen extends StatelessWidget {
  const AnnouncementStepThreeScreen({super.key});

  static const List<String> _characteristics = [
    'Couvert',
    'Sécurisé',
    'Éclairé',
    'Accès 24h',
    'Portail automatique',
    'Place large',
    'Caméras',
    'Gardien',
  ];

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
      builder: (context, state) {
        final cubit = context.read<AnnouncementFlowCubit>();

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: rs.adaptive(mobile: rs.w, tablet: 700, desktop: 850),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: rs.adaptive(mobile: 16, tablet: 24, desktop: 32),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: rs.adaptive(mobile: 8, tablet: 12, desktop: 16)),

                            AnnouncementFlowHeader(
                              step: 3,
                              totalSteps: 7,
                              onBack: () => cubit.goToStep(2),
                              onClose: () => Navigator.pop(context),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 18, tablet: 24, desktop: 28)),

                            Text(AppStrings.decrivezVotreEmplacement,
                              style: TextStyle(
                                fontSize: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 28, tablet: 32, desktop: 36)),

                            _Label(text: AppStrings.titreDeLAnnonce),
                            SizedBox(height: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
                            _InputField(
                              hint: 'Ex : place sécurisée dans un sous-sol',
                              initialValue: state.title,
                              onChanged: cubit.updateTitle,
                            ),

                            SizedBox(height: rs.adaptive(mobile: 18, tablet: 22, desktop: 26)),

                            _Label(text: AppStrings.description),
                            SizedBox(height: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
                            _InputField(
                              hint: 'Décrivez votre emplacement, ses avantages, l\'accès…',
                              initialValue: state.description,
                              onChanged: cubit.updateDescription,
                              maxLines: 4,
                            ),

                            SizedBox(height: rs.adaptive(mobile: 18, tablet: 22, desktop: 26)),

                            _Label(text: AppStrings.caracteristiques),
                            SizedBox(height: rs.adaptive(mobile: 12, tablet: 14, desktop: 16)),

                            Wrap(
                              spacing: rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
                              runSpacing: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
                              children: _characteristics.map((item) {
                                final selected = state.characteristics.contains(item);
                                return GestureDetector(
                                  onTap: () => cubit.toggleCharacteristic(item),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
                                      vertical: rs.adaptive(mobile: 9, tablet: 10, desktop: 12),
                                    ),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? const Color(0xFFE7F2C5)
                                          : const Color(0xFFEDEDED),
                                      borderRadius: BorderRadius.circular(
                                        rs.adaptive(mobile: 24, tablet: 26, desktop: 28),
                                      ),
                                      border: selected
                                          ? Border.all(color: const Color(0xFFB7F000))
                                          : null,
                                    ),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF555555),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 32, tablet: 40, desktop: 48)),
                          ],
                        ),
                      ),
                    ),

                    AnnouncementFixedBottomActions(
                      child: Row(
                        children: [
                          Expanded(
                            child: _BottomButton(
                              text: AppStrings.retour,
                              isPrimary: false,
                              onPressed: () => cubit.goToStep(2),
                            ),
                          ),
                          SizedBox(width: rs.adaptive(mobile: 14, tablet: 18, desktop: 20)),
                          Expanded(
                            child: _BottomButton(
                              text: AppStrings.suivant,
                              isPrimary: true,
                              // next → step 4 (capacity screen)
                              onPressed: state.title.trim().isEmpty ||
                                      state.description.trim().isEmpty
                                  ? null
                                  : () => cubit.goToStep(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── Reusable sub-widgets ─────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    return Text(
      text,
      style: TextStyle(
        fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
        fontWeight: FontWeight.w700,
        color: const Color(0xFF5A5A5A),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String hint;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const _InputField({
    required this.hint,
    required this.initialValue,
    required this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
        color: const Color(0xFF1A1A1A),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
          color: const Color(0xFFB0B0B0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
          vertical: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
          ),
          borderSide: const BorderSide(color: Color(0xFFD6EA74)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
          ),
          borderSide: const BorderSide(color: Color(0xFFB7F000), width: 1.4),
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const _BottomButton({
    required this.text,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return SizedBox(
      height: rs.adaptive(mobile: 46, tablet: 50, desktop: 54),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFFB7F000) : Colors.white,
          disabledBackgroundColor: isPrimary
              ? const Color(0xFFB7F000).withOpacity(0.4)
              : Colors.white,
          side: const BorderSide(color: Color(0xFFB7F000)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              rs.adaptive(mobile: 24, tablet: 28, desktop: 30),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ),
    );
  }
}