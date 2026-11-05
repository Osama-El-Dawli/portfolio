import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Returns true if the screen width is less than 600px.
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < mobileBreakpoint;
  }

  /// Returns true if the screen width is >= 600px and < 1024px.
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Returns true if the screen width is >= 1024px.
  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tabletBreakpoint;
  }

  /// Returns the current screen width.
  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  /// Returns the current screen height.
  static double screenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  /// Returns a value based on the current screen size.
  ///
  /// [mobile] is used when screen width < 600px.
  /// [tablet] is used when screen width >= 600px and < 1024px.
  /// [desktop] is used when screen width >= 1024px.
  ///
  /// If [tablet] is not provided, [mobile] is used as fallback for tablet.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= tabletBreakpoint) {
      return desktop;
    } else if (width >= mobileBreakpoint) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Returns a widget based on the current screen size.
  static Widget builder({
    required Widget mobile,
    Widget? tablet,
    required Widget desktop,
    required BuildContext context,
  }) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= tabletBreakpoint) {
      return desktop;
    } else if (width >= mobileBreakpoint) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Returns the number of grid columns based on screen size.
  static int gridColumns(BuildContext context) {
    return value<int>(context, mobile: 1, tablet: 2, desktop: 3);
  }

  /// Returns horizontal padding based on screen size.
  static double horizontalPadding(BuildContext context) {
    return value<double>(context, mobile: 20, tablet: 40, desktop: 80);
  }

  /// Returns the content max width for centering content on large screens.
  static double contentMaxWidth(BuildContext context) {
    return value<double>(context, mobile: 600, tablet: 900, desktop: 1200);
  }
}
