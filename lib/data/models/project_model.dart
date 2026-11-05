import 'package:flutter/material.dart';
import 'package:portfolio/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.title,
    required super.subtitle,
    required super.description,
    required super.technologies,
    required super.achievements,
    required super.platforms,
    required super.iconData,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      achievements: List<String>.from(json['achievements'] as List),
      platforms: List<String>.from(json['platforms'] as List),
      iconData: Icons.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'technologies': technologies,
      'achievements': achievements,
      'platforms': platforms,
    };
  }
}
