import 'package:portfolio/domain/entities/education_entity.dart';

class EducationModel extends EducationEntity {
  const EducationModel({
    required super.degree,
    required super.institution,
    required super.year,
    required super.description,
    super.courses = const [],
    super.volunteerWork = const [],
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      degree: json['degree'] as String,
      institution: json['institution'] as String,
      year: json['year'] as String,
      description: json['description'] as String,
      courses: (json['courses'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      volunteerWork: (json['volunteerWork'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'year': year,
      'description': description,
      'courses': courses,
      'volunteerWork': volunteerWork,
    };
  }
}
