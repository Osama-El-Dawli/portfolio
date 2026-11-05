import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.grey400,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 48),
      ],
    );
  }
}

