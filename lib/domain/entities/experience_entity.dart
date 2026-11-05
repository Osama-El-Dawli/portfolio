class ExperienceEntity {
  final String title;
  final String company;
  final String duration;
  final String description;

  const ExperienceEntity({
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
  });

  String get role => title;
}
