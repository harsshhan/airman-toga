import 'package:airman_toga/features/auth/data/model/cadet_profile.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class CadetProfileCard extends StatelessWidget {
  final CadetProfile profile;
  final VoidCallback onContinue;
  final bool isLoading;

  const CadetProfileCard({
    super.key,
    required this.profile,
    required this.onContinue,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 48,
                width: 48,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: const Icon(
                  Icons.person_outline,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  icon: Icons.school_outlined,
                  title: "FTO",
                  value: profile.fto,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _InfoCard(
                  icon: Icons.person_outline,
                  title: "INSTRUCTOR",
                  value: profile.instructor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  icon: Icons.location_on_outlined,
                  title: "BASE",
                  value: profile.base,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _InfoCard(
                  icon: Icons.flight_takeoff,
                  title: "COURSE",
                  value: profile.course,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,

                foregroundColor: AppColors.textwhite,

                padding: const EdgeInsets.symmetric(vertical: 16),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: isLoading ? null : onContinue,

              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,

                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("Authenticating..."),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Text("Continue to Dashboard"),

                        const SizedBox(width: 8),

                        const Icon(Icons.chevron_right, size: 18),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

      decoration: BoxDecoration(
        color: AppColors.secondary,

        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: AppColors.whitebackground,

        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.secondary),

              const SizedBox(width: 4),

              Text(
                title,

                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            value,

            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
