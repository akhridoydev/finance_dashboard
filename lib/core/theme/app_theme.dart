import 'package:flutter/material.dart';

/// Application Theme Configuration
/// Material 3 Design System with Professional ERP Color Scheme
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Professional Color Scheme for Financial ERP
  static const Color primaryColor = Color(0xFF1976D2); // Professional Blue
  static const Color secondaryColor = Color(0xFF26A69A); // Teal
  static const Color successColor = Color(0xFF4CAF50); // Green for profit
  static const Color dangerColor = Color(0xFFE53935); // Red for loss
  static const Color warningColor = Color(0xFFFB8C00); // Orange for warnings
  static const Color infoColor = Color(0xFF039BE5); // Light blue

  // Neutral Colors
  static const Color surfaceColor = Color(0xFFFAFAFA);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color dividerColor = Color(0xFFE0E0E0);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);

  // Financial Specific Colors
  static const Color profitColor = Color(0xFF2E7D32); // Dark Green
  static const Color lossColor = Color(0xFFC62828); // Dark Red
  static const Color revenueColor = Color(0xFF1565C0); // Dark Blue
  static const Color expenseColor = Color(0xFFE64A19); // Deep Orange
  static const Color investmentColor = Color(0xFF6A1B9A); // Purple
  static const Color liabilityColor = Color(0xFFD84315); // Burnt Orange

  /// Light Theme Configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: surfaceColor,
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
    ),
    textTheme: _buildTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  /// Dark Theme Configuration
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
    ),
    textTheme: _buildTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  /// Custom Text Theme
  static TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}