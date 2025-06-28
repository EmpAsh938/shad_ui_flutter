import 'package:flutter/material.dart';
import '../tokens/tokens.dart';
import '../theme/shad_theme.dart';

/// A mobile-specific floating action button with customizable styles,
/// animations, and extended functionality.
class ShadFloatingActionButton extends StatefulWidget {
  /// Creates a floating action button widget.
  const ShadFloatingActionButton({
    super.key,
    required this.onPressed,
    this.child,
    this.icon,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.focusElevation = 8.0,
    this.hoverElevation = 4.0,
    this.highlightElevation = 12.0,
    this.disabledElevation = 0.0,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.isExtended = false,
    this.tooltip,
    this.enableFeedback = true,
    this.heroTag,
    this.size = ShadFABSize.normal,
    this.variant = ShadFABVariant.primary,
    this.animationDuration = const Duration(milliseconds: 200),
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
  });

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The icon to display in the button.
  final IconData? icon;

  /// The label to display when the button is extended.
  final String? label;

  /// Background color of the button.
  final Color? backgroundColor;

  /// Foreground color of the button.
  final Color? foregroundColor;

  /// Elevation of the button.
  final double elevation;

  /// Elevation when the button is focused.
  final double focusElevation;

  /// Elevation when the button is hovered.
  final double hoverElevation;

  /// Elevation when the button is highlighted.
  final double highlightElevation;

  /// Elevation when the button is disabled.
  final double disabledElevation;

  /// Shape of the button.
  final ShapeBorder? shape;

  /// Clip behavior of the button.
  final Clip clipBehavior;

  /// Focus node for the button.
  final FocusNode? focusNode;

  /// Whether the button should autofocus.
  final bool autofocus;

  /// Material tap target size.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Whether the button is extended.
  final bool isExtended;

  /// Tooltip for the button.
  final String? tooltip;

  /// Whether to enable haptic feedback.
  final bool enableFeedback;

  /// Hero tag for the button.
  final Object? heroTag;

  /// Size of the floating action button.
  final ShadFABSize size;

  /// Variant of the floating action button.
  final ShadFABVariant variant;

  /// Duration of the animation.
  final Duration animationDuration;

  /// Callback when the button is long pressed.
  final VoidCallback? onLongPress;

  /// Callback when the button is hovered.
  final ValueChanged<bool>? onHover;

  /// Callback when the button focus changes.
  final ValueChanged<bool>? onFocusChange;

  @override
  State<ShadFloatingActionButton> createState() =>
      _ShadFloatingActionButtonState();
}

class _ShadFloatingActionButtonState extends State<ShadFloatingActionButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  _FABColors _getColors(ShadThemeData theme) {
    Color backgroundColor;
    Color foregroundColor;

    switch (widget.variant) {
      case ShadFABVariant.primary:
        backgroundColor = widget.backgroundColor ?? theme.primaryColor;
        foregroundColor =
            widget.foregroundColor ??
            (backgroundColor.computeLuminance() > 0.5
                ? Colors.black
                : Colors.white);
        break;
      case ShadFABVariant.secondary:
        backgroundColor = widget.backgroundColor ?? theme.secondaryColor;
        foregroundColor = widget.foregroundColor ?? theme.textColor;
        break;
      case ShadFABVariant.surface:
        backgroundColor = widget.backgroundColor ?? theme.cardColor;
        foregroundColor = widget.foregroundColor ?? theme.textColor;
        break;
      case ShadFABVariant.outline:
        backgroundColor = widget.backgroundColor ?? Colors.transparent;
        foregroundColor = widget.foregroundColor ?? theme.primaryColor;
        break;
    }

