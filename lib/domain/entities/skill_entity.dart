import 'package:flutter/material.dart';

class SkillEntity {
  final String name;
  final double percentage;
  final String category;
  final IconData iconData;

  const SkillEntity({
    required this.name,
    required this.percentage,
    required this.category,
    required this.iconData,
  });

  bool get isTechnical => category == 'technical';
  bool get isSoft => category == 'soft';
  double get proficiency => percentage;
}
