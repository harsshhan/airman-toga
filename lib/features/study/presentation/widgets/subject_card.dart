import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../data/model/study_subject.dart';

class SubjectCard extends StatelessWidget {
  final StudySubject subject;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusConfig = _getStatusConfig(subject.status);
    final progress = subject.progress / 100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Subject icon
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: statusConfig.iconBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    statusConfig.icon,
                    color: statusConfig.iconColor,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    subject.subject,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusConfig.badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusConfig.badgeColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subject.status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusConfig.badgeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: AppColors.progressBackground,
                valueColor: AlwaysStoppedAnimation<Color>(
                  statusConfig.progressColor,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${subject.lessonsCompleted}/${subject.totalLessons} lessons',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Quiz: ',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: subject.status == 'Not Started'
                            ? '—'
                            : '${subject.quizScore}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusConfig.progressColor,
                        ),
                      ),
                      TextSpan(
                        text: '  ${subject.progress}%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: statusConfig.progressColor,
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

  _StatusConfig _getStatusConfig(String status) {
    switch (status) {
      case 'Completed':
        return _StatusConfig(
          icon: Icons.menu_book_outlined,
          iconBg: AppColors.success.withValues(alpha: 0.12),
          iconColor: AppColors.success,
          badgeBg: AppColors.success.withValues(alpha: 0.1),
          badgeColor: AppColors.success,
          progressColor: AppColors.success,
        );
      case 'Not Started':
        return _StatusConfig(
          icon: Icons.lock_outline_rounded,
          iconBg: AppColors.progressBackground,
          iconColor: AppColors.textSecondary,
          badgeBg: AppColors.progressBackground,
          badgeColor: AppColors.textSecondary,
          progressColor: AppColors.textSecondary,
        );
      default: // In Progress
        return _StatusConfig(
          icon: Icons.cloud_outlined,
          iconBg: AppColors.secondary.withValues(alpha: 0.1),
          iconColor: AppColors.secondary,
          badgeBg: AppColors.secondary.withValues(alpha: 0.1),
          badgeColor: AppColors.secondary,
          progressColor: AppColors.secondary,
        );
    }
  }
}

class _StatusConfig {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color badgeBg;
  final Color badgeColor;
  final Color progressColor;

  const _StatusConfig({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.badgeBg,
    required this.badgeColor,
    required this.progressColor,
  });
}
