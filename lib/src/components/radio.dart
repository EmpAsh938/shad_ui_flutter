import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadRadioVariant { default_, outline, filled, ghost }

enum ShadRadioSize { sm, md, lg }

enum ShadRadioState { normal, success, error, warning }

class ShadRadio<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final String? label;
  final String? description;
  final bool disabled;
  final bool loading;
  final ShadRadioVariant variant;
  final ShadRadioSize size;
  final ShadRadioState state;
  final String? errorText;
  final String? successText;
  final String? warningText;
  final Widget? icon;
  final ValueChanged<T?>? onChanged;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadRadio({
    super.key,
    required this.value,
    this.groupValue,
    this.label,
    this.description,
    this.disabled = false,
    this.loading = false,
    this.variant = ShadRadioVariant.default_,
    this.size = ShadRadioSize.md,
    this.state = ShadRadioState.normal,
    this.errorText,
    this.successText,
    this.warningText,
    this.icon,
    this.onChanged,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadRadio<T>> createState() => _ShadRadioState<T>();
}

class _ShadRadioState<T> extends State<ShadRadio<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool get _isSelected => widget.value == widget.groupValue;

  void _handleTap() {
    if (widget.disabled || widget.loading) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onChanged?.call(widget.value);
  }

  double _getSize() {
    switch (widget.size) {
      case ShadRadioSize.sm:
        return 16.0;
      case ShadRadioSize.lg:
        return 24.0;
      case ShadRadioSize.md:
      default:
        return 20.0;
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ShadRadioSize.sm:
        return ShadRadius.full;
      case ShadRadioSize.lg:
        return ShadRadius.full;
      case ShadRadioSize.md:
      default:
        return ShadRadius.full;
    }
  }

  double _getBorderWidth() {
    switch (widget.size) {
      case ShadRadioSize.sm:
        return 1.5;
      case ShadRadioSize.lg:
        return 2.5;
      case ShadRadioSize.md:
      default:
        return 2.0;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadRadioSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadRadioSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadRadioSize.md:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ShadRadioSize.sm:
        return const EdgeInsets.all(ShadSpacing.xs);
      case ShadRadioSize.lg:
        return const EdgeInsets.all(ShadSpacing.sm);
      case ShadRadioSize.md:
      default:
        return const EdgeInsets.all(ShadSpacing.xs);
    }
  }

  Color _getStateColor(ShadThemeData theme) {
    switch (widget.state) {
      case ShadRadioState.success:
        return theme.successColor;
      case ShadRadioState.error:
        return theme.errorColor;
      case ShadRadioState.warning:
        return theme.warningColor;
      case ShadRadioState.normal:
      default:
        return Colors.transparent;
    }
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 100 : 800,
      );
    }

    if (_isSelected) {
      final stateColor = _getStateColor(theme);
      if (stateColor != Colors.transparent) return stateColor;
      return theme.primaryColor;
    }

    switch (widget.variant) {
      case ShadRadioVariant.default_:
        return theme.brightness == Brightness.light
            ? Colors.white
            : ShadBaseColors.getColor(theme.baseColor, 800);
      case ShadRadioVariant.outline:
        return Colors.transparent;
      case ShadRadioVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadRadioVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getBorderColor(ShadThemeData theme) {
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 200 : 700,
      );
    }

    if (_isSelected) {
      final stateColor = _getStateColor(theme);
      if (stateColor != Colors.transparent) return stateColor;
      return theme.primaryColor;
    }

    switch (widget.variant) {
      case ShadRadioVariant.outline:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
      case ShadRadioVariant.default_:
      case ShadRadioVariant.filled:
      case ShadRadioVariant.ghost:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
    }
  }

  Color _getDotColor(ShadThemeData theme) {
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

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return MouseRegion(
          onEnter: !widget.disabled && !widget.loading
              ? (_) => setState(() => _isHovered = true)
              : null,
          onExit: !widget.disabled && !widget.loading
              ? (_) => setState(() => _isHovered = false)
              : null,
          child: GestureDetector(
            onTapDown: !widget.disabled && !widget.loading
                ? (_) => setState(() => _isPressed = true)
                : null,
            onTapUp: !widget.disabled && !widget.loading
                ? (_) => setState(() => _isPressed = false)
                : null,
            onTapCancel: !widget.disabled && !widget.loading
                ? () => setState(() => _isPressed = false)
                : null,
            onTap: _handleTap,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: _getSize(),
                    height: _getSize(),
                    decoration: BoxDecoration(
                      color: _getBackgroundColor(theme),
                      border: Border.all(
                        color: _getBorderColor(theme),
                        width: _getBorderWidth(),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: _isSelected
                        ? Center(
                            child: Container(
                              width: _getSize() * 0.4,
                              height: _getSize() * 0.4,
                              decoration: BoxDecoration(
                                color: _getDotColor(theme),
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                  if (widget.label != null) ...[
                    const SizedBox(width: ShadSpacing.sm),
                    Text(
                      widget.label!,
                      style: TextStyle(
                        color: widget.disabled
                            ? ShadBaseColors.getColor(
                                theme.baseColor,
                                theme.brightness == Brightness.light
                                    ? 400
                                    : 600,
                              )
                            : ShadBaseColors.getColor(
                                theme.baseColor,
                                theme.brightness == Brightness.light ? 900 : 50,
                              ),
                        fontSize: _getFontSize(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (widget.description != null) ...[
                    const SizedBox(width: ShadSpacing.sm),
                    Text(
                      widget.description!,
                      style: TextStyle(
                        color: ShadBaseColors.getColor(
                          theme.baseColor,
                          theme.brightness == Brightness.light ? 500 : 400,
                        ),
                        fontSize: _getFontSize() - 2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
