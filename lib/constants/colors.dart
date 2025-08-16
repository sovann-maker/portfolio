import 'package:flutter/material.dart';

class CustomColor {
  // Modern black and white theme
  static const Color scaffoldBg = Color(0xff000000);
  static const Color bgLight1 = Color(0xff111111);
  static const Color bgLight2 = Color(0xff1a1a1a);
  static const Color cardBg = Color(0xff0a0a0a);
  static const Color surfaceColor = Color(0xff151515);
  static const Color borderColor = Color(0xff333333);
  
  // Modern accent colors
  static const Color primaryGray = Color(0xff666666);
  static const Color accentGray = Color(0xff888888);
  static const Color lightGray = Color(0xffaaaaaa);
  static const Color darkGray = Color(0xff444444);
  static const Color charcoal = Color(0xff2a2a2a);
  static const Color silver = Color(0xffcccccc);
  static const Color cyanAccent = Color(0xff66d9ed);
  static const Color cyanLight = Color(0xff87e7f7);
  static const Color cyanDark = Color(0xff4dc7dd);
  
  // Monochrome text colors
  static const Color textPrimary = Color(0xffffffff);
  static const Color textSecondary = Color(0xffaaaaaa);
  static const Color textMuted = Color(0xff777777);
  static const Color textOnSurface = Color(0xffeeeeee);
  
  // Legacy colors (kept for compatibility)
  static const Color textFieldBg = Color(0xff2a2a3e);
  static const Color hintDark = Color(0xff666874);
  static const Color yellowSecondary = Color(0xffFFC25C);
  static const Color yellowPrimary = Color(0xffFFAF29);
  static const Color whitePrimary = Color(0xffffffff);
  static const Color whiteSecondary = Color(0xffb0b0b0);
  
  // Developer-inspired gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [cyanAccent, cyanLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xff777777), Color(0xff999999)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xffffffff), cyanAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cyanGradient = LinearGradient(
    colors: [cyanDark, cyanAccent, cyanLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [scaffoldBg, bgLight1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xff151515), Color(0xff0a0a0a)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient glassmorphismGradient = LinearGradient(
    colors: [
      Color(0x15ffffff),
      Color(0x08ffffff),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
