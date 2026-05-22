import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/model/chapter.dart';
import '../../data/model/study_subject.dart';

class SubjectDetailScreen extends StatelessWidget {
  final StudySubject subject;

  const SubjectDetailScreen({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: Column(
        children: [
          _buildHeader(context),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.whitebackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Chapters section label
                      const Text(
                        'CHAPTERS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                          letterSpacing: 1.4,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Chapter list
                      ...subject.chapters.asMap().entries.map((entry) {
                        final index = entry.key;
                        final chapter = entry.value;
                        return _buildChapterRow(
                          context,
                          chapter: chapter,
                          index: index,
                          isActive: _isActive(index),
                        );
                      }),

                      const SizedBox(height: 20),
                      const Text(
                        'TOOLS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                          letterSpacing: 1.4,
                        ),
                      ),

                      const SizedBox(height: 12),

                      GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.0,
                        children: [
                          _ToolCard(
                            icon: Icons.workspace_premium_outlined,
                            label: 'Quiz',
                            bgColor: const Color(0xFFE8F4FE),
                            iconColor: AppColors.secondary,
                            onTap: () {},
                          ),
                          _ToolCard(
                            icon: Icons.layers_outlined,
                            label: 'Flashcards',
                            bgColor: const Color(0xFFFFF9E6),
                            iconColor: const Color(0xFFE6A817),
                            onTap: () {},
                          ),
                          _ToolCard(
                            icon: Icons.bar_chart_rounded,
                            label: 'Practice Test',
                            bgColor: const Color(0xFFEDF7EE),
                            iconColor: AppColors.success,
                            onTap: () {},
                          ),
                          _ToolCard(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: 'Ask AIRMAN AI',
                            bgColor: const Color(0xFFF0EEFF),
                            iconColor: const Color(0xFF7C5CFC),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final progress = subject.progress / 100;

    return Container(
      color: AppColors.primarybackground,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.textwhite,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'STUDY',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textHint,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.more_horiz_rounded,
                      color: AppColors.textwhite,
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Subject icon + title
              Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.cloud_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject.subject,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textwhite,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${subject.lessonsCompleted} of ${subject.totalLessons} lessons complete',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Progress row
              Row(
                children: [
                  const Text(
                    'Overall progress',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${subject.progress}%',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textwhite,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChapterRow(
    BuildContext context, {
    required Chapter chapter,
    required int index,
    required bool isActive,
  }) {
    final chapterNumber = index + 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: isActive
            ? Border.all(color: AppColors.secondary, width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        leading: _buildLeadingIcon(chapter, chapterNumber, isActive),
        title: Text(
          chapter.chapter,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: chapter.completed || isActive
                ? AppColors.textPrimary
                : AppColors.textSecondary,
          ),
        ),
        subtitle: Text(
          '${chapter.lessonCount} lessons',
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: _buildTrailing(chapter, isActive),
      ),
    );
  }

  Widget _buildLeadingIcon(Chapter chapter, int number, bool isActive) {
    if (chapter.completed) {
      return Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_rounded,
          color: AppColors.success,
          size: 18,
        ),
      );
    }

    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.secondary.withValues(alpha: 0.12)
            : AppColors.progressBackground,
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(color: AppColors.secondary, width: 1.5)
            : null,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive ? AppColors.secondary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget? _buildTrailing(Chapter chapter, bool isActive) {
    if (chapter.completed) {
      return const Text(
        'Done',
        style: TextStyle(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      );
    }
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Active',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
          ),
        ),
      );
    }
    return const Icon(
      Icons.chevron_right_rounded,
      color: AppColors.textSecondary,
      size: 20,
    );
  }

  // First incomplete chapter = active
  bool _isActive(int index) {
    final completedCount =
        subject.chapters.where((c) => c.completed).length;
    return index == completedCount &&
        index < subject.chapters.length;
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _ToolCard({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
