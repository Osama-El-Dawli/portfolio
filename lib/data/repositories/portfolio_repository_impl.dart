import 'package:portfolio/data/datasources/mock_portfolio_datasource.dart';
import 'package:portfolio/domain/entities/education_entity.dart';
import 'package:portfolio/domain/entities/experience_entity.dart';
import 'package:portfolio/domain/entities/profile_entity.dart';
import 'package:portfolio/domain/entities/project_entity.dart';
import 'package:portfolio/domain/entities/skill_entity.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final MockPortfolioDatasource datasource;

  const PortfolioRepositoryImpl({required this.datasource});

  @override
  ProfileEntity getProfile() {
    return datasource.getProfile();
  }

  @override
  List<ExperienceEntity> getExperience() {
    return datasource.getExperience();
  }

  @override
  List<ProjectEntity> getProjects() {
    return datasource.getProjects();
  }

  @override
  List<SkillEntity> getSkills() {
    return datasource.getSkills();
  }

  @override
  List<EducationEntity> getEducation() {
    return datasource.getEducation();
  }
}
