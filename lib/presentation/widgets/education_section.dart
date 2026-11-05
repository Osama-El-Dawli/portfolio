import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/education_entity.dart';
import 'package:portfolio/presentation/widgets/section_title.dart';

class EducationSection extends StatelessWidget {
  final List<EducationEntity> education;

  const EducationSection({
    super.key,
    required this.education,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Education',
                subtitle: 'My academic background',
              ),
              ...education.map((edu) => _buildEducationCard(edu, isMobile)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCard(EducationEntity edu, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey800),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.secondary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.school_outlined,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edu.degree,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        edu.institution,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (edu.duration.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            edu.duration,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (edu.description.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                edu.description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey400,
                  height: 1.6,
                ),
              ),
            ],
            // Courses
            if (edu.courses.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Relevant Courses',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: edu.courses.map((course) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.grey800,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.menu_book_outlined,
                          size: 14,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          course,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grey300,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
            // Volunteer work
            if (edu.volunteerWork.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Volunteer Work',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 12),
              ...edu.volunteerWork.map((work) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: const Icon(
                          Icons.volunteer_activism_outlined,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          work,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.grey400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}

