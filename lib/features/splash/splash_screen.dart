import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/features/splash/cubit/splash_cubit.dart';
import 'package:tunipark/features/splash/cubit/splash_state.dart';
import 'package:tunipark/features/splash/widgets/parking_scene.dart';
import 'package:tunipark/features/splash/widgets/splash_logo.dart';

import '../../core/theme/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _showLogo = false;

  late final AnimationController _logoController;
  late final Animation<double> _logoOpacity;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _logoOpacity = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  Future<void> _onParkingDone() async {
    setState(() => _showLogo = true);

    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    context.read<SplashCubit>().decideNavigation();
  }

  void _handleNavigation(BuildContext context, SplashState state) {
    switch (state.status) {
      case SplashStatus.goToOnboarding:
        Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
        break;

      case SplashStatus.goToLogin:
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        break;

      case SplashStatus.goToMainNav:
        Navigator.of(context).pushReplacementNamed(AppRoutes.mainNav);
        break;

      case SplashStatus.initial:
      case SplashStatus.checking:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: _handleNavigation,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Stack(
            children: [
              if (!_showLogo)
                ParkingScene(onAnimationComplete: _onParkingDone),

              if (_showLogo)
                SplashLogo(opacity: _logoOpacity),
            ],
          ),
        ),
      ),
    );
  }
}