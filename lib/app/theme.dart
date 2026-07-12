import 'package:flutter/material.dart';

/// CricScore theming. Material 3, portrait-first, large tap targets for the
/// scoring pad (docs/07 §Theming). The colour tokens are taken verbatim from the
/// design prototype (Design/Cricket scoring app prototype) so the app matches
/// the comp in both light and dark. Typeface: Roboto / Roboto Condensed.
class AppTheme {
  AppTheme._();

  static ThemeData light() => _themeFrom(_lightScheme);
  static ThemeData dark() => _themeFrom(_darkScheme);

  static ThemeData _themeFrom(ColorScheme scheme) {
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: 'Roboto',
      // Minimum 48dp tap targets for one-handed scoring ergonomics.
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
    );
  }

  // ---- Design tokens (light) ----
  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF3B6939),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFBCF0AE),
    onPrimaryContainer: Color(0xFF002204),
    secondary: Color(0xFF53634F),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD6E8CD),
    onSecondaryContainer: Color(0xFF111F0F),
    tertiary: Color(0xFF386663),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBCECE7),
    onTertiaryContainer: Color(0xFF00201D),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFCFDF6),
    onSurface: Color(0xFF1A1C18),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF6F9F0),
    surfaceContainer: Color(0xFFF0F3EA),
    surfaceContainerHigh: Color(0xFFEBEDE4),
    surfaceContainerHighest: Color(0xFFE5E8DF),
    onSurfaceVariant: Color(0xFF43483F),
    outline: Color(0xFF73796E),
    outlineVariant: Color(0xFFC3C8BB),
    inverseSurface: Color(0xFF2F312B),
    onInverseSurface: Color(0xFFF1F1E9),
    inversePrimary: Color(0xFFA0D395),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFF3B6939),
  );

  // ---- Design tokens (dark) ----
  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA0D395),
    onPrimary: Color(0xFF123A11),
    primaryContainer: Color(0xFF235023),
    onPrimaryContainer: Color(0xFFBCF0AE),
    secondary: Color(0xFFBACCB2),
    onSecondary: Color(0xFF263422),
    secondaryContainer: Color(0xFF3C4B37),
    onSecondaryContainer: Color(0xFFD6E8CD),
    tertiary: Color(0xFFA0D0CC),
    onTertiary: Color(0xFF00372F),
    tertiaryContainer: Color(0xFF1F4E4A),
    onTertiaryContainer: Color(0xFFBCECE7),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF12140F),
    onSurface: Color(0xFFE2E3DC),
    surfaceContainerLowest: Color(0xFF0C0F0A),
    surfaceContainerLow: Color(0xFF1A1C18),
    surfaceContainer: Color(0xFF1E211C),
    surfaceContainerHigh: Color(0xFF282B25),
    surfaceContainerHighest: Color(0xFF333630),
    onSurfaceVariant: Color(0xFFC3C8BB),
    outline: Color(0xFF8D9387),
    outlineVariant: Color(0xFF43483F),
    inverseSurface: Color(0xFFE2E3DC),
    onInverseSurface: Color(0xFF2F312B),
    inversePrimary: Color(0xFF3B6939),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFFA0D395),
  );
}
