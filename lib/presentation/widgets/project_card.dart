import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/domain/entities/project_entity.dart';

class ProjectCard extends StatefulWidget {
  final ProjectEntity project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;
  bool _isExpanded = false;

  IconData _getProjectIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('chat') || lower.contains('message')) {
      return Icons.chat_bubble_outline;
    }
    if (lower.contains('shop') || lower.contains('store') || lower.contains('e-commerce') || lower.contains('ecommerce')) {
      return Icons.shopping_bag_outlined;
    }
    if (lower.contains('news') || lower.contains('blog')) {
      return Icons.article_outlined;
    }
    if (lower.contains('weather')) return Icons.cloud_outlined;
    if (lower.contains('food') || lower.contains('recipe') || lower.contains('restaurant')) {
      return Icons.restaurant_outlined;
    }
    if (lower.contains('music') || lower.contains('audio')) {
      return Icons.music_note_outlined;
    }
    if (lower.contains('health') || lower.contains('fitness')) {
      return Icons.favorite_outline;
    }
    if (lower.contains('education') || lower.contains('learn') || lower.contains('quiz')) {
      return Icons.school_outlined;
    }
    if (lower.contains('note') || lower.contains('todo') || lower.contains('task')) {
      return Icons.note_alt_outlined;
    }
    return Icons.code;
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.02, 1.02, 1.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.grey800,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon + Title row
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.2),
                          AppColors.secondary.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getProjectIcon(project.name),
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            project.platform,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Description
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Text(
                    project.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey400,
                      height: 1.6,
                    ),
                  ),
                  secondChild: Text(
                    project.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey400,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              if (project.description.length > 100)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: Text(
                      _isExpanded ? 'Show less' : 'Read more...',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              // Tech Stack chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.technologies.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Achievements
              if (project.achievements.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Divider(color: AppColors.grey800, height: 1),
                const SizedBox(height: 12),
                ...project.achievements.take(3).map((achievement) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.emoji_events_outlined,
                          size: 14,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey400,
                              height: 1.4,
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
      ),
    );
  }
}

