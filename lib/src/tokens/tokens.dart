import 'package:flutter/material.dart';

// Base color enum
enum ShadBaseColor { gray, neutral, slate, stone, zinc }

// Base color palettes (shades 50-900)
class ShadBaseColors {
  static const Map<int, int> gray = {
    50: 0xFFF9FAFB,
    100: 0xFFF3F4F6,
    200: 0xFFE5E7EB,
    300: 0xFFD1D5DB,
    400: 0xFF9CA3AF,
    500: 0xFF6B7280,
    600: 0xFF4B5563,
    700: 0xFF374151,
    800: 0xFF1F2937,
    900: 0xFF111827,
  };
  static const Map<int, int> neutral = {
    50: 0xFFFAFAFA,
    100: 0xFFF5F5F5,
    200: 0xFFE5E5E5,
    300: 0xFFD4D4D4,
    400: 0xFFA3A3A3,
    500: 0xFF737373,
    600: 0xFF525252,
    700: 0xFF404040,
    800: 0xFF262626,
    900: 0xFF171717,
  };
  static const Map<int, int> slate = {
    50: 0xFFF8FAFC,
    100: 0xFFF1F5F9,
    200: 0xFFE2E8F0,
    300: 0xFFCBD5E1,
    400: 0xFF94A3B8,
    500: 0xFF64748B,
    600: 0xFF475569,
    700: 0xFF334155,
    800: 0xFF1E293B,
    900: 0xFF0F172A,
  };
  static const Map<int, int> stone = {
    50: 0xFFFAFAF9,
    100: 0xFFF5F5F4,
    200: 0xFFE7E5E4,
    300: 0xFFD6D3D1,
    400: 0xFFA8A29E,
    500: 0xFF78716C,
    600: 0xFF57534E,
    700: 0xFF44403C,
    800: 0xFF292524,
    900: 0xFF1C1917,
  };
  static const Map<int, int> zinc = {
    50: 0xFFFAFAFA,
    100: 0xFFF4F4F5,
    200: 0xFFE4E4E7,
    300: 0xFFD4D4D8,
    400: 0xFFA1A1AA,
    500: 0xFF71717A,
    600: 0xFF52525B,
    700: 0xFF3F3F46,
    800: 0xFF27272A,
    900: 0xFF18181B,
  };

  static Map<int, int> getPalette(ShadBaseColor baseColor) {
    switch (baseColor) {
      case ShadBaseColor.gray:
        return gray;
      case ShadBaseColor.neutral:
        return neutral;
      case ShadBaseColor.slate:
        return slate;
      case ShadBaseColor.stone:
        return stone;
      case ShadBaseColor.zinc:
        return zinc;
    }
  }

  static Color getColor(ShadBaseColor baseColor, int shade) {
    final palette = getPalette(baseColor);
    return Color(palette[shade]!);
  }
}

// Color tokens
class ShadColors {
  static const primary = 0xFF000000;
  static const secondary = 0xFFF1F5F9;
  static const accent = 0xFF22D3EE;
  static const backgroundLight = 0xFFFFFFFF;
  static const backgroundDark = 0xFF18181B;
  static const textLight = 0xFF18181B;
  static const textDark = 0xFFF1F5F9;
  static const success = 0xFF22C55E;
  static const warning = 0xFFEAB308;
  static const error = 0xFFEF4444;
  static const muted = 0xFF9CA3AF;
  static const border = 0xFFE5E7EB;
  static const card = 0xFFF8FAFC;
  // Add more as needed
}

// Spacing tokens
class ShadSpacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

// Radius tokens
class ShadRadius {
  static const xs = 2.0;
  static const sm = 4.0;
  static const md = 8.0;
  static const lg = 16.0;
  static const xl = 32.0;
  static const full = 999.0;
}

// Typography tokens
class ShadTypography {
  static const fontFamily = 'Inter';
  static const fontSizeSm = 12.0;
  static const fontSizeMd = 16.0;
  static const fontSizeLg = 20.0;
  static const fontSizeXl = 24.0;
  static const fontSize2xl = 32.0;
  static const fontWeightRegular = FontWeight.w400;
  static const fontWeightMedium = FontWeight.w500;
  static const fontWeightBold = FontWeight.w700;
  static const lineHeightTight = 1.1;
  static const lineHeightNormal = 1.5;
  static const lineHeightLoose = 1.75;
  static const letterSpacingTight = -0.5;
  static const letterSpacingNormal = 0.0;
  static const letterSpacingWide = 0.5;
}
