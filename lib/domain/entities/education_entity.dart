class EducationEntity {
  final String degree;
  final String institution;
  final String year;
  final String description;
  final List<String> courses;
  final List<String> volunteerWork;

  const EducationEntity({
    required this.degree,
    required this.institution,
    required this.year,
    required this.description,
    this.courses = const [],
    this.volunteerWork = const [],
  });

  String get duration => year;
}
