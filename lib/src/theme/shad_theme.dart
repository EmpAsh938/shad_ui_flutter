import 'package:flutter/material.dart';
import '../tokens/tokens.dart';

class ShadThemeData {
  final ShadBaseColor baseColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color borderColor;
  final Color textColor;
  final Color mutedColor;
  final Color successColor;
  final Color warningColor;
  final Color errorColor;
  final Brightness brightness;

  const ShadThemeData({
    this.baseColor = ShadBaseColor.gray,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.borderColor,
    required this.textColor,
    required this.mutedColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
    required this.brightness,
  });

  factory ShadThemeData.light({ShadBaseColor baseColor = ShadBaseColor.gray}) {
    final palette = ShadBaseColors.getPalette(baseColor);
    return ShadThemeData(
      baseColor: baseColor,
      primaryColor: Color(palette[900]!),
      secondaryColor: Color(palette[100]!),
      accentColor: const Color(ShadColors.accent),
      backgroundColor: const Color(ShadColors.backgroundLight),
      cardColor: const Color(ShadColors.card),
      borderColor: const Color(ShadColors.border),
      textColor: Color(palette[900]!),
      mutedColor: const Color(ShadColors.muted),
      successColor: const Color(ShadColors.success),
      warningColor: const Color(ShadColors.warning),
      errorColor: const Color(ShadColors.error),
      brightness: Brightness.light,
    );
  }

  factory ShadThemeData.dark({ShadBaseColor baseColor = ShadBaseColor.gray}) {
    final palette = ShadBaseColors.getPalette(baseColor);
    return ShadThemeData(
      baseColor: baseColor,
      primaryColor: Color(palette[50]!),
      secondaryColor: Color(palette[800]!),
      accentColor: const Color(ShadColors.accent),
      backgroundColor: const Color(ShadColors.backgroundDark),
      cardColor: const Color(0xFF23272F),
      borderColor: const Color(0xFF27272A),
      textColor: Color(palette[50]!),
      mutedColor: const Color(ShadColors.muted),
      successColor: const Color(ShadColors.success),
      warningColor: const Color(ShadColors.warning),
      errorColor: const Color(ShadColors.error),
      brightness: Brightness.dark,
    );
  }

  ShadThemeData copyWith({
    ShadBaseColor? baseColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    Color? backgroundColor,
    Color? cardColor,
    Color? borderColor,
    Color? textColor,
    Color? mutedColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Brightness? brightness,
  }) {
    return ShadThemeData(
      baseColor: baseColor ?? this.baseColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cardColor: cardColor ?? this.cardColor,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      mutedColor: mutedColor ?? this.mutedColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      brightness: brightness ?? this.brightness,
    );
  }

  static ShadThemeData lerp(ShadThemeData a, ShadThemeData b, double t) {
    return ShadThemeData(
      baseColor: t < 0.5 ? a.baseColor : b.baseColor,
      primaryColor: Color.lerp(a.primaryColor, b.primaryColor, t)!,
      secondaryColor: Color.lerp(a.secondaryColor, b.secondaryColor, t)!,
      accentColor: Color.lerp(a.accentColor, b.accentColor, t)!,
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      cardColor: Color.lerp(a.cardColor, b.cardColor, t)!,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t)!,
      textColor: Color.lerp(a.textColor, b.textColor, t)!,
      mutedColor: Color.lerp(a.mutedColor, b.mutedColor, t)!,
      successColor: Color.lerp(a.successColor, b.successColor, t)!,
      warningColor: Color.lerp(a.warningColor, b.warningColor, t)!,
      errorColor: Color.lerp(a.errorColor, b.errorColor, t)!,
      brightness: t < 0.5 ? a.brightness : b.brightness,
    );
  }
}

class ShadTheme extends InheritedWidget {
  final ShadThemeData data;

  const ShadTheme({super.key, required this.data, required super.child});

  static ShadThemeData of(BuildContext context) {
    final ShadTheme? theme = context
        .dependOnInheritedWidgetOfExactType<ShadTheme>();
    return theme?.data ?? ShadThemeData.light();
  }

  @override
  bool updateShouldNotify(ShadTheme oldWidget) => data != oldWidget.data;
}
