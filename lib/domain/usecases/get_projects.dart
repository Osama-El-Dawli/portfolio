import 'package:portfolio/domain/entities/project_entity.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';

class GetProjects {
  final PortfolioRepository repository;

  const GetProjects(this.repository);

  List<ProjectEntity> call() {
    return repository.getProjects();
  }
}
