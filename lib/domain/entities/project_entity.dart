import 'package:flutter/material.dart';

class ProjectEntity {
  final String title;
  final String subtitle;
  final String description;
  final List<String> technologies;
  final List<String> achievements;
  final List<String> platforms;
  final IconData iconData;

  const ProjectEntity({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.technologies,
    required this.achievements,
    required this.platforms,
    required this.iconData,
  });

  String get name => title;
  String get platform => platforms.isNotEmpty ? platforms.join(' & ') : subtitle;
}
