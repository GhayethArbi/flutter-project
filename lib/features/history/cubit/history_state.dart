import 'package:equatable/equatable.dart';
import 'package:tunipark/features/history/models/history_item_model.dart';

class HistoryState extends Equatable {
  final bool isLoading;
  final List<HistoryItemModel> items;
  final String? errorMessage;

  const HistoryState({
    required this.isLoading,
    required this.items,
    required this.errorMessage,
  });

  factory HistoryState.initial() {
    return const HistoryState(
      isLoading: true,
      items: [],
      errorMessage: null,
    );
  }

  HistoryState copyWith({
    bool? isLoading,
    List<HistoryItemModel>? items,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, errorMessage];
}