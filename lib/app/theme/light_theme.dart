import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF4F745F), brightness: Brightness.light).copyWith(
  surface: const Color(0xFFFFFBF3),
  surfaceContainerLowest: const Color(0xFFFFFFFF),
  surfaceContainerHighest: const Color(0xFFE9E5D9),
  tertiary: const Color(0xFFD99B2B),
  tertiaryContainer: const Color(0xFFFFDE9C),
  onTertiaryContainer: const Color(0xFF422C00),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: _colorScheme,
  scaffoldBackgroundColor: _colorScheme.surface,
  fontFamilyFallback: const ['Avenir Next', 'SF Pro Display', 'Roboto'],
  textTheme: const TextTheme(
    displaySmall: TextStyle(fontWeight: FontWeight.w800),
    headlineLarge: TextStyle(fontWeight: FontWeight.w800),
    headlineSmall: TextStyle(fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontWeight: FontWeight.w800),
    titleMedium: TextStyle(fontWeight: FontWeight.w700),
    titleSmall: TextStyle(fontWeight: FontWeight.w700),
    labelLarge: TextStyle(fontWeight: FontWeight.w700),
  ),
  cardTheme: CardThemeData(
    color: _colorScheme.surfaceContainerLowest,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: _colorScheme.outlineVariant),
    ),
    margin: EdgeInsets.zero,
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    side: BorderSide(color: _colorScheme.outlineVariant),
    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
  segmentedButtonTheme: SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: _colorScheme.surface.withValues(alpha: 0.92),
    foregroundColor: _colorScheme.onSurface,
    surfaceTintColor: _colorScheme.surfaceTint,
  ),
);
