import 'package:flutter/material.dart';
import 'package:tunipark/features/notification/models/notification_item_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItemModel item;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
          decoration: BoxDecoration(
            color: item.isRead ? Colors.white : const Color(0xFFFDFEF7),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFD5EB63),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildIcon(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight:
                            item.isRead ? FontWeight.w600 : FontWeight.w700,
                      ),
                    ),
                  ),
                  if (!item.isRead)
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB7F000),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item.message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5A5A5A),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.date,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF9A9A9A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    switch (item.type) {
      case NotificationType.success:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);
      case NotificationType.update:
        return const Icon(Icons.access_time, color: Colors.grey, size: 20);
      case NotificationType.info:
        return const Icon(
          Icons.sentiment_satisfied,
          color: Colors.orange,
          size: 20,
        );
    }
  }
}