import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/presentation/widgets/social_button.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.grey800,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _buildSocialRow(),
                    const SizedBox(height: 20),
                    _buildCopyright(),
                    const SizedBox(height: 8),
                    _buildBuiltWith(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCopyright(),
                        const SizedBox(height: 4),
                        _buildBuiltWith(),
                      ],
                    ),
                    _buildSocialRow(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© 2026 Osama Saeid. All rights reserved.',
      style: TextStyle(
        fontSize: 14,
        color: AppColors.grey500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBuiltWith() {
    return const Text(
      'Built with Flutter 💙',
      style: TextStyle(
        fontSize: 13,
        color: AppColors.grey500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSocialRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialButton(
          icon: Icons.code,
          tooltip: 'GitHub',
          size: 38,
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        SocialButton(
          icon: Icons.business_center_outlined,
          tooltip: 'LinkedIn',
          size: 38,
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        SocialButton(
          icon: Icons.email_outlined,
          tooltip: 'Email',
          size: 38,
          onPressed: () {},
        ),
      ],
    );
  }
}

