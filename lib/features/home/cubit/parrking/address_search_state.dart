import 'package:equatable/equatable.dart';

import '../../../parking_map/models/selected_place.dart';

enum AddressSearchStatus {
  initial,
  loading,
  success,
  empty,
  failure,
  currentLocationLoading,
}

class AddressSearchState extends Equatable {
  final String query;
  final AddressSearchStatus status;
  final List<SelectedPlace> suggestions;
  final List<SelectedPlace> recentPlaces;
  final String? errorMessage;

  const AddressSearchState({
    this.query = '',
    this.status = AddressSearchStatus.initial,
    this.suggestions = const [],
    this.recentPlaces = const [],
    this.errorMessage,
  });

  AddressSearchState copyWith({
    String? query,
    AddressSearchStatus? status,
    List<SelectedPlace>? suggestions,
    List<SelectedPlace>? recentPlaces,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AddressSearchState(
      query: query ?? this.query,
      status: status ?? this.status,
      suggestions: suggestions ?? this.suggestions,
      recentPlaces: recentPlaces ?? this.recentPlaces,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        query,
        status,
        suggestions,
        recentPlaces,
        errorMessage,
      ];
}