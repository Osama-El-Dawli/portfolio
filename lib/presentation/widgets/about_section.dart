import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/profile_entity.dart';
import 'package:portfolio/presentation/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  final ProfileEntity profile;

  const AboutSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(
                title: 'About Me',
                subtitle: 'Get to know me better',
              ),
              // Bio text
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  profile.bio,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey400,
                    height: 1.8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              // Info cards
              LayoutBuilder(
                builder: (context, constraints) {
                  if (isMobile) {
                    return Column(
                      children: [
                        _buildInfoCard(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: profile.email,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: profile.phone,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.location_on_outlined,
                          label: 'Location',
                          value: profile.location,
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: profile.email,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: profile.phone,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.location_on_outlined,
                          label: 'Location',
                          value: profile.location,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.grey800,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.grey500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

