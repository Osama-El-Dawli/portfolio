import 'package:portfolio/domain/entities/education_entity.dart';
import 'package:portfolio/domain/entities/experience_entity.dart';
import 'package:portfolio/domain/entities/profile_entity.dart';
import 'package:portfolio/domain/entities/project_entity.dart';
import 'package:portfolio/domain/entities/skill_entity.dart';

abstract class PortfolioRepository {
  ProfileEntity getProfile();
  List<ExperienceEntity> getExperience();
  List<ProjectEntity> getProjects();
  List<SkillEntity> getSkills();
  List<EducationEntity> getEducation();
}
