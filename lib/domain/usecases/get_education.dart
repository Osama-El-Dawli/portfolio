import 'package:portfolio/domain/entities/education_entity.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';

class GetEducation {
  final PortfolioRepository repository;

  const GetEducation(this.repository);

  List<EducationEntity> call() {
    return repository.getEducation();
  }
}
