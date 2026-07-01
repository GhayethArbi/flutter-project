import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/my_lots_service.dart';
import 'my_lots_state.dart';

class MyLotsCubit extends Cubit<MyLotsState> {
  MyLotsCubit({required MyLotsService myLotsService})
      : _service = myLotsService,
        super(const MyLotsState());

  final MyLotsService _service;

  Future<void> loadLots() async {
    emit(state.copyWith(status: MyLotsStatus.loading));
    try {
      final lots = await _service.fetchMyLots();
      emit(state.copyWith(status: MyLotsStatus.success, lots: lots));
    } catch (e) {
      emit(state.copyWith(
        status: MyLotsStatus.failure,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  /// Called after a lot is archived — removes it locally immediately
  void removeLot(String id) {
    final updated = state.lots.where((l) => l.id != id).toList();
    emit(state.copyWith(lots: updated));
  }

  /// Called after edit success — refreshes from server
  Future<void> refresh() => loadLots();
}