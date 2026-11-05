import 'package:portfolio/domain/entities/experience_entity.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';

class GetExperience {
  final PortfolioRepository repository;

  const GetExperience(this.repository);

  List<ExperienceEntity> call() {
    return repository.getExperience();
  }
}
