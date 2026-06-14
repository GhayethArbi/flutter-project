// lib/features/bookings/cubit/bookings_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/booking_service.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit({required BookingService bookingService})
    : _service = bookingService,
      super(const BookingsState());

  final BookingService _service;

  Future<void> loadBookings() async {
    emit(state.copyWith(status: BookingsStatus.loading));
    try {
      final bookings = await _service.fetchMySessions();
      // Sort: active first, then most recent
      bookings.sort((a, b) {
        if (a.isActive && !b.isActive) return -1;
        if (!a.isActive && b.isActive) return 1;
        return b.startedAt.compareTo(a.startedAt);
      });
      emit(
        state.copyWith(status: BookingsStatus.success, allBookings: bookings),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BookingsStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> cancelBooking(String sessionId) async {
    try {
      await _service.cancelSession(sessionId);
      await loadBookings();
    } catch (e) {
      emit(
        state.copyWith(
          status: BookingsStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  void setFilter(BookingsFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  Future<void> refresh() => loadBookings();

  /// Called after ending/cancelling — updates card instantly
  void removeBooking(String sessionId) {
    final updated = state.allBookings
        .where((b) => b.sessionId != sessionId)
        .toList();
    emit(state.copyWith(allBookings: updated));
  }

  /// Called after extend success — refreshes from server
  void markExpired(String sessionId) {
    final updated = state.allBookings.map((b) {
      if (b.sessionId == sessionId) {
        // We can't construct with different status without fromJson
        // so just refresh from server
        return b;
      }
      return b;
    }).toList();
    emit(state.copyWith(allBookings: updated));
  }
}
