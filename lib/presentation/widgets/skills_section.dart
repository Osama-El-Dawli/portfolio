import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/skill_entity.dart';
import 'package:portfolio/presentation/widgets/animated_skill_bar.dart';
import 'package:portfolio/presentation/widgets/section_title.dart';

class SkillsSection extends StatefulWidget {
  final List<SkillEntity> skills;

  const SkillsSection({
    super.key,
    required this.skills,
  });

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _animateSkills = false;
  final GlobalKey _sectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Trigger animation after a brief delay to simulate "in view"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _animateSkills = true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    final technicalSkills =
        widget.skills.where((s) => s.category == 'technical').toList();
    final softSkills =
        widget.skills.where((s) => s.category == 'soft').toList();

    // Color cycle for skill bars
    final skillColors = [
      AppColors.primary,
      AppColors.secondary,
      const Color(0xFF00E676),
      const Color(0xFFFF6B6B),
      const Color(0xFFFFD93D),
      AppColors.primary,
      AppColors.secondary,
      const Color(0xFF00E676),
      const Color(0xFFFF6B6B),
      const Color(0xFFFFD93D),
    ];

    return Container(
      key: _sectionKey,
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Skills',
                subtitle: 'Technologies and tools I work with',
              ),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTechnicalSkills(
                          technicalSkills, skillColors),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      child: _buildSoftSkills(softSkills),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildTechnicalSkills(technicalSkills, skillColors),
                    const SizedBox(height: 48),
                    _buildSoftSkills(softSkills),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechnicalSkills(
      List<SkillEntity> skills, List<Color> colors) {
    return Column(
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
                Icons.code,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Technical Skills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...List.generate(skills.length, (index) {
          return AnimatedSkillBar(
            label: skills[index].name,
            percentage: skills[index].proficiency.toDouble(),
            color: colors[index % colors.length],
            animate: _animateSkills,
          );
        }),
      ],
    );
  }

  Widget _buildSoftSkills(List<SkillEntity> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.psychology_outlined,
                color: AppColors.secondary,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Soft Skills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map((skill) {
            return _SoftSkillChip(skill: skill);
          }).toList(),
        ),
      ],
    );
  }
}

class _SoftSkillChip extends StatefulWidget {
  final SkillEntity skill;

  const _SoftSkillChip({required this.skill});

  @override
  State<_SoftSkillChip> createState() => _SoftSkillChipState();
}

class _SoftSkillChipState extends State<_SoftSkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.secondary.withValues(alpha: 0.15)
              : AppColors.cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? AppColors.secondary.withValues(alpha: 0.5)
                : AppColors.grey800,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 16,
              color: _isHovered ? AppColors.secondary : AppColors.grey500,
            ),
            const SizedBox(width: 8),
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: 14,
                color: _isHovered ? AppColors.secondary : AppColors.grey300,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

