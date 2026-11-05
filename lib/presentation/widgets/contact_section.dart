import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/profile_entity.dart';
import 'package:portfolio/presentation/widgets/section_title.dart';
import 'package:portfolio/presentation/widgets/social_button.dart';

class ContactSection extends StatefulWidget {
  final ProfileEntity profile;

  const ContactSection({
    super.key,
    required this.profile,
  });

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

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
                title: 'Get In Touch',
                subtitle:
                    'Have a project in mind or want to say hello? Feel free to reach out!',
              ),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildContactInfo(),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 3,
                      child: _buildContactForm(),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildContactInfo(),
                    const SizedBox(height: 40),
                    _buildContactForm(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Information',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Feel free to reach out through any of these channels.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.grey400,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        _buildContactInfoCard(
          icon: Icons.email_outlined,
          label: 'Email',
          value: widget.profile.email,
        ),
        const SizedBox(height: 16),
        _buildContactInfoCard(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: widget.profile.phone,
        ),
        const SizedBox(height: 16),
        _buildContactInfoCard(
          icon: Icons.location_on_outlined,
          label: 'Location',
          value: widget.profile.location,
        ),
        const SizedBox(height: 32),
        // Social links
        const Text(
          'Find me on',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            SocialButton(
              icon: Icons.code,
              tooltip: 'GitHub',
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            SocialButton(
              icon: Icons.business_center_outlined,
              tooltip: 'LinkedIn',
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            SocialButton(
              icon: Icons.email_outlined,
              tooltip: 'Email',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey800),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.grey800),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send a Message',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            controller: _nameController,
            label: 'Your Name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            label: 'Your Email',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _messageController,
            label: 'Your Message',
            icon: Icons.message_outlined,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          _SendButton(
            onPressed: () {
              // No backend logic—just UI
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Message sent! (UI only)'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.white, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.grey500, fontSize: 14),
        prefixIcon: maxLines == 1
            ? Icon(icon, color: AppColors.grey500, size: 20)
            : null,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grey800),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grey800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 0,
        ),
      ),
    );
  }
}

class _SendButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const _SendButton({this.onPressed});

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [const Color(0xFF8B85FF), AppColors.primary]
                  : [AppColors.primary, const Color(0xFF8B85FF)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.send, color: AppColors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'Send Message',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

