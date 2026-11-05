import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/app_colors.dart';

class AnimatedSkillBar extends StatefulWidget {
  final String label;
  final double percentage;
  final Color color;
  final bool animate;

  const AnimatedSkillBar({
    super.key,
    required this.label,
    required this.percentage,
    this.color = AppColors.primary,
    this.animate = false,
  });

  @override
  State<AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<AnimatedSkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.percentage / 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    if (widget.animate) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedSkillBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _controller.forward();
    }
    if (widget.percentage != oldWidget.percentage) {
      _animation = Tween<double>(
        begin: 0,
        end: widget.percentage / 100,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ));
      if (widget.animate) {
        _controller.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Text(
                    '${(_animation.value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.color,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _animation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.color,
                          widget.color.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

