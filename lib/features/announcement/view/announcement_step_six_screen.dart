import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_flow_header.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

class AnnouncementStepSixScreen extends StatelessWidget {
  const AnnouncementStepSixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
      builder: (context, state) {
        final cubit = context.read<AnnouncementFlowCubit>();

        return Stack(
          children: [
            Scaffold(
              backgroundColor: const Color(0xFFF5F5F5),
              body: SafeArea(
                bottom: false,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: rs.adaptive(mobile: rs.w, tablet: 700, desktop: 850),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  step: 7,
                                  totalSteps: 7,
                                  onBack: () => cubit.goToStep(6),
                                  onClose: () => Navigator.pop(context),
                                ),

                                SizedBox(height: rs.adaptive(mobile: 18, tablet: 24, desktop: 28)),

                                Text(AppStrings.fixerVosTarifs,
                                  style: TextStyle(
                                    fontSize: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),

                                SizedBox(height: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),

                                Text(AppStrings.definissezVosPrixVousPourrezLes,
                                  style: TextStyle(
                                    fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
                                    height: 1.45,
                                    color: const Color(0xFF888888),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                SizedBox(height: rs.adaptive(mobile: 32, tablet: 40, desktop: 48)),

                                // ── Prix par jour ──────────────────
                                _PriceLabel(text: AppStrings2.prixParJour),
                                SizedBox(height: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
                                _PriceFieldStateful(
                                  initialValue: state.pricePerDay,
                                  onChanged: cubit.updatePricePerDay,
                                ),
                                SizedBox(height: rs.adaptive(mobile: 6, tablet: 8, desktop: 10)),
                                _HelperText(text: AppStrings2.pourLesVisiteursEtLesDeplacements),

                                SizedBox(height: rs.adaptive(mobile: 22, tablet: 28, desktop: 32)),

                                // ── Prix par mois ──────────────────
                                _PriceLabel(text: AppStrings2.prixParMois),
                                SizedBox(height: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
                                _PriceFieldStateful(
                                  initialValue: state.pricePerMonth,
                                  onChanged: cubit.updatePricePerMonth,
                                ),
                                SizedBox(height: rs.adaptive(mobile: 6, tablet: 8, desktop: 10)),
                                _HelperText(text: AppStrings2.abonnementLongueDuree),

                                SizedBox(height: rs.adaptive(mobile: 22, tablet: 28, desktop: 32)),

                                // ── Prix par heure (optional, NEW) ─
                                _PriceLabel(text: AppStrings2.prixParHeureOptionnel),
                                SizedBox(height: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
                                _PriceFieldStateful(
                                  initialValue: state.pricePerUnit ?? 0,
                                  onChanged: cubit.updatePricePerUnit,
                                  allowZero: true,
                                ),
                                SizedBox(height: rs.adaptive(mobile: 6, tablet: 8, desktop: 10)),
                                _HelperText(text: AppStrings2.laissezA0PourNePasProposer),

                                // ── Error banner ───────────────────
                                if (state.errorMessage.isNotEmpty) ...[
                                  SizedBox(height: rs.adaptive(mobile: 24, tablet: 28, desktop: 32)),
                                  _ErrorBanner(
                                    message: state.errorMessage,
                                    onDismiss: cubit.clearError,
                                  ),
                                ],

                                SizedBox(height: rs.adaptive(mobile: 24, tablet: 28, desktop: 32)),
                              ],
                            ),
                          ),
                        ),

                        AnnouncementFixedBottomActions(
                          child: Row(
                            children: [
                              Expanded(
                                child: _BottomButton(
                                  text: AppStrings2.retour,
                                  isPrimary: false,
                                  onPressed: state.isLoading ? null : () => cubit.goToStep(6),
                                ),
                              ),
                              SizedBox(width: rs.adaptive(mobile: 14, tablet: 18, desktop: 20)),
                              Expanded(
                                child: _BottomButton(
                                  text: AppStrings2.publier,
                                  isPrimary: true,
                                  onPressed: state.isLoading
                                      ? null
                                      : () => cubit.publishAnnouncement(),
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
            ),

            if (state.isLoading) const _LoadingOverlay(),
          ],
        );
      },
    );
  }
}

// ─── Loading Overlay ──────────────────────────────────────────────────────────

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Container(
      color: Colors.black.withOpacity(0.45),
      child: Center(
        child: Container(
          width: rs.adaptive(mobile: 220, tablet: 260, desktop: 280),
          padding: EdgeInsets.all(rs.adaptive(mobile: 28, tablet: 32, desktop: 36)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(rs.adaptive(mobile: 16, tablet: 18, desktop: 20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFFB7F000)),
                ),
              ),
              SizedBox(height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22)),
              Text(AppStrings.publicationEnCours,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              SizedBox(height: rs.adaptive(mobile: 6, tablet: 7, desktop: 8)),
              Text(AppStrings.veuillezPatienter,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
                  color: const Color(0xFF888888),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Error Banner ─────────────────────────────────────────────────────────────

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onDismiss;

  const _ErrorBanner({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(rs.adaptive(mobile: 14, tablet: 16, desktop: 18)),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
        border: Border.all(color: const Color(0xFFFFCDD2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: const Color(0xFFE53935),
            size: rs.adaptive(mobile: 20, tablet: 22, desktop: 22),
          ),
          SizedBox(width: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.echecDeLaPublication,
                  style: TextStyle(
                    fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFB71C1C),
                  ),
                ),
                SizedBox(height: rs.adaptive(mobile: 4, tablet: 5, desktop: 6)),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
                    height: 1.4,
                    color: const Color(0xFFD32F2F),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(
              Icons.close,
              size: rs.adaptive(mobile: 18, tablet: 20, desktop: 20),
              color: const Color(0xFFE53935),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Price Field ──────────────────────────────────────────────────────────────

class _PriceFieldStateful extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;
  final bool allowZero;

  const _PriceFieldStateful({
    required this.initialValue,
    required this.onChanged,
    this.allowZero = false,
  });

  @override
  State<_PriceFieldStateful> createState() => _PriceFieldStatefulState();
}

class _PriceFieldStatefulState extends State<_PriceFieldStateful> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue.toInt().toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increment() {
    final current = double.tryParse(_controller.text) ?? widget.initialValue;
    final next = current + 1;
    _controller.text = next.toInt().toString();
    widget.onChanged(next);
  }

  void _decrement() {
    final current = double.tryParse(_controller.text) ?? widget.initialValue;
    final minVal = widget.allowZero ? 0 : 1;
    if (current > minVal) {
      final next = current - 1;
      _controller.text = next.toInt().toString();
      widget.onChanged(next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return SizedBox(
      height: rs.adaptive(mobile: 52, tablet: 56, desktop: 58),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1A1A1A),
        ),
        onChanged: (value) {
          final parsed = double.tryParse(value);
          if (parsed != null && (parsed > 0 || widget.allowZero)) {
            widget.onChanged(parsed);
          }
        },
        decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.dt,
                style: TextStyle(
                  fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF333333),
                ),
              ),
              SizedBox(width: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _increment,
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                      color: const Color(0xFF555555),
                    ),
                  ),
                  GestureDetector(
                    onTap: _decrement,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                      color: const Color(0xFF555555),
                    ),
                  ),
                ],
              ),
              SizedBox(width: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
            ],
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
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
      ),
    );
  }
}

// ─── Supporting Widgets ───────────────────────────────────────────────────────

class _PriceLabel extends StatelessWidget {
  final String text;
  const _PriceLabel({required this.text});

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

class _HelperText extends StatelessWidget {
  final String text;
  const _HelperText({required this.text});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    return Text(
      text,
      style: TextStyle(
        fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
        color: const Color(0xFF888888),
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
      height: rs.adaptive(mobile: 48, tablet: 52, desktop: 54),
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