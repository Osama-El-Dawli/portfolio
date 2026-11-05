import 'package:portfolio/domain/entities/skill_entity.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';

class GetSkills {
  final PortfolioRepository repository;

  const GetSkills(this.repository);

  List<SkillEntity> call() {
    return repository.getSkills();
  }
}
