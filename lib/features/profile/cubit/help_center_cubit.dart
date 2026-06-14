import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit() : super(const HelpCenterState());

  void updateSearch(String query) =>
      emit(state.copyWith(searchQuery: query, clearExpanded: true));

  void clearSearch() =>
      emit(state.copyWith(searchQuery: '', clearExpanded: true));

  void toggleFaq(int index) {
    final next = state.expandedIndex == index ? null : index;
    emit(state.copyWith(
      expandedIndex: next,
      clearExpanded: next == null,
    ));
  }
}