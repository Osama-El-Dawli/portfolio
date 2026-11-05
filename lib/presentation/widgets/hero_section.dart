import 'dart:async';
import 'dart:math' as math;

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
  // Entrance animations
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // Background ambient breathing animation
  late final AnimationController _ambientController;

  // Continuous rotating orbit ring
  late final AnimationController _orbitController;

  // Floating badges sine-wave animation
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();

    // 1. Entrance animation (runs once on load)
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );
    _entranceController.forward();

    // 2. Ambient background breathing animation (repeats smoothly)
    _ambientController = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    )..repeat(reverse: true);

    // 3. Continuous rotating orbit animation
    _orbitController = AnimationController(
      duration: const Duration(milliseconds: 16000),
      vsync: this,
    )..repeat();

    // 4. Continuous floating badge animation
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3200),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _ambientController.dispose();
    _orbitController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: math.max(620.0, screenHeight - 72),
      ),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColors.background),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // -----------------------------------------------------------------
          // 1. ANIMATED AMBIENT GLOWING MESH ORBS (BACKGROUND)
          // -----------------------------------------------------------------
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _ambientController,
                builder: (context, _) {
                  final val = _ambientController.value;
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Top-Right Neon Mint Glow
                      Positioned(
                        top: -120 + (val * 35),
                        right: -100 + (val * 25),
                        child: Container(
                          width: isMobile ? 320 : 520,
                          height: isMobile ? 320 : 520,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primary.withValues(
                                  alpha: 0.16 + (val * 0.08),
                                ),
                                AppColors.primary.withValues(alpha: 0.04),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.55, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Bottom-Left Cyan Glow
                      Positioned(
                        bottom: -100 + (val * -30),
                        left: -80 + (val * 20),
                        child: Container(
                          width: isMobile ? 280 : 480,
                          height: isMobile ? 280 : 480,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.secondary.withValues(
                                  alpha: 0.14 + (val * 0.06),
                                ),
                                AppColors.secondary.withValues(alpha: 0.03),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.55, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Center subtle Violet Accent Glow
                      Positioned(
                        top: 250 + (val * 20),
                        right: isDesktop ? 300 : 50,
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.accentViolet.withValues(
                                  alpha: 0.10 + (val * 0.05),
                                ),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.7],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // -----------------------------------------------------------------
          // 2. MAIN HERO CONTENT
          // -----------------------------------------------------------------
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
                vertical: 36,
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: isDesktop
                      ? _buildDesktopLayout()
                      : _buildMobileLayout(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 5,
          child: _buildAnimatedAvatarComposition(size: 340),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAnimatedAvatarComposition(size: 230),
        const SizedBox(height: 36),
        _buildTextContent(centered: true),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // LEFT COLUMN / TEXT CONTENT
  // ---------------------------------------------------------------------------
  Widget _buildTextContent({bool centered = false}) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting
        Text(
          'Hello, World! I\'m',
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.w500,
            color: AppColors.grey400,
            letterSpacing: 2.0,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 10),

        // Main Name with Gradient Shader
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary, AppColors.white],
            stops: [0.0, 0.65, 1.0],
          ).createShader(bounds),
          child: Text(
            widget.profile.name,
            style: TextStyle(
              fontSize: isMobile ? 36 : 54,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
              letterSpacing: -1.0,
              height: 1.15,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 14),

        // Dynamic Role Cycling with Smooth Fade
        _buildDynamicRoleSwitcher(centered: centered),
        const SizedBox(height: 20),

        // Bio description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            widget.profile.bio,
            style: TextStyle(
              fontSize: isMobile ? 15 : 16.5,
              color: AppColors.textSecondary,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.left,
          ),
        ),
        const SizedBox(height: 32),

        // CTA Buttons
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildPrimaryGlowingButton(
              label: 'Explore Projects',
              icon: Icons.rocket_launch_rounded,
              onPressed: widget.onViewProjects,
            ),
            _buildOutlineGlowingButton(
              label: 'Get In Touch',
              icon: Icons.chat_bubble_outline_rounded,
              onPressed: widget.onContactMe,
            ),
          ],
        ),
        const SizedBox(height: 36),

        // Social Icons Row
        Wrap(
          spacing: 14,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            SocialButton(
              icon: Icons.code_rounded,
              tooltip: 'GitHub',
              onPressed: () {},
            ),
            SocialButton(
              icon: Icons.work_outline_rounded,
              tooltip: 'LinkedIn',
              onPressed: () {},
            ),
            SocialButton(
              icon: Icons.alternate_email_rounded,
              tooltip: 'Email',
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            Container(height: 20, width: 1, color: AppColors.grey700),
            const SizedBox(width: 8),
            Text(
              'Kafr Alzayat - Tanta',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.grey400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // DYNAMIC ROLE SWITCHER (TYPEWRITER WITH CURSOR)
  // ---------------------------------------------------------------------------
  Widget _buildDynamicRoleSwitcher({required bool centered}) {
    final isMobile = Responsive.isMobile(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: centered
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 4,
          height: isMobile ? 22 : 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.6),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        TypewriterText(
          texts: const [
            'Junior Flutter Developer',
            'Clean Architecture & Bloc Specialist',
            'Cross-Platform Mobile & Web Engineer',
            'Firebase & Supabase Integrator',
            'AI & Gemini Chatbot Developer',
          ],
          textStyle: TextStyle(
            fontSize: isMobile ? 18 : 24,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
            letterSpacing: 0.5,
          ),
          cursorColor: AppColors.primary,
          textAlign: centered ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // ANIMATED AVATAR WITH ORBITING RINGS AND FLOATING BADGES
  // ---------------------------------------------------------------------------
  Widget _buildAnimatedAvatarComposition({required double size}) {
    return Center(
      child: SizedBox(
        width: size * 1.35,
        height: size * 1.35,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Rotating Gradient Dash Ring
            RotationTransition(
              turns: _orbitController,
              child: Container(
                width: size * 1.15,
                height: size * 1.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
              ),
            ),

            // Inner Rotating Glow Ring (opposite direction)
            AnimatedBuilder(
              animation: _orbitController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_orbitController.value * 2 * math.pi,
                  child: Container(
                    width: size * 0.95,
                    height: size * 0.95,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.4),
                          AppColors.secondary.withValues(alpha: 0.3),
                          Colors.transparent,
                          AppColors.accentViolet.withValues(alpha: 0.35),
                          AppColors.primary.withValues(alpha: 0.4),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Core Avatar Container
            Container(
              width: size * 0.85,
              height: size * 0.85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [
                    Color(0xFF1E2A3F),
                    AppColors.card,
                    AppColors.background,
                  ],
                ),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 40,
                    spreadRadius: 6,
                  ),
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.20),
                    blurRadius: 70,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      child: const Icon(
                        Icons.flutter_dash_rounded,
                        size: 64,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'OSAMA',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        letterSpacing: 4,
                      ),
                    ),
                    Text(
                      'FLUTTER DEV',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -----------------------------------------------------------------
            // FLOATING BADGE 1: Flutter & Dart (Top Left)
            // -----------------------------------------------------------------
            AnimatedBuilder(
              animation: _floatController,
              builder: (context, _) {
                final offset =
                    math.sin(_floatController.value * 2 * math.pi) * 8;
                return Positioned(
                  top: 20 + offset,
                  left: 0,
                  child: _FloatingPill(
                    icon: Icons.code_rounded,
                    label: 'Flutter & Dart',
                    color: AppColors.primary,
                  ),
                );
              },
            ),

            // -----------------------------------------------------------------
            // FLOATING BADGE 2: Clean Architecture (Top Right)
            // -----------------------------------------------------------------
            AnimatedBuilder(
              animation: _floatController,
              builder: (context, _) {
                final offset =
                    math.cos(_floatController.value * 2 * math.pi) * 8;
                return Positioned(
                  top: 40 + offset,
                  right: 0,
                  child: _FloatingPill(
                    icon: Icons.layers_rounded,
                    label: 'Clean Arch',
                    color: AppColors.secondary,
                  ),
                );
              },
            ),

            // -----------------------------------------------------------------
            // FLOATING BADGE 3: Bloc & Cubit (Bottom Left)
            // -----------------------------------------------------------------
            AnimatedBuilder(
              animation: _floatController,
              builder: (context, _) {
                final offset =
                    math.cos((_floatController.value + 0.5) * 2 * math.pi) * 7;
                return Positioned(
                  bottom: 30 + offset,
                  left: 10,
                  child: _FloatingPill(
                    icon: Icons.flash_on_rounded,
                    label: 'Bloc / Cubit',
                    color: AppColors.accentAmber,
                  ),
                );
              },
            ),

            // -----------------------------------------------------------------
            // FLOATING BADGE 4: AI & Gemini (Bottom Right)
            // -----------------------------------------------------------------
            AnimatedBuilder(
              animation: _floatController,
              builder: (context, _) {
                final offset =
                    math.sin((_floatController.value + 0.5) * 2 * math.pi) * 9;
                return Positioned(
                  bottom: 25 + offset,
                  right: 10,
                  child: _FloatingPill(
                    icon: Icons.auto_awesome_rounded,
                    label: 'Gemini AI',
                    color: AppColors.accentViolet,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INTERACTIVE BUTTONS
  // ---------------------------------------------------------------------------
  Widget _buildPrimaryGlowingButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return _HoverScaleButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.background, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.background,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineGlowingButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return _HoverScaleButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.secondary.withValues(alpha: 0.8),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.15),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.secondary, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HELPER WIDGETS
// ---------------------------------------------------------------------------

class _FloatingPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _FloatingPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.90),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;

  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final val = _controller.value;
        return SizedBox(
          width: 14,
          height: 14,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer expanding & fading ring
              Transform.scale(
                scale: 1.0 + (val * 1.2),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withValues(alpha: 0.6 * (1.0 - val)),
                  ),
                ),
              ),
              // Inner solid dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                  boxShadow: [BoxShadow(color: widget.color, blurRadius: 6)],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HoverScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const _HoverScaleButton({required this.child, this.onPressed});

  @override
  State<_HoverScaleButton> createState() => _HoverScaleButtonState();
}

class _HoverScaleButtonState extends State<_HoverScaleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isHovered ? 1.06 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TYPEWRITER TEXT WITH BLINKING CURSOR
// ---------------------------------------------------------------------------
class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle textStyle;
  final Duration typeSpeed;
  final Duration deleteSpeed;
  final Duration pauseDuration;
  final Color cursorColor;
  final TextAlign textAlign;

  const TypewriterText({
    super.key,
    required this.texts,
    required this.textStyle,
    this.typeSpeed = const Duration(milliseconds: 60),
    this.deleteSpeed = const Duration(milliseconds: 32),
    this.pauseDuration = const Duration(milliseconds: 1800),
    this.cursorColor = AppColors.primary,
    this.textAlign = TextAlign.left,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  int _textIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  late final AnimationController _cursorController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Cursor blinking animation (blinks smoothly)
    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _scheduleNextChar();
  }

  void _scheduleNextChar() {
    if (!mounted || widget.texts.isEmpty) return;

    final currentFullText = widget.texts[_textIndex];

    if (!_isDeleting) {
      // Typing phase
      if (_charIndex < currentFullText.length) {
        _charIndex++;
        setState(() {});
        _timer = Timer(widget.typeSpeed, _scheduleNextChar);
      } else {
        // Word complete: pause to let user read
        _timer = Timer(widget.pauseDuration, () {
          if (!mounted) return;
          _isDeleting = true;
          _scheduleNextChar();
        });
      }
    } else {
      // Deleting phase (backspace)
      if (_charIndex > 0) {
        _charIndex--;
        setState(() {});
        _timer = Timer(widget.deleteSpeed, _scheduleNextChar);
      } else {
        // Deletion complete: move to next text
        _isDeleting = false;
        _textIndex = (_textIndex + 1) % widget.texts.length;
        _timer = Timer(const Duration(milliseconds: 250), _scheduleNextChar);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.texts.isEmpty) return const SizedBox.shrink();

    final currentFullText = widget.texts[_textIndex];
    final displayedText = currentFullText.substring(0, _charIndex);
    final fontHeight = (widget.textStyle.fontSize ?? 20) * 1.1;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: displayedText, style: widget.textStyle),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: AnimatedBuilder(
              animation: _cursorController,
              builder: (context, child) {
                final isVisible = _cursorController.value > 0.4;
                return Opacity(opacity: isVisible ? 1.0 : 0.0, child: child);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 3),
                width: 3.0,
                height: fontHeight,
                decoration: BoxDecoration(
                  color: widget.cursorColor,
                  borderRadius: BorderRadius.circular(1.5),
                  boxShadow: [
                    BoxShadow(
                      color: widget.cursorColor.withValues(alpha: 0.8),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      textAlign: widget.textAlign,
    );
  }
}
