import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
import 'package:tunipark/core/storage/dev_session_service.dart';
import 'package:tunipark/features/profile/models/profile_menu_item.dart';
import 'package:tunipark/features/profile/models/profile_promo_card_model.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DevSessionService devSessionService;
  final AuthStorageService authStorageService;
  ProfileCubit({
    required this.devSessionService,
    required this.authStorageService,
  }) : super(
    
         const ProfileState(
           greetingPrefix: "What's ",
           greetingHighlight: "up",
           selectedBottomNavIndex: 4,
           accountItems: [
             ProfileMenuItem(
               title: 'My personal details',
               icon: Icons.person_outline,
               route: ProfileMenuRoute.personalInfo,
             ),
             ProfileMenuItem(
               title: 'My vehicles',
               icon: Icons.directions_car_outlined,
               route: ProfileMenuRoute.myVehicles,
             ),
             ProfileMenuItem(
               title: 'Payment',
               icon: Icons.credit_card_outlined,
               route: ProfileMenuRoute.payment,
             ),
             ProfileMenuItem(
               title: 'Referral',
               icon: Icons.workspace_premium_outlined,
               route: ProfileMenuRoute.referral,
               showDivider: false,
             ),
           ],
           discoverItems: [
             // ProfileMenuItem(
             //   title: 'Electric recharge',
             //   icon: Icons.ev_station_outlined,
             //   route: ProfileMenuRoute.electricRecharge,
             // ),
             ProfileMenuItem(
               title: 'Manage Your Places',
               icon: Icons.business_center_outlined,
               route: ProfileMenuRoute.parkingProfessionals,
               showDivider: false,
             ),
           ],
           helpItems: [
             ProfileMenuItem(
               title: "Centre d'aide",
               icon: Icons.help_outline,
               route: ProfileMenuRoute.helpCenter,
             ),
             ProfileMenuItem(
               title: 'Safety instructions',
               icon: Icons.shield_outlined,
               route: ProfileMenuRoute.safetyInstructions,
             ),
             ProfileMenuItem(
               title: 'Sign out',
               icon: Icons.logout,
               // no route — handled separately in the view
             ),
             ProfileMenuItem(
               title: 'About us',
               icon: Icons.description_outlined,
               route: ProfileMenuRoute.aboutUs,
               showDivider: false,
             ),
           ],
           referralCard: ProfilePromoCardModel(
             title: 'Earn up to 150 DT per year',
             subtitle:
                 'Help your loved ones park! Invite up to 5 friends per year.',
             icon: Icons.wallet_giftcard_outlined,
             backgroundColor: Color(0xFFF2BE2D),
             textColor: Color(0xFF1F355C),
           ),
           professionalCard: ProfilePromoCardModel(
             title: 'Add Your Parking Place',
             subtitle: 'Rent your parking spaces.',
             icon: Icons.local_parking_outlined,
             backgroundColor: Color(0xFF173B6C),
             textColor: Colors.white,
           ), themeMode: AppThemeMode.day,
         ),
       ){
        loadUser(); 
       }


Future<void> loadUser() async {
  final user = await authStorageService.getUser();

  emit(state.copyWith(user: user));
}
  Future<void> signOut() async {
    emit(
      state.copyWith(
        isSigningOut: true,
        status: ProfileStatus.signingOut,
        clearErrorMessage: true,
      ),
    );

    try {
      await authStorageService.clearAll();

      emit(
        state.copyWith(isSigningOut: false, status: ProfileStatus.signedOut),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isSigningOut: false,
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void changeBottomNav(int index) {
    emit(state.copyWith(selectedBottomNavIndex: index));
  }

  void onMenuTap(String title, BuildContext context) async {
    debugPrint('Tapped on: $title');

    switch (title) {
      case 'My personal details':
        Navigator.pushNamed(context, AppRoutes.personalInfo);
        break;

      // case 'My vehicles':
      //   Navigator.pushNamed(context, AppRoutes.myVehicles);
      //   break;

      // case 'Payment':
      //   Navigator.pushNamed(context, AppRoutes.payment);
      //   break;

      // case 'Referral':
      //   Navigator.pushNamed(context, AppRoutes.referral);
      //   break;

      // case 'Electric recharge':
      //   Navigator.pushNamed(context, AppRoutes.electricRecharge);
      //   break;

      // case 'Parking for professionals':
      //   Navigator.pushNamed(context, AppRoutes.parkingProfessionals);
      //   break;

      // case "Centre d'aide":
      //   Navigator.pushNamed(context, AppRoutes.helpCenter);
      //   break;

      // case 'Safety instructions':
      //   Navigator.pushNamed(context, AppRoutes.safetyInstructions);
      //   break;

      // case 'About us':
      //   Navigator.pushNamed(context, AppRoutes.aboutUs);
      //   break;

      // case 'My Invoices':
      //   Navigator.pushNamed(context, AppRoutes.myInvoices);
      //   break;

      // case 'Share my remote control':
      //   Navigator.pushNamed(context, AppRoutes.shareRemote);
      //   break;

      // case 'Synchronize':
      //   Navigator.pushNamed(context, AppRoutes.synchronize);
      //   break;

      case 'Sign out':
        await signOut();

        break;

      default:
        debugPrint('No route defined for $title');
    }
  }

  void setThemeMode(AppThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }

  void toggleThemeMode() {
    final newMode = state.themeMode == AppThemeMode.day
        ? AppThemeMode.night
        : AppThemeMode.day;

    emit(state.copyWith(themeMode: newMode));
  }
}
