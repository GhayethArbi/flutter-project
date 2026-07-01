import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/di/service_locator.dart';
import 'package:tunipark/features/bookings/view/bookings_screen.dart';
import 'package:tunipark/features/my_lots/view/my_lots_screen.dart';

import '../../home/view/home_screen.dart';
import '../../notification/view/notification_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../cubit/main_nav_cubit.dart';
import '../cubit/main_nav_state.dart';
import '../widgets/app_bottom_nav_bar.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key, required this.sl});
  final ServiceLocator sl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainNavCubit(),
      child: _MainNavigationBody(sl: sl),
    );
  }
}

class _MainNavigationBody extends StatefulWidget {
  const _MainNavigationBody({required this.sl});
  final ServiceLocator sl;

  @override
  State<_MainNavigationBody> createState() => _MainNavigationBodyState();
}

class _MainNavigationBodyState extends State<_MainNavigationBody> {
  @override
  void initState() {
    super.initState();
    // Reached only once the user is authenticated (post-login / post-splash),
    // so this is a safe, natural place to grab/refresh the FCM token and
    // register it against the now-authenticated Dio instance.
    widget.sl.fcmService.initAndRegister();
  }

  @override
  Widget build(BuildContext context) {
    final sl = widget.sl;
    final List<Widget> pages = [
      const HomeScreen(), //explore
      BookingsScreen(bookingService: sl.bookingService),
      MyLotsScreen(sl: sl),
      NotificationScreen(notificationService: sl.notificationService),
      const ProfileScreen(),
    ];

    return BlocBuilder<MainNavCubit, MainNavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.currentIndex, children: pages),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: context.read<MainNavCubit>().changeTab,
          ),
        );
      },
    );
  }
}