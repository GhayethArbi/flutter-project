import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/notification/cubit/notification_state.dart';
import 'package:tunipark/features/notification/models/notification_item_model.dart';


class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState.initial());

  Future<void> loadNotifications() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    await Future.delayed(const Duration(milliseconds: 300));

    final data = [
      const NotificationItemModel(
        id: '1',
        title: 'Paiement confirmé',
        message:
            'Votre paiement de stationnement a été effectué avec succès. Merci d’utiliser TuniPark !',
        date: 'Aujourd’hui, 10:45',
        type: NotificationType.success,
        isRead: false,
      ),
      const NotificationItemModel(
        id: '2',
        title: 'Mise à jour disponible',
        message:
            'Une nouvelle version est disponible. Mettez à jour l’application pour profiter des dernières améliorations',
        date: 'Mardi, 10:43',
        type: NotificationType.update,
        isRead: false,
      ),
      const NotificationItemModel(
        id: '3',
        title: 'Parking approuvé',
        message:
            'Votre parking a été validé et est maintenant visible pour les utilisateurs sur TuniPark',
        date: 'Jeudi, 10:00',
        type: NotificationType.info,
        isRead: true,
      ),
    ];

    emit(state.copyWith(isLoading: false, items: data));
  }

  void markAsRead(String id) {
    final updated =
        state.items.map((item) {
          if (item.id == id) {
            return item.copyWith(isRead: true);
          }
          return item;
        }).toList();

    emit(state.copyWith(items: updated));
  }

  void deleteNotification(String id) {
    final updated = state.items.where((item) => item.id != id).toList();
    emit(state.copyWith(items: updated));
  }
}