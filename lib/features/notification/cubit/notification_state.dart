import 'package:equatable/equatable.dart';
import 'package:tunipark/features/notification/models/notification_item_model.dart';

class NotificationState extends Equatable {
  final bool isLoading;
  final List<NotificationItemModel> items;
  final String? error;

  const NotificationState({
    required this.isLoading,
    required this.items,
    required this.error,
  });

  factory NotificationState.initial() {
    return const NotificationState(
      isLoading: true,
      items: [],
      error: null,
    );
  }

  int get unreadCount => items.where((e) => !e.isRead).length;

  NotificationState copyWith({
    bool? isLoading,
    List<NotificationItemModel>? items,
    String? error,
    bool clearError = false,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, error];
}