import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/experience_entity.dart';
import 'package:portfolio/presentation/widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  final List<ExperienceEntity> experiences;

  const ExperienceSection({
    super.key,
    required this.experiences,
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
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Experience',
                subtitle: 'My professional journey',
              ),
              ...List.generate(experiences.length, (index) {
                final experience = experiences[index];
                final isLast = index == experiences.length - 1;
                return _buildTimelineItem(
                  experience: experience,
                  isLast: isLast,
                  index: index,
                  isMobile: isMobile,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required ExperienceEntity experience,
    required bool isLast,
    required int index,
    required bool isMobile,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.5),
                            AppColors.primary.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Card content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _ExperienceCard(experience: experience),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceEntity experience;

  const _ExperienceCard({required this.experience});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final experience = widget.experience;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.grey800,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.role,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        experience.company,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                experience.duration,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (experience.description.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                experience.description,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey400,
                  height: 1.6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

