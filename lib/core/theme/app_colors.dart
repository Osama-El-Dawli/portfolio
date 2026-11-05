import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark = Color(0xFF4A42E0);

  // Secondary / Accent
  static const Color secondary = Color(0xFF00D9FF);
  static const Color secondaryLight = Color(0xFF5CEAFF);
  static const Color secondaryDark = Color(0xFF00A8CC);

  // Backgrounds
  static const Color background = Color(0xFF0A0E21);
  static const Color backgroundLight = Color(0xFF0F1330);
  static const Color surface = Color(0xFF1A1F36);
  static const Color surfaceLight = Color(0xFF242A48);

  // Cards
  static const Color card = Color(0xFF1E2340);
  static const Color cardColor = Color(0xFF1E2340);
  static const Color cardHover = Color(0xFF262C4D);
  static const Color cardBorder = Color(0xFF2A3058);

  // Common Colors & Greys
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% white
  static const Color textTertiary = Color(0x80FFFFFF); // 50% white
  static const Color textHint = Color(0x4DFFFFFF); // 30% white

  // Status Colors
  static const Color success = Color(0xFF00E676);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFAB40);
  static const Color info = Color(0xFF448AFF);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF6C63FF);
  static const Color gradientEnd = Color(0xFF00D9FF);

  // Divider
  static const Color divider = Color(0x1AFFFFFF); // 10% white

  // Shadow
  static const Color shadow = Color(0x40000000); // 25% black
  static const Color shadowDark = Color(0x80000000); // 50% black

  // Chip / Tag
  static const Color chipBackground = Color(0x1A6C63FF); // 10% primary
  static const Color chipText = Color(0xFF9D97FF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, Color(0xFF0F1330)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1E2340), Color(0xFF252B4A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
