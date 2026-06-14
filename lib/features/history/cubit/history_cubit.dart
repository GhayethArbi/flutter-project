import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/history/cubit/history_state.dart';
import 'package:tunipark/features/history/models/history_item_model.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryState.initial());

  Future<void> loadHistory() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final items = <HistoryItemModel>[
        const HistoryItemModel(
          id: '1',
          title: 'Sous-sol immeuble Ennarjess',
          address: 'V8MJ+VJ2, Av. Habib Bourguiba, Marsa',
          date: '12 mars 2026',
          duration: '10',
          payment: '200,00 DT',
        ),
        const HistoryItemModel(
          id: '2',
          title: 'Réservation longue durée',
          address: 'Garage privé – La Marsa',
          date: '5 mars 2026 – 7 mars 2026',
          duration: '2 jours',
          payment: '40,00 DT',
        ),
      ];

      emit(
        state.copyWith(
          isLoading: false,
          items: items,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Erreur lors du chargement de l’historique.',
        ),
      );
    }
  }

  void parkHere(HistoryItemModel item) {
    // plus tard:
    // - navigation vers map
    // - préremplir l'adresse
    // - relancer une réservation
  }
}