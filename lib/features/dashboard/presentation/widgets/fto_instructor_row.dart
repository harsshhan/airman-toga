import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/dashboard_data.dart';

class FtoInstructorRow extends StatelessWidget {
  final DashboardData data;
  final VoidCallback? onFtoTap;
  final VoidCallback? onInstructorTap;

  const FtoInstructorRow({
    super.key,
    required this.data,
    this.onFtoTap,
    this.onInstructorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoCard(
            icon: Icons.school_outlined,
            sectionLabel: 'FTO',
            title: data.assignedFto,
            subtitle: data.assignedFtoDetails,
            onTap: onFtoTap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _InfoCard(
            icon: Icons.person_outline_rounded,
            sectionLabel: 'INSTRUCTOR',
            title: data.assignedInstructor,
            subtitle: data.assignedInstructorDetails,
            onTap: onInstructorTap,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String sectionLabel;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _InfoCard({
    required this.icon,
    required this.sectionLabel,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: AppColors.whitebackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              sectionLabel,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
