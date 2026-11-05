import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';
import 'package:portfolio/domain/entities/profile_entity.dart';
import 'package:portfolio/presentation/widgets/social_button.dart';

class HeroSection extends StatefulWidget {
  final ProfileEntity profile;
  final VoidCallback? onViewProjects;
  final VoidCallback? onContactMe;

  const HeroSection({
    super.key,
    required this.profile,
    this.onViewProjects,
    this.onContactMe,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);
    final screenWidth = Responsive.screenWidth(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 600 : 700,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.background,
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Main content
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
                vertical: isMobile ? 80 : 100,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: isDesktop
                      ? _buildDesktopLayout(screenWidth)
                      : _buildMobileLayout(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: _buildTextContent(),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildAvatarPlaceholder(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAvatarPlaceholder(size: 160),
        const SizedBox(height: 40),
        _buildTextContent(centered: true),
      ],
    );
  }

  Widget _buildTextContent({bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Hello, I\'m',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.grey400,
            letterSpacing: 2,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ).createShader(bounds),
          child: Text(
            widget.profile.name,
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 36 : 52,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              height: 1.2,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.profile.title,
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 20 : 24,
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
            letterSpacing: 0.5,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            widget.profile.bio,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.grey400,
              height: 1.7,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 32),
        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildPrimaryButton(
              label: 'View Projects',
              icon: Icons.rocket_launch_outlined,
              onPressed: widget.onViewProjects,
            ),
            _buildOutlineButton(
              label: 'Contact Me',
              icon: Icons.mail_outline,
              onPressed: widget.onContactMe,
            ),
          ],
        ),
        const SizedBox(height: 36),
        // Social icons
        Row(
          mainAxisSize: MainAxisSize.min,
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

  Widget _buildAvatarPlaceholder({double size = 280}) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.3),
              AppColors.secondary.withValues(alpha: 0.2),
            ],
          ),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.person,
            size: size * 0.4,
            color: AppColors.primary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return _HoverButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xFF8B85FF)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return _HoverButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const _HoverButton({required this.child, this.onPressed});

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: widget.child,
        ),
      ),
    );
  }
}

