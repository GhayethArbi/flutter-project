import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit() : super(const TermsState());

  void selectTab(TermsTab tab) =>
      emit(state.copyWith(activeTab: tab, clearExpanded: true));

  void toggleSection(int index) {
    final next = state.expandedIndex == index ? null : index;
    emit(state.copyWith(
      expandedIndex: next,
      clearExpanded: next == null,
    ));
  }
}