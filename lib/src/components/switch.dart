import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadSwitchVariant { default_, outline, filled, ghost }

enum ShadSwitchSize { sm, md, lg }

enum ShadSwitchState { normal, success, error, warning }

class ShadSwitch extends StatefulWidget {
  final bool value;
  final String? label;
  final String? description;
  final bool disabled;
  final bool loading;
  final ShadSwitchVariant variant;
  final ShadSwitchSize size;
  final ShadSwitchState state;
  final String? errorText;
  final String? successText;
  final String? warningText;
  final Widget? icon;
  final ValueChanged<bool>? onChanged;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final Color? trackColor;

  const ShadSwitch({
    super.key,
    required this.value,
    this.label,
    this.description,
    this.disabled = false,
    this.loading = false,
    this.variant = ShadSwitchVariant.default_,
    this.size = ShadSwitchSize.md,
    this.state = ShadSwitchState.normal,
    this.errorText,
    this.successText,
    this.warningText,
    this.icon,
    this.onChanged,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.trackColor,
  });

  @override
  State<ShadSwitch> createState() => _ShadSwitchState();
}

class _ShadSwitchState extends State<ShadSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
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
    _slideAnimation =
        Tween<double>(
          begin: widget.value ? 1.0 : 0.0,
          end: widget.value ? 1.0 : 0.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ),
        );
  }

  @override
  void didUpdateWidget(ShadSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _slideAnimation =
          Tween<double>(
            begin: oldWidget.value ? 1.0 : 0.0,
            end: widget.value ? 1.0 : 0.0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: widget.animationCurve,
            ),
          );
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.disabled || widget.loading) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onChanged?.call(!widget.value);
  }

  double _getSize() {
    switch (widget.size) {
      case ShadSwitchSize.sm:
        return 32.0;
      case ShadSwitchSize.lg:
        return 48.0;
      case ShadSwitchSize.md:
      default:
        return 40.0;
    }
  }

  double _getThumbSize() {
    switch (widget.size) {
      case ShadSwitchSize.sm:
        return 12.0;
      case ShadSwitchSize.lg:
        return 20.0;
      case ShadSwitchSize.md:
      default:
        return 16.0;
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ShadSwitchSize.sm:
        return ShadRadius.full;
      case ShadSwitchSize.lg:
        return ShadRadius.full;
      case ShadSwitchSize.md:
      default:
        return ShadRadius.full;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadSwitchSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadSwitchSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadSwitchSize.md:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ShadSwitchSize.sm:
        return const EdgeInsets.all(ShadSpacing.xs);
      case ShadSwitchSize.lg:
        return const EdgeInsets.all(ShadSpacing.sm);
      case ShadSwitchSize.md:
      default:
        return const EdgeInsets.all(ShadSpacing.xs);
    }
  }

  Color _getStateColor(ShadThemeData theme) {
    switch (widget.state) {
      case ShadSwitchState.success:
        return theme.successColor;
      case ShadSwitchState.error:
        return theme.errorColor;
      case ShadSwitchState.warning:
        return theme.warningColor;
      case ShadSwitchState.normal:
      default:
        return Colors.transparent;
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

    final stateColor = _getStateColor(theme);
    if (stateColor != Colors.transparent) return stateColor;

    return theme.primaryColor;
  }

  Color _getInactiveColor(ShadThemeData theme) {
    if (widget.inactiveColor != null) return widget.inactiveColor!;

    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 100 : 800,
      );
    }

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

  Color _getTrackColor(ShadThemeData theme) {
    if (widget.trackColor != null) return widget.trackColor!;

    return widget.value ? _getActiveColor(theme) : _getInactiveColor(theme);
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
                  if (widget.label != null) ...[
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
                    const SizedBox(width: ShadSpacing.sm),
                  ],
                  Container(
                    width: _getSize(),
                    height: _getSize() / 2,
                    decoration: BoxDecoration(
                      color: _getTrackColor(theme),
                      borderRadius: BorderRadius.circular(_getBorderRadius()),
                    ),
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _slideAnimation,
                          builder: (context, child) {
                            return Positioned(
                              left:
                                  _slideAnimation.value *
                                  (_getSize() - _getThumbSize()),
                              top: (_getSize() / 2 - _getThumbSize()) / 2,
                              child: Container(
                                width: _getThumbSize(),
                                height: _getThumbSize(),
                                decoration: BoxDecoration(
                                  color: _getThumbColor(theme),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
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
