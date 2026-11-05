import 'package:portfolio/domain/entities/profile_entity.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';

class GetProfile {
  final PortfolioRepository repository;

  const GetProfile(this.repository);

  ProfileEntity call() {
    return repository.getProfile();
  }
}
