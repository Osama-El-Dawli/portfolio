import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors (Electric Neon Mint / Emerald)
  static const Color primary = Color(0xFF00F5A0);
  static const Color primaryLight = Color(0xFF5CFFC6);
  static const Color primaryDark = Color(0xFF00B876);

  // Secondary Colors (Electric Vivid Cyan)
  static const Color secondary = Color(0xFF00D9F5);
  static const Color secondaryLight = Color(0xFF6AE9FF);
  static const Color secondaryDark = Color(0xFF009BB0);

  // Accent Colors
  static const Color accentViolet = Color(0xFF8B5CF6);
  static const Color accentPink = Color(0xFFFF4D8D);
  static const Color accentAmber = Color(0xFFFFB800);

  // Backgrounds (Deep Obsidian Dark)
  static const Color background = Color(0xFF080B11);
  static const Color backgroundLight = Color(0xFF0D121D);
  static const Color surface = Color(0xFF121824);
  static const Color surfaceLight = Color(0xFF1A2333);

  // Cards
  static const Color card = Color(0xFF141C2B);
  static const Color cardColor = Color(0xFF141C2B);
  static const Color cardHover = Color(0xFF1B263B);
  static const Color cardBorder = Color(0xFF22314A);

  // Common Colors & Greys
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey300 = Color(0xFFE2E8F0);
  static const Color grey400 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF64748B);
  static const Color grey600 = Color(0xFF475569);
  static const Color grey700 = Color(0xFF334155);
  static const Color grey800 = Color(0xFF1E293B);
  static const Color grey900 = Color(0xFF0F172A);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xCCFFFFFF); // 80% white
  static const Color textTertiary = Color(0x8AFFFFFF); // 54% white
  static const Color textHint = Color(0x59FFFFFF); // 35% white

  // Status Colors
  static const Color success = Color(0xFF00F5A0);
  static const Color error = Color(0xFFFF4D8D);
  static const Color warning = Color(0xFFFFB800);
  static const Color info = Color(0xFF00D9F5);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF00F5A0);
  static const Color gradientEnd = Color(0xFF00D9F5);

  // Divider
  static const Color divider = Color(0x1FFFFFFF); // 12% white

  // Shadow
  static const Color shadow = Color(0x66000000); // 40% black
  static const Color shadowDark = Color(0x99000000); // 60% black

  // Chip / Tag
  static const Color chipBackground = Color(0x1F00F5A0);
  static const Color chipText = Color(0xFF00F5A0);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, Color(0xFF0D121D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF141C2B), Color(0xFF1B263B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF00D9F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
