import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/auth/logout_handler.dart';
import 'package:tunipark/core/di/service_locator.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/router/not_found_screen.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/features/edit_profile/view/edit_profile_screen.dart';
import 'package:tunipark/features/home/view/address_search_screen.dart';
import 'package:tunipark/features/home/view/home_screen.dart';
import 'package:tunipark/features/language/view/language_screen.dart';
import 'package:tunipark/features/login/cubit/login_cubit.dart';
import 'package:tunipark/features/login/view/login_screen.dart';
import 'package:tunipark/features/main_navigation/view/main_navigation_screen.dart';
import 'package:tunipark/features/onboarding/view/onboarding_screen.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_cubit.dart';
import 'package:tunipark/features/parking_booking_flow/view/parking_booking_flow_screen.dart';
import 'package:tunipark/features/parking_details/cubit/parking_details_cubit.dart';
import 'package:tunipark/features/parking_details/view/parking_details_screen.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';
import 'package:tunipark/features/parking_map/models/selected_place.dart';
import 'package:tunipark/features/parking_map/view/parking_map_screen.dart';
import 'package:tunipark/features/payments/view/payments_screen.dart';
import 'package:tunipark/features/personal_information/view/personal_information_screen.dart';
import 'package:tunipark/features/profile/view/help_center_screen.dart';
import 'package:tunipark/features/profile/view/privacy_policy_screen.dart';
import 'package:tunipark/features/profile/view/terms_of_use_screen.dart';
import 'package:tunipark/features/security/cubit/change_password_cubit.dart';
import 'package:tunipark/features/security/view/change_password_screen.dart';
import 'package:tunipark/features/security/view/security_screen.dart';
import 'package:tunipark/features/signup/cubit/signup_cubit.dart';
import 'package:tunipark/features/signup/screens/sign_up_screen.dart';
import 'package:tunipark/features/splash/cubit/splash_cubit.dart';
import 'package:tunipark/features/splash/splash_screen.dart';
import 'package:tunipark/features/vehicles/view/vehicles_screen.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

/// Pure routing — no dependency construction here.
/// All services come from [ServiceLocator] passed in the constructor.
class AppRouter {
  AppRouter({required this.sl});

  final ServiceLocator sl;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<void> showSessionExpiredDialog() async {
    final context = navigatorKey.currentContext;
    print('DIALOG CALLED — context is ${context == null ? "NULL ❌" : "OK ✅"}');

    if (context == null) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(AppStrings2.sessionExpired),
        content: Text(AppStrings2.yourSessionHasExpiredPleaseLogIn),
        actions: [
          TextButton(
            onPressed: () => navigatorKey.currentState?.pushNamedAndRemoveUntil(
              AppRoutes.login,
              (route) => false,
            ),
            child: Text(AppStrings2.logIn,
              style: TextStyle(color: AppColors.greentext),
            ),
          ),
        ],
      ),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      //dio
      case AppRoutes.login:
        return _fade(
          settings: settings,
          page: BlocProvider(
            create: (_) => LoginCubit(
              loginService: sl.loginService,
              authStorageService: sl.authStorageService,
            ),
            child: LoginScreen(
              onSuccess: (context) =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.mainNav),
            ),
          ),
        );
      case AppRoutes.signup:
        return _fade(
          settings: settings,
          page: BlocProvider(
            create: (_) => SignUpCubit(service: sl.signUpService),
            child: const SignUpScreen(),
          ),
        );

      case AppRoutes.personalInfo:
        return _fade(
          settings: settings,
          page: PersonalInfoScreen(
            userService: sl.userService,
            authStorageService: sl.authStorageService,
          ),
        );

      case AppRoutes.splash:
        return _fade(
          settings: settings,
          page: BlocProvider(
            create: (_) =>
                SplashCubit(authStorageService: sl.authStorageService),
            child: const SplashScreen(),
          ),
        );
      case AppRoutes.changePasswordSec:
        return _fade(
          settings: settings,
          page: BlocProvider(
            create: (_) => ChangePasswordCubit(
              changePasswordService: sl.changePasswordService,
              authStorageService: sl.authStorageService,
              logoutHandler: LogoutHandler(
                authStorageService: sl.authStorageService,
                navigatorKey: navigatorKey,
              ),
            ),
            child: const ChangePasswordScreen(),
          ),
        );

      case AppRoutes.onboarding:
        return _fade(
          settings: settings,
          page: OnboardingScreen(
            onFinish: (context) =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.login),
          ),
        );

      case AppRoutes.mainNav:
        return _fade(
          settings: settings,
          page: MainNavigationScreen(sl: sl),
        );

      case AppRoutes.addressSearch:
        return _fade(settings: settings, page: const AddressSearchScreen());

      case AppRoutes.parkingDetails:
        final place = settings.arguments as ParkingPlace;
        return _fade(
          settings: settings,
          page: BlocProvider(
            lazy: false,
            create: (_) => ParkingDetailsCubit(place, sl.parkingInteractionApi),
            child: ParkingDetailsScreen(parking: place),
          ),
        );

      case AppRoutes.parkingMap:
        final place = settings.arguments as SelectedPlace;
        return _fade(
          settings: settings,
          page: ParkingMapScreen(
            place: place,
            parkingMapService: sl.parkingMapService,
          ),
        );

      case AppRoutes.parkingBookingFlow:
        final place = settings.arguments as ParkingPlace;
        return _fade(
          settings: settings,
          page: BlocProvider(
            create: (_) => ParkingBookingFlowCubit(
              place,
              parkingSessionService: sl.parkingSessionService,
              paymentService: sl.paymentService,
            ),
            child: const ParkingBookingFlowScreen(),
          ),
        );

      case AppRoutes.editProfile:
        return _fade(settings: settings, page: const EditProfileScreen());
      case AppRoutes.myVehicles:
        return _fade(settings: settings, page: const VehiclesScreen());
      case AppRoutes.payments:
        return _fade(settings: settings, page: const PaymentsScreen());
      case AppRoutes.language:
        return _fade(settings: settings, page: const LanguageScreen());
      case AppRoutes.home:
        return _fade(settings: settings, page: const HomeScreen());
      case AppRoutes.security:
        return _fade(settings: settings, page: const SecurityScreen());

      case AppRoutes.helpCenter:
        return _fade(settings: settings, page: const HelpCenterScreen());
      case AppRoutes.privacyPolicy:
        return _fade(settings: settings, page: const PrivacyPolicyScreen());
      case AppRoutes.termsOfUse:
        return _fade(settings: settings, page: const TermsOfUseScreen());

      default:
        return _fade(
          settings: settings,
          page: NotFoundScreen(route: settings.name ?? '?'),
        );
    }
  }

  static PageRouteBuilder<T> _fade<T>({
    required RouteSettings settings,
    required Widget page,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: duration,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: child,
      ),
    );
  }
}
