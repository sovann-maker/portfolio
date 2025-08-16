import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

ThemeData kCustomTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: CustomColor.scaffoldBg,
  colorScheme: const ColorScheme.dark(
    primary: CustomColor.primaryGray,
    secondary: CustomColor.accentGray,
    surface: CustomColor.surfaceColor,
    onSurface: CustomColor.textOnSurface,
    onPrimary: CustomColor.textPrimary,
    outline: CustomColor.borderColor,
  ),
  
  // AppBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: CustomColor.textPrimary),
    titleTextStyle: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  
  // Icon theme
  iconTheme: const IconThemeData(
    color: CustomColor.textPrimary,
    size: 24,
  ),
  
  // Elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: CustomColor.textPrimary,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
    ).copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return CustomColor.primaryGray.withOpacity(0.8);
          }
          return null; // Use the gradient instead
        },
      ),
    ),
  ),
  
  // Card theme
  cardTheme: CardTheme(
    color: CustomColor.surfaceColor,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(
        color: CustomColor.borderColor,
        width: 1,
      ),
    ),
    margin: const EdgeInsets.all(8),
  ),
  
  // Professional typography
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 56,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.5,
      height: 1.1,
    ),
    displayMedium: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 40,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.8,
      height: 1.2,
    ),
    displaySmall: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
      height: 1.25,
    ),
    headlineLarge: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    headlineSmall: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    titleLarge: TextStyle(
      color: CustomColor.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    titleMedium: TextStyle(
      color: CustomColor.textSecondary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    titleSmall: TextStyle(
      color: CustomColor.textSecondary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      color: CustomColor.textSecondary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
      letterSpacing: 0.1,
    ),
    bodyMedium: TextStyle(
      color: CustomColor.textSecondary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.6,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      color: CustomColor.textMuted,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      color: CustomColor.textMuted,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      color: CustomColor.textMuted,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      color: CustomColor.textMuted,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),
  
  // Input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: CustomColor.textFieldBg,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: CustomColor.surfaceColor.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: CustomColor.primaryGray, width: 2),
    ),
    hintStyle: const TextStyle(
      color: CustomColor.textMuted,
      fontSize: 14,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  ),
);
