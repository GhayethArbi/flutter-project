import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({int total = 3})
      : super(OnboardingState(currentIndex: 0, total: total));

  bool next() {
    if (state.isLast) return true;
    emit(state.copyWith(currentIndex: state.currentIndex + 1));
    return false;
  }

  void previous() {
    if (state.isFirst) return;
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  void skip() => emit(state.copyWith(currentIndex: state.total - 1));

  // Called by PageView.onPageChanged to keep cubit in sync
  void jumpTo(int index) => emit(state.copyWith(currentIndex: index));
}