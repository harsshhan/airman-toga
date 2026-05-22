import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/study_note.dart';
import '../../data/model/sync_status.dart';

class NoteCard extends StatelessWidget {
  final StudyNote note;
  final VoidCallback onTap;
  final VoidCallback onRetrySync;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onRetrySync,
  });

  @override
  Widget build(BuildContext context) {
    final badgeConfig = _getBadgeConfig(note.syncStatus);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.textSecondary.withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu_book_rounded,
                        size: 16,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          note.subject.isEmpty ? 'Untitled Note' : note.subject,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, 
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeConfig.bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (note.syncStatus == SyncStatus.syncing)
                        SizedBox(
                          width: 8,
                          height: 8,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            valueColor: AlwaysStoppedAnimation<Color>(badgeConfig.textColor),
                          ),
                        )
                      else
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: badgeConfig.textColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(width: 6),
                      Text(
                        badgeConfig.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: badgeConfig.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              note.content,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textHint,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(note.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
                if (note.syncStatus == SyncStatus.failed)
                  GestureDetector(
                    onTap: onRetrySync,
                    child: Row(
                      children: const [
                        Icon(Icons.sync_rounded, size: 14, color: Colors.red),
                        SizedBox(width: 4),
                        Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today, ${DateFormat('h:mm a').format(date)}';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      return 'Yesterday, ${DateFormat('h:mm a').format(date)}';
    }
    return '${DateFormat('d MMM').format(date)}, ${DateFormat('h:mm a').format(date)}';
  }

  _BadgeConfig _getBadgeConfig(SyncStatus status) {
    switch (status) {
      case SyncStatus.pending:
        return _BadgeConfig(
          label: 'Pending Sync',
          bgColor: const Color(0xFFFFF4E5),
          textColor: const Color(0xFFE68A00),
        );
      case SyncStatus.syncing:
        return _BadgeConfig(
          label: 'Syncing...',
          bgColor: const Color(0xFFE5F0FF),
          textColor: Colors.blue,
        );
      case SyncStatus.synced:
        return _BadgeConfig(
          label: 'Synced',
          bgColor: const Color(0xFFE8F5E9),
          textColor: const Color(0xFF2E7D32),
        );
      case SyncStatus.failed:
        return _BadgeConfig(
          label: 'Failed',
          bgColor: const Color(0xFFFFEBEE),
          textColor: const Color(0xFFC62828),
        );
    }
  }
}

class _BadgeConfig {
  final String label;
  final Color bgColor;
  final Color textColor;

  _BadgeConfig({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });
}
