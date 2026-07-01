import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/notification/cubit/notification_state.dart';
import 'package:tunipark/features/notification/services/notification_service.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationService})
      : super(NotificationState.initial());

  final NotificationService notificationService;

  Future<void> loadNotifications() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final items = await notificationService.fetchMyNotifications();
      emit(state.copyWith(isLoading: false, items: items));
    } catch (_) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Impossible de charger les notifications.',
      ));
    }
  }

  Future<void> markAsRead(String id) async {
    final index = state.items.indexWhere((item) => item.id == id);
    if (index == -1 || state.items[index].isRead) return;

    // Optimistic update so the badge/dot reacts instantly.
    final optimistic = [...state.items];
    optimistic[index] = optimistic[index].copyWith(isRead: true);
    emit(state.copyWith(items: optimistic));

    try {
      await notificationService.markAsRead(id);
    } catch (_) {
      // Revert on failure — keep local state consistent with the server.
      final reverted = [...state.items];
      reverted[index] = reverted[index].copyWith(isRead: false);
      emit(state.copyWith(items: reverted));
    }
  }

  /// Removes a notification from the visible list only.
  ///
  /// NOTE: the backend's `notifications` module doesn't expose a delete
  /// endpoint yet (only fcm-token registration, list, and mark-as-read), so
  /// a swipe-to-dismiss here is local/UI-only — it will reappear on the next
  /// [loadNotifications] call. Add a `DELETE /notifications/:id` route +
  /// use-case backend-side if you want dismissal to persist.
  void removeLocally(String id) {
    final updated = state.items.where((item) => item.id != id).toList();
    emit(state.copyWith(items: updated));
  }
}