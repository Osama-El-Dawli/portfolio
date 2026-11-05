import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/skill_entity.dart';
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
  String _selectedCategory = 'All';

  final List<String> _categories = const [
    'All',
    'Mobile & Frameworks',
    'Architecture & State',
    'Backend & Storage',
    'Tools & DevOps',
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    final technicalSkills =
        widget.skills.where((s) => s.category == 'technical').toList();
    final softSkills =
        widget.skills.where((s) => s.category == 'soft').toList();

    final filteredSkills = _filterSkills(technicalSkills);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.25),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.grey800.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle(
                title: 'Skills & Expertise',
                subtitle:
                    'Technologies, frameworks, and architectural patterns I specialize in',
              ),

              // -------------------------------------------------------------
              // 1. FILTER TABS
              // -------------------------------------------------------------
              _buildFilterTabs(isMobile),
              const SizedBox(height: 36),

              // -------------------------------------------------------------
              // 2. TECHNICAL SKILLS GRID
              // -------------------------------------------------------------
              _buildTechnicalSkillsGrid(filteredSkills, isDesktop, isMobile),
              const SizedBox(height: 70),

              // -------------------------------------------------------------
              // 3. SOFT SKILLS & LEADERSHIP CARDS
              // -------------------------------------------------------------
              _buildSoftSkillsSection(softSkills, isDesktop, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FILTERING LOGIC
  // ---------------------------------------------------------------------------
  List<SkillEntity> _filterSkills(List<SkillEntity> allSkills) {
    if (_selectedCategory == 'All') return allSkills;

    if (_selectedCategory == 'Mobile & Frameworks') {
      return allSkills
          .where((s) =>
              s.name.contains('Flutter') ||
              s.name.contains('Dart'))
          .toList();
    } else if (_selectedCategory == 'Architecture & State') {
      return allSkills
          .where((s) =>
              s.name.contains('Bloc') ||
              s.name.contains('Clean Architecture'))
          .toList();
    } else if (_selectedCategory == 'Backend & Storage') {
      return allSkills
          .where((s) =>
              s.name.contains('Firebase') ||
              s.name.contains('Supabase') ||
              s.name.contains('Hive') ||
              s.name.contains('REST'))
          .toList();
    } else if (_selectedCategory == 'Tools & DevOps') {
      return allSkills
          .where((s) =>
              s.name.contains('Git') ||
              s.name.contains('CI/CD'))
          .toList();
    }
    return allSkills;
  }

  // ---------------------------------------------------------------------------
  // FILTER TABS BAR
  // ---------------------------------------------------------------------------
  Widget _buildFilterTabs(bool isMobile) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _categories.map((cat) {
        final isSelected = _selectedCategory == cat;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.card.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.grey800,
                width: 1.2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              cat,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.background : AppColors.grey300,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ---------------------------------------------------------------------------
  // TECHNICAL SKILLS GRID
  // ---------------------------------------------------------------------------
  Widget _buildTechnicalSkillsGrid(
    List<SkillEntity> skills,
    bool isDesktop,
    bool isMobile,
  ) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    int crossAxisCount = 3;
    if (screenWidth < 680) {
      crossAxisCount = 1;
    } else if (screenWidth < 1050) {
      crossAxisCount = 2;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: skills.map((skill) {
            return SizedBox(
              width: itemWidth,
              child: _TechSkillCard(skill: skill),
            );
          }).toList(),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // SOFT SKILLS & LEADERSHIP SECTION
  // ---------------------------------------------------------------------------
  Widget _buildSoftSkillsSection(
    List<SkillEntity> softSkills,
    bool isDesktop,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.emoji_events_outlined,
                color: AppColors.secondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Leadership & Soft Skills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: softSkills.map((skill) {
            return _SoftSkillCard(skill: skill);
          }).toList(),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// ENHANCED TECH SKILL CARD (GLASSMORPHIC WITH GLOW & BADGES)
// ---------------------------------------------------------------------------
class _TechSkillCard extends StatefulWidget {
  final SkillEntity skill;

  const _TechSkillCard({required this.skill});

  @override
  State<_TechSkillCard> createState() => _TechSkillCardState();
}

class _TechSkillCardState extends State<_TechSkillCard> {
  bool _isHovered = false;

  List<String> _getSkillTags(String skillName) {
    switch (skillName.toLowerCase()) {
      case 'flutter':
        return ['Widgets', 'State', 'Responsive', 'Web & Mobile'];
      case 'dart':
        return ['OOP', 'Async / Await', 'Null Safety', 'Streams'];
      case 'cubit / bloc':
        return ['State Mgmt', 'Events & States', 'Streams', 'Reactive'];
      case 'clean architecture':
        return ['Domain & Data', 'Use Cases', 'SOLID', 'Repository'];
      case 'firebase':
        return ['Auth', 'Cloud Firestore', 'Push Notifications'];
      case 'supabase':
        return ['PostgreSQL', 'Realtime', 'Auth', 'Storage'];
      case 'git & github':
        return ['Version Control', 'Branching', 'Pull Requests'];
      case 'hive':
        return ['NoSQL DB', 'TypeAdapters', 'Offline First'];
      case 'rest apis':
        return ['Dio / HTTP', 'JSON Parsing', 'Error Handling'];
      case 'ci/cd':
        return ['Workflows', 'Automated Build', 'Fastlane'];
      default:
        return ['Mobile Dev', 'Production Ready'];
    }
  }

  Color _getSkillAccentColor(String skillName) {
    switch (skillName.toLowerCase()) {
      case 'flutter':
      case 'supabase':
        return AppColors.secondary;
      case 'dart':
      case 'clean architecture':
        return AppColors.primary;
      case 'cubit / bloc':
        return const Color(0xFFFFB800);
      case 'firebase':
        return const Color(0xFFFF7A00);
      case 'git & github':
        return const Color(0xFFF05032);
      case 'hive':
        return const Color(0xFFFFD54F);
      case 'rest apis':
        return const Color(0xFF00E5FF);
      case 'ci/cd':
        return AppColors.accentViolet;
      default:
        return AppColors.primary;
    }
  }

  String _getLevelTitle(double percentage) {
    final p = percentage <= 1.0 ? percentage * 100 : percentage;
    if (p >= 88) return 'Advanced';
    if (p >= 80) return 'Proficient';
    return 'Intermediate';
  }

  @override
  Widget build(BuildContext context) {
    final skill = widget.skill;
    final accentColor = _getSkillAccentColor(skill.name);
    final tags = _getSkillTags(skill.name);
    final level = _getLevelTitle(skill.percentage);
    final double rawPercent = skill.percentage <= 1.0 ? skill.percentage * 100 : skill.percentage;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, -6, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.cardHover
              : AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isHovered
                ? accentColor.withValues(alpha: 0.7)
                : AppColors.cardBorder,
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? accentColor.withValues(alpha: 0.22)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: _isHovered ? 24 : 10,
              offset: Offset(0, _isHovered ? 10 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon Container + Level Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      skill.iconData,
                      color: accentColor,
                      size: 24,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    level,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Skill Name
            Text(
              skill.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 12),

            // Feature / Sub-topic Chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.grey800,
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.grey400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),

            // Bottom Progress Bar & Percentage
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proficiency',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: AppColors.grey500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${rawPercent.toInt()}%',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      widthFactor: math.min(1.0, rawPercent / 100),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accentColor.withValues(alpha: 0.7), accentColor],
                          ),
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ENHANCED SOFT SKILL CARD
// ---------------------------------------------------------------------------
class _SoftSkillCard extends StatefulWidget {
  final SkillEntity skill;

  const _SoftSkillCard({required this.skill});

  @override
  State<_SoftSkillCard> createState() => _SoftSkillCardState();
}

class _SoftSkillCardState extends State<_SoftSkillCard> {
  bool _isHovered = false;

  String _getDescription(String name) {
    switch (name.toLowerCase()) {
      case 'communication skills':
        return 'Clear documentation, active listening & cross-functional coordination';
      case 'presentation skills':
        return 'Presented before University President & featured in TV media interviews';
      case 'time management':
        return 'Agile sprint planning, prioritization & consistently meeting deadlines';
      case 'problem solving':
        return 'Algorithmic efficiency, clean debugging & systematic root-cause analysis';
      default:
        return 'Team leadership, dedication to excellence & collaborative spirit';
    }
  }

  @override
  Widget build(BuildContext context) {
    final skill = widget.skill;
    final desc = _getDescription(skill.name);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 270,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.cardHover
              : AppColors.card.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.secondary.withValues(alpha: 0.6)
                : AppColors.grey800,
            width: 1.2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    skill.iconData,
                    size: 18,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    skill.name,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              desc,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.grey400,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
