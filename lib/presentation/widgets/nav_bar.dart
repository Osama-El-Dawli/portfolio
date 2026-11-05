import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final List<String> sections;
  final int activeIndex;
  final ValueChanged<int> onSectionTap;
  final VoidCallback? onLogoTap;

  const NavBar({
    super.key,
    required this.sections,
    required this.activeIndex,
    required this.onSectionTap,
    this.onLogoTap,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: AppColors.grey800.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo / Name
                  _buildLogo(),
                  // Desktop nav links
                  if (!isMobile)
                    Row(
                      children: List.generate(widget.sections.length, (index) {
                        return _NavLink(
                          label: widget.sections[index],
                          isActive: widget.activeIndex == index,
                          onTap: () => widget.onSectionTap(index),
                        );
                      }),
                    ),
                  // Mobile hamburger
                  if (isMobile)
                    IconButton(
                      icon: Icon(
                        _isDrawerOpen ? Icons.close : Icons.menu,
                        color: AppColors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() => _isDrawerOpen = !_isDrawerOpen);
                        if (_isDrawerOpen) {
                          _showMobileDrawer(context);
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () {
        if (widget.onLogoTap != null) {
          widget.onLogoTap!();
        } else {
          widget.onSectionTap(0);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'O',
                  style: TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Osama Saeid',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            border: Border.all(color: AppColors.grey800),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey700,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(widget.sections.length, (index) {
                final isActive = widget.activeIndex == index;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    _getSectionIcon(index),
                    color: isActive ? AppColors.primary : AppColors.grey500,
                    size: 22,
                  ),
                  title: Text(
                    widget.sections[index],
                    style: TextStyle(
                      color: isActive ? AppColors.primary : AppColors.white,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _isDrawerOpen = false);
                    widget.onSectionTap(index);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    ).whenComplete(() {
      if (mounted) setState(() => _isDrawerOpen = false);
    });
  }

  IconData _getSectionIcon(int index) {
    const icons = [
      Icons.person_outline,
      Icons.work_outline,
      Icons.rocket_launch_outlined,
      Icons.code,
      Icons.school_outlined,
      Icons.mail_outline,
    ];
    return index < icons.length ? icons[index] : Icons.circle_outlined;
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = widget.isActive || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      isHighlighted ? FontWeight.w600 : FontWeight.w500,
                  color: isHighlighted ? AppColors.primary : AppColors.grey400,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isHighlighted ? 20 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

