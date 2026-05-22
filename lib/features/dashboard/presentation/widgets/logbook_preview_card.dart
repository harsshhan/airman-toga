import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/logbook_preview.dart';

class LogbookPreviewCard extends StatelessWidget {
  final LogbookSummary logbook;
  final VoidCallback? onViewAll;

  const LogbookPreviewCard({
    super.key,
    required this.logbook,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LOGBOOK',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
              GestureDetector(
                onTap: onViewAll,
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LogbookStat(
                value: '${logbook.totalHours}',
                label: 'Total Hrs',
                valueColor: AppColors.textPrimary,
              ),
              const SizedBox(width: 20),
              _LogbookStat(
                value: '${logbook.soloHours}',
                label: 'Solo Hrs',
                valueColor: AppColors.success,
              ),
              const SizedBox(width: 20),
              _LogbookStat(
                value: _formatDate(logbook.lastFlight),
                label: 'Last Flt',
                valueColor: AppColors.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    final parts = date.split(' ');
    if (parts.length >= 2) {
      return '${parts[0]} ${parts[1]}';
    }
    return date;
  }
}

class _LogbookStat extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _LogbookStat({
    required this.value,
    required this.label,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
