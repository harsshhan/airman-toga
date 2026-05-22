import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/notification_item.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final typeConfig = _getTypeConfig(notification.type);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: notification.isRead
            ? AppColors.surface
            : AppColors.secondary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: notification.isRead
            ? null
            : Border.all(
                color: AppColors.secondary.withValues(alpha: 0.2),
                width: 1,
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: typeConfig.bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              typeConfig.icon,
              color: typeConfig.iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: notification.isRead
                              ? FontWeight.w600
                              : FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      notification.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: notification.isRead
                            ? AppColors.textSecondary
                            : AppColors.secondary,
                        fontWeight: notification.isRead
                            ? FontWeight.normal
                            : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 14,
                    color: notification.isRead
                        ? AppColors.textSecondary
                        : AppColors.textPrimary.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
                if (!notification.isRead) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: onMarkAsRead,
                    child: const Text(
                      'Mark as read',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Unread dot
          if (!notification.isRead)
            Container(
              margin: const EdgeInsets.only(left: 8, top: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  _TypeConfig _getTypeConfig(String type) {
    switch (type) {
      case 'flight':
        return _TypeConfig(
          icon: Icons.flight_takeoff_rounded,
          iconColor: AppColors.secondary,
          bgColor: AppColors.secondary.withValues(alpha: 0.12),
        );
      case 'study':
        return _TypeConfig(
          icon: Icons.menu_book_rounded,
          iconColor: const Color(0xFFE6A817),
          bgColor: const Color(0xFFFFF9E6),
        );
      case 'feedback':
        return _TypeConfig(
          icon: Icons.feedback_outlined,
          iconColor: AppColors.success,
          bgColor: AppColors.success.withValues(alpha: 0.12),
        );
      case 'fto':
        return _TypeConfig(
          icon: Icons.account_balance_outlined,
          iconColor: const Color(0xFF7C5CFC),
          bgColor: const Color(0xFFF0EEFF),
        );
      case 'sync':
        return _TypeConfig(
          icon: Icons.sync_rounded,
          iconColor: AppColors.textSecondary,
          bgColor: AppColors.progressBackground,
        );
      default:
        return _TypeConfig(
          icon: Icons.notifications_none_rounded,
          iconColor: AppColors.secondary,
          bgColor: AppColors.secondary.withValues(alpha: 0.12),
        );
    }
  }
}

class _TypeConfig {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  _TypeConfig({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}
