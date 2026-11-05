import 'package:flutter/material.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/project_entity.dart';
import 'package:portfolio/presentation/widgets/project_card.dart';
import 'package:portfolio/presentation/widgets/section_title.dart';

class ProjectsSection extends StatelessWidget {
  final List<ProjectEntity> projects;

  const ProjectsSection({
    super.key,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    int crossAxisCount;
    if (isDesktop) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                title: 'Projects',
                subtitle: 'Some of the work I\'ve built',
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isDesktop ? 1.1 : 1.15,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(project: projects[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

