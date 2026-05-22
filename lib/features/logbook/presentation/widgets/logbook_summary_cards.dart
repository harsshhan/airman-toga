import 'package:airman_toga/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../data/model/logbook_summary.dart';

class LogbookSummaryCards extends StatelessWidget {
  final LogbookSummary summary;

  const LogbookSummaryCards({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: 'TOTAL HOURS',
                value: '${summary.totalHours}',
                unit: 'hrs',
                bgColor: const Color(0xFF2A3441),
                valueColor: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'SOLO HOURS',
                value: '${summary.soloHours}',
                unit: 'hrs',
                bgColor: const Color(0xFF1B312A),
                valueColor: const Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: 'DUAL HOURS',
                value: '${summary.dualHours}',
                unit: 'hrs',
                bgColor: const Color(0xFF132A46),
                valueColor: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'LAST FLIGHT',
                value: _formatDate(summary.lastFlight),
                unit: _formatYear(summary.lastFlight),
                bgColor: const Color(0xFF332D19),
                valueColor: const Color(0xFFFFC107),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(String dateStr) {
    final parts = dateStr.split(' ');
    if (parts.length >= 2) {
      return '${parts[0]} ${parts[1]}';
    }
    return dateStr;
  }

  String _formatYear(String dateStr) {
    final parts = dateStr.split(' ');
    if (parts.length >= 3) {
      return parts[2];
    }
    return '';
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color bgColor;
  final Color valueColor;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.bgColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textHint,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
