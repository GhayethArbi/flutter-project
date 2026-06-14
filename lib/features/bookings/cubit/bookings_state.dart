// lib/features/bookings/cubit/bookings_state.dart

import 'package:equatable/equatable.dart';
import '../models/booking_model.dart';

enum BookingsStatus { initial, loading, success, failure }
enum BookingsFilter { all, active, past }

class BookingsState extends Equatable {
  const BookingsState({
    this.status = BookingsStatus.initial,
    this.allBookings = const [],
    this.filter = BookingsFilter.all,
    this.errorMessage,
  });

  final BookingsStatus status;
  final List<BookingModel> allBookings;
  final BookingsFilter filter;
  final String? errorMessage;

  bool get isLoading => status == BookingsStatus.loading;

 List<BookingModel> get filteredBookings {
  switch (filter) {
    case BookingsFilter.active:
      return allBookings
          .where((b) => b.status == BookingStatus.active)
          .toList();

    case BookingsFilter.past:
      return allBookings
          .where((b) =>
              b.status == BookingStatus.expired ||
              b.status == BookingStatus.cancelled)
          .toList();
    case BookingsFilter.all:
      return allBookings.toList();
  }
}


  bool get isEmpty => status == BookingsStatus.success && filteredBookings.isEmpty;

  BookingsState copyWith({
    BookingsStatus? status,
    List<BookingModel>? allBookings,
    BookingsFilter? filter,
    String? errorMessage,
  }) {
    return BookingsState(
      status: status ?? this.status,
      allBookings: allBookings ?? this.allBookings,
      filter: filter ?? this.filter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, allBookings, filter, errorMessage];
}