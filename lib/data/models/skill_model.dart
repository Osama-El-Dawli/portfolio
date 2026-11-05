import 'package:flutter/material.dart';
import 'package:portfolio/domain/entities/skill_entity.dart';

class SkillModel extends SkillEntity {
  const SkillModel({
    required super.name,
    required super.percentage,
    required super.category,
    required super.iconData,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      category: json['category'] as String,
      iconData: Icons.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'percentage': percentage,
      'category': category,
    };
  }
}
