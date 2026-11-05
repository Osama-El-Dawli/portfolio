import 'package:portfolio/domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.title,
    required super.company,
    required super.duration,
    required super.description,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      title: json['title'] as String,
      company: json['company'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'duration': duration,
      'description': description,
    };
  }
}
