import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static TextStyle _poppins({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.background,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textPrimary,
        primaryContainer: AppColors.primaryDark,
        secondaryContainer: AppColors.secondaryDark,
        outline: AppColors.cardBorder,
      ),
      textTheme: _textTheme,
      cardTheme: _cardTheme,
      appBarTheme: _appBarTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: 24,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 32,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.chipBackground,
        labelStyle: _poppins(
          color: AppColors.chipText,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.cardBorder),
        ),
        textStyle: _poppins(
          color: AppColors.textPrimary,
          fontSize: 12,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(
          AppColors.primary.withValues(alpha: 0.5),
        ),
        trackColor: WidgetStateProperty.all(
          AppColors.surface.withValues(alpha: 0.3),
        ),
        radius: const Radius.circular(4),
        thickness: WidgetStateProperty.all(6),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Text Theme
  // ---------------------------------------------------------------------------
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: _poppins(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.5,
        height: 1.12,
      ),
      displayMedium: _poppins(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
        height: 1.16,
      ),
      displaySmall: _poppins(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.22,
      ),
      headlineLarge: _poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.25,
      ),
      headlineMedium: _poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.29,
      ),
      headlineSmall: _poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.33,
      ),
      titleLarge: _poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.27,
      ),
      titleMedium: _poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      titleSmall: _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      bodyLarge: _poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: _poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      labelLarge: _poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 1.0,
        height: 1.43,
      ),
      labelMedium: _poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: _poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Card Theme
  // ---------------------------------------------------------------------------
  static CardThemeData get _cardTheme {
    return CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.cardBorder, width: 1),
      ),
      margin: const EdgeInsets.all(8),
    );
  }

  // ---------------------------------------------------------------------------
  // AppBar Theme
  // ---------------------------------------------------------------------------
  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: AppColors.background.withValues(alpha: 0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: _poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Input Decoration Theme
  // ---------------------------------------------------------------------------
  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: _poppins(
        color: AppColors.textHint,
        fontSize: 14,
      ),
      labelStyle: _poppins(
        color: AppColors.textTertiary,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.cardBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Elevated Button Theme
  // ---------------------------------------------------------------------------
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: _poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Outlined Button Theme
  // ---------------------------------------------------------------------------
  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: _poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Text Button Theme
  // ---------------------------------------------------------------------------
  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: _poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
