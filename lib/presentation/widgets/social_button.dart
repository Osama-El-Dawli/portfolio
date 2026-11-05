import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class SocialButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;

  const SocialButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.size = 44,
    this.color,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? AppColors.primary;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: _isHovered
                  ? effectiveColor.withValues(alpha: 0.15)
                  : Colors.transparent,
              border: Border.all(
                color: _isHovered
                    ? effectiveColor
                    : AppColors.grey700,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: effectiveColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: AnimatedScale(
                scale: _isHovered ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  widget.icon,
                  color: _isHovered ? effectiveColor : AppColors.grey400,
                  size: widget.size * 0.45,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