    return _FABColors(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  double _getButtonSize() {
    switch (widget.size) {
      case ShadFABSize.small:
        return 40.0;
      case ShadFABSize.large:
        return 72.0;
      case ShadFABSize.normal:
        return 56.0;
    }
  }

  ShapeBorder _getButtonShape() {
    return widget.shape ?? const CircleBorder();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    final colors = _getColors(theme);
    final buttonSize = _getButtonSize();

    Widget button = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: colors.backgroundColor,
              shape: BoxShape.circle,
              border: widget.variant == ShadFABVariant.outline
                  ? Border.all(color: colors.foregroundColor, width: 2.0)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: widget.elevation,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onPressed,
                onLongPress: widget.onLongPress,
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                borderRadius: BorderRadius.circular(buttonSize / 2),
                child: Container(
                  width: buttonSize,
                  height: buttonSize,
                  child: Center(
                    child:
                        widget.child ??
                        (widget.icon != null
                            ? Icon(
                                widget.icon,
                                color: colors.foregroundColor,
                                size: buttonSize * 0.4,
                              )
                            : null),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (widget.isExtended && widget.label != null) {
      button = Container(
        height: buttonSize,
        padding: const EdgeInsets.symmetric(horizontal: ShadSpacing.md),
        decoration: BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(buttonSize / 2),
          border: widget.variant == ShadFABVariant.outline
              ? Border.all(color: colors.foregroundColor, width: 2.0)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: widget.elevation,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            onLongPress: widget.onLongPress,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            borderRadius: BorderRadius.circular(buttonSize / 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: colors.foregroundColor,
                    size: buttonSize * 0.4,
                  ),
                  const SizedBox(width: ShadSpacing.sm),
                ],
                Text(
                  widget.label!,
                  style: TextStyle(
                    color: colors.foregroundColor,
                    fontSize: ShadTypography.fontSizeMd,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return button;
  }
}

/// Colors for the floating action button.
class _FABColors {
  const _FABColors({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
}

/// Size options for the floating action button.
enum ShadFABSize {
  /// Small size (40x40).
  small,

  /// Normal size (56x56).
  normal,

  /// Large size (72x72).
  large,
}

/// Variant options for the floating action button.
enum ShadFABVariant {
  /// Primary variant with primary color.
  primary,

  /// Secondary variant with secondary color.
  secondary,

  /// Surface variant with surface color.
  surface,

  /// Outline variant with transparent background and border.
  outline,
}

/// A speed dial floating action button that expands to show multiple actions.
class ShadSpeedDial extends StatefulWidget {
  /// Creates a speed dial widget.
  const ShadSpeedDial({
    super.key,
    required this.children,
    this.icon,
    this.activeIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.overlayColor,
    this.tooltip,
    this.heroTag,
    this.animatedIcon,
    this.animatedIconTheme,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.isExtended = false,
    this.enableFeedback = true,
    this.visible = true,
    this.closeManually = false,
    this.renderOverlay = true,
    this.useRotationAnimation = true,
    this.curve = Curves.easeInOut,
    this.openCloseDial,
    this.onOpen,
    this.onClose,
    this.onPress,
    this.animationDuration = const Duration(milliseconds: 200),
    this.spaceBetweenChildren = 16.0,
    this.buttonSize = 56.0,
    this.childrenButtonSize = 40.0,
  });

  /// The child buttons to display when expanded.
  final List<ShadSpeedDialChild> children;

  /// The icon to display when closed.
  final IconData? icon;

  /// The icon to display when open.
  final IconData? activeIcon;

  /// Background color of the main button.
  final Color? backgroundColor;

  /// Foreground color of the main button.
  final Color? foregroundColor;

  /// Elevation of the button.
  final double elevation;

  /// Overlay color when pressed.
  final Color? overlayColor;

  /// Tooltip for the button.
  final String? tooltip;

  /// Hero tag for the button.
  final Object? heroTag;

  /// Animated icon for the button.
  final AnimatedIconData? animatedIcon;

  /// Theme for the animated icon.
  final IconThemeData? animatedIconTheme;

  /// Shape of the button.
  final ShapeBorder? shape;

  /// Clip behavior of the button.
  final Clip clipBehavior;

  /// Focus node for the button.
  final FocusNode? focusNode;

  /// Whether the button should autofocus.
  final bool autofocus;

  /// Material tap target size.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Whether the button is extended.
  final bool isExtended;

  /// Whether to enable haptic feedback.
  final bool enableFeedback;

  /// Whether the speed dial is visible.
  final bool visible;

  /// Whether the speed dial should be closed manually.
  final bool closeManually;

  /// Whether to render the overlay.
  final bool renderOverlay;

  /// Whether to use rotation animation.
  final bool useRotationAnimation;

  /// Animation curve.
  final Curve curve;

  /// Callback to open/close the dial.
  final ValueChanged<bool>? openCloseDial;

  /// Callback when the dial opens.
  final VoidCallback? onOpen;

  /// Callback when the dial closes.
  final VoidCallback? onClose;

  /// Callback when the main button is pressed.
  final VoidCallback? onPress;

  /// Duration of the animation.
  final Duration animationDuration;

  /// Space between child buttons.
  final double spaceBetweenChildren;

  /// Size of the main button.
  final double buttonSize;

  /// Size of the child buttons.
  final double childrenButtonSize;

  @override
  State<ShadSpeedDial> createState() => _ShadSpeedDialState();
}

class _ShadSpeedDialState extends State<ShadSpeedDial>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });

    if (_isOpen) {
      _animationController.forward();
      widget.onOpen?.call();
    } else {
      _animationController.reverse();
      widget.onClose?.call();
    }

    widget.openCloseDial?.call(_isOpen);
  }

  void _onChildPressed(ShadSpeedDialChild child) {
    child.onPressed?.call();

    if (!widget.closeManually) {
      _toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return const SizedBox.shrink();

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Overlay
        if (widget.renderOverlay && _isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              child: Container(color: Colors.black.withValues(alpha: 0.3)),
            ),
          ),

        // Child buttons
        ...widget.children.asMap().entries.map((entry) {
          final index = entry.key;
          final child = entry.value;
          final offset =
              (index + 1) *
              (widget.childrenButtonSize + widget.spaceBetweenChildren);

          return AnimatedBuilder(
            animation: _animation,
            builder: (context, childWidget) {
              final progress = _animation.value;
              final translateY = offset * (1 - progress);
              final opacity = progress;
              final scale = 0.5 + (0.5 * progress);

              return Transform.translate(
                offset: Offset(0, translateY),
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: widget.childrenButtonSize,
                      height: widget.childrenButtonSize,
                      margin: const EdgeInsets.only(bottom: ShadSpacing.sm),
                      child: ShadFloatingActionButton(
                        onPressed: () => _onChildPressed(child),
                        icon: child.icon,
                        backgroundColor: child.backgroundColor,
                        foregroundColor: child.foregroundColor,
                        size: ShadFABSize.small,
                        tooltip: child.label,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),

        // Main button
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final rotation = widget.useRotationAnimation
                ? _animation.value * 0.5
                : 0.0;

            return Transform.rotate(
              angle: rotation * 3.14159,
              child: ShadFloatingActionButton(
                onPressed: widget.onPress ?? _toggle,
                icon: _isOpen ? widget.activeIcon : widget.icon,
                backgroundColor: widget.backgroundColor,
                foregroundColor: widget.foregroundColor,
                elevation: widget.elevation,
                tooltip: widget.tooltip,
                heroTag: widget.heroTag,
                size: ShadFABSize.normal,
              ),
            );
          },
        ),
      ],
    );
  }
}

/// A child button for the speed dial.
class ShadSpeedDialChild {
  /// Creates a speed dial child.
  const ShadSpeedDialChild({
    required this.icon,
    this.label,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  /// The icon to display.
  final IconData icon;

  /// The label for the tooltip.
  final String? label;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// Background color of the button.
  final Color? backgroundColor;

  /// Foreground color of the button.
  final Color? foregroundColor;
}
