import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
//import 'package:tunipark/core/storage/dev_session_service.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  // final DevSessionService devSessionService;
  final AuthStorageService authStorageService;
  SplashCubit({
    //required this.devSessionService,
    required this.authStorageService,
  }) : super(const SplashState());

  Future<void> decideNavigation() async {
    emit(state.copyWith(status: SplashStatus.checking));

    //final onboardingSeen = await devSessionService.isOnboardingSeen();
    final onboardingSeen = await authStorageService.isOnboardingSeen();
    final accessToken = await authStorageService.getAccessToken();
    final isLoggedIn = accessToken != null;

    if (!onboardingSeen) {
      emit(state.copyWith(status: SplashStatus.goToOnboarding));
    } else if (isLoggedIn) {
      emit(state.copyWith(status: SplashStatus.goToMainNav));
    } else {
      emit(state.copyWith(status: SplashStatus.goToLogin));
    }
  }
}
