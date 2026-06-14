import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_cubit.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_state.dart';
import 'package:tunipark/features/parking_booking_flow/widgets/parking_booking_bottom_button.dart';
import 'package:tunipark/features/parking_booking_flow/widgets/parking_booking_progress_bar.dart';
import 'package:tunipark/features/parking_booking_flow/widgets/steps/choose_place_step.dart';
import 'package:tunipark/features/parking_booking_flow/widgets/steps/order_details_step.dart';
import 'package:tunipark/features/parking_booking_flow/widgets/steps/payment_method_step.dart';
import 'package:tunipark/features/parking_booking_flow/widgets/steps/payment_success_step.dart';
import 'package:tunipark/features/parking_booking_flow/widgets/steps/vehicle_info_step.dart';

enum PendingPaymentResult { success, fail }

class ParkingBookingFlowScreen extends StatefulWidget {
  const ParkingBookingFlowScreen({super.key});

  @override
  State<ParkingBookingFlowScreen> createState() =>
      _ParkingBookingFlowScreenState();
}

class _ParkingBookingFlowScreenState extends State<ParkingBookingFlowScreen>
    with WidgetsBindingObserver {
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSub;

  bool _surfaceReady = true;
  PendingPaymentResult? _pendingPaymentResult;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appLinks = AppLinks();

    _linkSub = _appLinks.uriLinkStream.listen((Uri uri) {
      debugPrint('🔗 DEEP LINK RECEIVED: $uri');
      debugPrint('🔗 scheme=${uri.scheme}');
      debugPrint('🔗 host=${uri.host}');
      debugPrint('🔗 path=${uri.path}');
      final path = uri.path.replaceAll('/', '');

      if (uri.scheme != 'tunipark' || uri.host != 'payment') {
        return;
      }

      if (path == 'success') {
        debugPrint('✅ SUCCESS LINK DETECTED');
        _pendingPaymentResult = PendingPaymentResult.success;
        _flushPendingPaymentResult();
        return;
      }

      if (path == 'fail') {
        debugPrint('❌ FAIL LINK DETECTED');
        _pendingPaymentResult = PendingPaymentResult.fail;
        _flushPendingPaymentResult();
        return;
      }
    });
  }

  void _flushPendingPaymentResult() {
    final result = _pendingPaymentResult;

    if (result == null) return;
    if (!_surfaceReady) return;
    if (!mounted) return;

    _pendingPaymentResult = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final cubit = context.read<ParkingBookingFlowCubit>();

      if (result == PendingPaymentResult.success) {
        cubit.onPaymentSuccess();
      } else {
        cubit.onPaymentFailed();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _surfaceReady = false;
    }

    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        _surfaceReady = true;
        _flushPendingPaymentResult();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocListener<ParkingBookingFlowCubit, ParkingBookingFlowState>(
      listenWhen: (previous, current) =>
          previous.paymentError != current.paymentError &&
          current.paymentError != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.paymentError!),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
      },
      child: BlocBuilder<ParkingBookingFlowCubit, ParkingBookingFlowState>(
        builder: (context, state) {
          debugPrint('🏗️ BlocBuilder rebuilding — step=${state.step}');
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  if (state.step == ParkingBookingStep.choosePlace) {
                    Navigator.of(context).pop();
                  } else {
                    context.read<ParkingBookingFlowCubit>().previousStep();
                  }
                },
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              ),
              title: Text(
                _title(state.step),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  ParkingBookingProgressBar(step: state.step),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: rs.adaptive(
                          mobile: 20,
                          tablet: 28,
                          desktop: 36,
                        ),
                        vertical: rs.adaptive(
                          mobile: 20,
                          tablet: 24,
                          desktop: 28,
                        ),
                      ),
                      child: _BookingStepBody(
                        key: ValueKey(state.step),
                        state: state,
                      ),
                    ),
                  ),
                  ParkingBookingBottomButton(
                    label: _buttonLabel(state.step),
                    isEnabled: state.canContinue,
                    onPressed: () async {
                      if (state.step == ParkingBookingStep.paymentSuccess) {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                        return;
                      }

                      await context.read<ParkingBookingFlowCubit>().nextStep();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _title(ParkingBookingStep step) {
    switch (step) {
      case ParkingBookingStep.choosePlace:
        return 'Choisir une place';
      case ParkingBookingStep.vehicleInfo:
        return 'Informations véhicule';
      case ParkingBookingStep.orderDetails:
        return 'Détails de la commande';
      case ParkingBookingStep.paymentMethod:
        return 'Mode de paiement';
      // case ParkingBookingStep.addBankCard:
      //   return 'Ajouter une carte bancaire';
      // case ParkingBookingStep.scanCard:
      //   return 'Scanner la carte';
      case ParkingBookingStep.paymentSuccess:
        return 'Paiement réussi';
    }
  }

  String _buttonLabel(ParkingBookingStep step) {
    switch (step) {
      case ParkingBookingStep.choosePlace:
      case ParkingBookingStep.vehicleInfo:
      case ParkingBookingStep.orderDetails:
        return 'Continuer';
      case ParkingBookingStep.paymentMethod:
        //case ParkingBookingStep.addBankCard:
        return 'Confirmer';
      // case ParkingBookingStep.scanCard:
      //   return 'Scanner';
      case ParkingBookingStep.paymentSuccess:
        return 'Retour à l’accueil';
    }
  }
}

class _BookingStepBody extends StatelessWidget {
  final ParkingBookingFlowState state;

  const _BookingStepBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    debugPrint('📦 _BookingStepBody building — step=${state.step}');

    switch (state.step) {
      case ParkingBookingStep.choosePlace:
        return const ChoosePlaceStep();
      case ParkingBookingStep.vehicleInfo:
        return const VehicleInfoStep();
      case ParkingBookingStep.orderDetails:
        return const OrderDetailsStep();
      case ParkingBookingStep.paymentMethod:
        return const PaymentMethodStep();
      // case ParkingBookingStep.addBankCard:
      //   return const AddBankCardStep();

      case ParkingBookingStep.paymentSuccess:
        return const PaymentSuccessStep();
    }
  }
}
