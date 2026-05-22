import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/dashboard_data.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final DashboardData data;

  const DashboardHeaderWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final firstName = data.cadetName.split(' ').first;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $firstName',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textwhite,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${data.trainingStage} · ${data.course}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.textwhite,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
