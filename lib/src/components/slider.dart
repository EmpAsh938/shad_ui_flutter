import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadSliderVariant { default_, outline, filled, ghost }

enum ShadSliderSize { sm, md, lg }

class ShadSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final ShadSliderVariant variant;
  final ShadSliderSize size;
  final bool disabled;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final double? trackHeight;
  final double? thumbRadius;
  final String? label;
  final String? semanticLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.variant = ShadSliderVariant.default_,
    this.size = ShadSliderSize.md,
    this.disabled = false,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.trackHeight,
    this.thumbRadius,
    this.label,
    this.semanticLabel,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadSlider> createState() => _ShadSliderState();
}

class _ShadSliderState extends State<ShadSlider> {
  double _getTrackHeight() {
    if (widget.trackHeight != null) return widget.trackHeight!;
    switch (widget.size) {
      case ShadSliderSize.sm:
        return 2.0;
      case ShadSliderSize.lg:
        return 6.0;
      case ShadSliderSize.md:
      default:
        return 4.0;
    }
  }

  double _getThumbRadius() {
    if (widget.thumbRadius != null) return widget.thumbRadius!;
    switch (widget.size) {
      case ShadSliderSize.sm:
        return 8.0;
      case ShadSliderSize.lg:
        return 14.0;
      case ShadSliderSize.md:
      default:
        return 10.0;
    }
  }

  Color _getActiveColor(ShadThemeData theme) {
    if (widget.activeColor != null) return widget.activeColor!;
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 200 : 700,
      );
    }
    switch (widget.variant) {
      case ShadSliderVariant.default_:
        return theme.primaryColor;
      case ShadSliderVariant.outline:
        return ShadBaseColors.getColor(theme.baseColor, 400);
      case ShadSliderVariant.filled:
        return ShadBaseColors.getColor(theme.baseColor, 700);
      case ShadSliderVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getInactiveColor(ShadThemeData theme) {
    if (widget.inactiveColor != null) return widget.inactiveColor!;
    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 200 : 700,
    );
  }

  Color _getThumbColor(ShadThemeData theme) {
    if (widget.thumbColor != null) return widget.thumbColor!;
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: _getActiveColor(theme),
        inactiveTrackColor: _getInactiveColor(theme),
        trackHeight: _getTrackHeight(),
        thumbColor: _getThumbColor(theme),
        overlayColor: _getActiveColor(theme).withOpacity(0.1),
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: _getThumbRadius(),
        ),
        overlayShape: RoundSliderOverlayShape(
          overlayRadius: _getThumbRadius() + 4,
        ),
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Slider(
        value: widget.value,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        onChanged: widget.disabled ? null : widget.onChanged,
        label: widget.label,
        semanticFormatterCallback: widget.semanticLabel != null
            ? (_) => widget.semanticLabel!
            : null,
      ),
    );
  }
}
