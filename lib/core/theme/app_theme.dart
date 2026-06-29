import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

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
  static ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.blue,
    usedColors: 0, // Use default scheme colors
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      chipSchemeColor: SchemeColor.primary,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.primary,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarIndicatorOpacity: 0.24,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.primary,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 0.24,
    ),
    keyColors: const FlexKeyColors(
      keepPrimary: true,
      keepSecondary: true,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Inter',
  ).copyWith(
    extensions: [
      _CustomColors.light,
    ],
  );

  /// Dark Theme Configuration
  static ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.blue,
    usedColors: 0,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 7,
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      useM2StyleDividerInM3: true,
      chipSchemeColor: SchemeColor.primary,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.primary,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarIndicatorOpacity: 0.24,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.primary,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 0.24,
    ),
    keyColors: const FlexKeyColors(
      keepPrimary: true,
      keepSecondary: true,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Inter',
  ).copyWith(
    extensions: [
      _CustomColors.dark,
    ],
  );

  /// Custom Text Theme
  static TextTheme textTheme = const TextTheme(
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

/// Custom Colors Extension
@immutable
class _CustomColors extends ThemeExtension<_CustomColors> {
  const _CustomColors({
    required this.profit,
    required this.loss,
    required this.revenue,
    required this.expense,
    required this.investment,
    required this.liability,
  });

  static const light = _CustomColors(
    profit: AppTheme.profitColor,
    loss: AppTheme.lossColor,
    revenue: AppTheme.revenueColor,
    expense: AppTheme.expenseColor,
    investment: AppTheme.investmentColor,
    liability: AppTheme.liabilityColor,
  );

  static const dark = _CustomColors(
    profit: Color(0xFF4CAF50),
    loss: Color(0xFFEF5350),
    revenue: Color(0xFF42A5F5),
    expense: Color(0xFFFF7043),
    investment: Color(0xFFAB47BC),
    liability: Color(0xFFFF8A65),
  );

  final Color profit;
  final Color loss;
  final Color revenue;
  final Color expense;
  final Color investment;
  final Color liability;

  @override
  _CustomColors copyWith({
    Color? profit,
    Color? loss,
    Color? revenue,
    Color? expense,
    Color? investment,
    Color? liability,
  }) {
    return _CustomColors(
      profit: profit ?? this.profit,
      loss: loss ?? this.loss,
      revenue: revenue ?? this.revenue,
      expense: expense ?? this.expense,
      investment: investment ?? this.investment,
      liability: liability ?? this.liability,
    );
  }

  @override
  _CustomColors lerp(ThemeExtension<_CustomColors> other, double t) {
    if (other is! _CustomColors) {
      return this;
    }
    return _CustomColors(
      profit: Color.lerp(profit, other.profit, t)!,
      loss: Color.lerp(loss, other.loss, t)!,
      revenue: Color.lerp(revenue, other.revenue, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      investment: Color.lerp(investment, other.investment, t)!,
      liability: Color.lerp(liability, other.liability, t)!,
    );
  }
}