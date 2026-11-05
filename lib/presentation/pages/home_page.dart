import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/data/datasources/mock_portfolio_datasource.dart';
import 'package:portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:portfolio/domain/entities/education_entity.dart';
import 'package:portfolio/domain/entities/experience_entity.dart';
import 'package:portfolio/domain/entities/profile_entity.dart';
import 'package:portfolio/domain/entities/project_entity.dart';
import 'package:portfolio/domain/entities/skill_entity.dart';
import 'package:portfolio/domain/usecases/get_education.dart';
import 'package:portfolio/domain/usecases/get_experience.dart';
import 'package:portfolio/domain/usecases/get_profile.dart';
import 'package:portfolio/domain/usecases/get_projects.dart';
import 'package:portfolio/domain/usecases/get_skills.dart';
import 'package:portfolio/presentation/widgets/about_section.dart';
import 'package:portfolio/presentation/widgets/contact_section.dart';
import 'package:portfolio/presentation/widgets/education_section.dart';
import 'package:portfolio/presentation/widgets/experience_section.dart';
import 'package:portfolio/presentation/widgets/footer_widget.dart';
import 'package:portfolio/presentation/widgets/hero_section.dart';
import 'package:portfolio/presentation/widgets/nav_bar.dart';
import 'package:portfolio/presentation/widgets/projects_section.dart';
import 'package:portfolio/presentation/widgets/skills_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Clean Architecture dependencies
  late final MockPortfolioDatasource _datasource;
  late final PortfolioRepositoryImpl _repository;
  late final GetProfile _getProfile;
  late final GetExperience _getExperience;
  late final GetProjects _getProjects;
  late final GetSkills _getSkills;
  late final GetEducation _getEducation;

  // Domain data loaded via Clean Architecture use cases
  late final ProfileEntity _profile;
  late final List<ExperienceEntity> _experiences;
  late final List<ProjectEntity> _projects;
  late final List<SkillEntity> _skills;
  late final List<EducationEntity> _education;

  // Keys for scrolling to sections
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  int _activeNavIndex = 0;
  bool _showBackToTop = false;

  final List<String> _navSections = const [
    'About',
    'Experience',
    'Projects',
    'Skills',
    'Education',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _initCleanArchitecture();
    _scrollController.addListener(_onScroll);
  }

  void _initCleanArchitecture() {
    // 1. Data Source
    _datasource = MockPortfolioDatasource();

    // 2. Repository Implementation
    _repository = PortfolioRepositoryImpl(datasource: _datasource);

    // 3. Domain Use Cases
    _getProfile = GetProfile(_repository);
    _getExperience = GetExperience(_repository);
    _getProjects = GetProjects(_repository);
    _getSkills = GetSkills(_repository);
    _getEducation = GetEducation(_repository);

    // 4. Fetch entities through use cases
    _profile = _getProfile();
    _experiences = _getExperience();
    _projects = _getProjects();
    _skills = _getSkills();
    _education = _getEducation();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (offset <= 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onNavSectionTap(int index) {
    setState(() => _activeNavIndex = index);
    switch (index) {
      case 0:
        _scrollToKey(_aboutKey);
        break;
      case 1:
        _scrollToKey(_experienceKey);
        break;
      case 2:
        _scrollToKey(_projectsKey);
        break;
      case 3:
        _scrollToKey(_skillsKey);
        break;
      case 4:
        _scrollToKey(_educationKey);
        break;
      case 5:
        _scrollToKey(_contactKey);
        break;
      default:
        _scrollToKey(_heroKey);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Top spacing so content doesn't hide behind fixed NavBar
                const SizedBox(height: 72),

                // Hero Section
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    profile: _profile,
                    onViewProjects: () => _scrollToKey(_projectsKey),
                    onContactMe: () => _scrollToKey(_contactKey),
                  ),
                ),

                // About Me Section
                Container(
                  key: _aboutKey,
                  child: AboutSection(profile: _profile),
                ),

                // Experience Section
                Container(
                  key: _experienceKey,
                  child: ExperienceSection(experiences: _experiences),
                ),

                // Projects Section
                Container(
                  key: _projectsKey,
                  child: ProjectsSection(projects: _projects),
                ),

                // Skills Section
                Container(
                  key: _skillsKey,
                  child: SkillsSection(skills: _skills),
                ),

                // Education Section
                Container(
                  key: _educationKey,
                  child: EducationSection(education: _education),
                ),

                // Contact Section
                Container(
                  key: _contactKey,
                  child: ContactSection(profile: _profile),
                ),

                // Footer
                const FooterWidget(),
              ],
            ),
          ),

          // Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              sections: _navSections,
              activeIndex: _activeNavIndex,
              onSectionTap: (index) {
                if (index == 0 && _activeNavIndex == 0) {
                  // If logo or first clicked
                  _onNavSectionTap(index);
                } else {
                  _onNavSectionTap(index);
                }
              },
            ),
          ),

          // Floating Back To Top Button
          if (_showBackToTop)
            Positioned(
              bottom: 30,
              right: 30,
              child: FloatingActionButton.small(
                onPressed: _scrollToTop,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textPrimary,
                tooltip: 'Back to top',
                child: const Icon(Icons.arrow_upward_rounded),
              ),
            ),
        ],
      ),
    );
  }
}

