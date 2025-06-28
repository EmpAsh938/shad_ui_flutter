import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadButtonVariant {
  primary,
  secondary,
  destructive,
  outline,
  ghost,
  link,
  icon,
}

enum ShadButtonSize { sm, md, lg }

enum ShadButtonShape { rounded, pill, square }

enum ShadIconPosition { left, right, top, bottom }

enum ShadLoadingType { spinner, dots, skeleton }

class ShadButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final ShadButtonVariant variant;
  final ShadButtonSize size;
  final ShadButtonShape shape;
  final ShadIconPosition iconPosition;
  final ShadLoadingType loadingType;
  final Widget? icon;
  final bool loading;
  final bool disabled;
  final bool fullWidth;
  final ButtonStyle? style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? border;
  final double opacity;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final String? semanticsLabel;
  final bool autofocus;
  final Duration animationDuration;
  final Curve animationCurve;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onHover;
  final VoidCallback? onLongPress;

  const ShadButton({
    super.key,
    required this.onPressed,
    this.child,
    this.variant = ShadButtonVariant.primary,
    this.size = ShadButtonSize.md,
    this.shape = ShadButtonShape.rounded,
    this.iconPosition = ShadIconPosition.left,
    this.loadingType = ShadLoadingType.spinner,
    this.icon,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
    this.border,
    this.opacity = 1.0,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.semanticsLabel,
    this.autofocus = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.shadows,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.onHover,
    this.onLongPress,
  });

  @override
  State<ShadButton> createState() => _ShadButtonState();
}

class _ShadButtonState extends State<ShadButton> with TickerProviderStateMixin {
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

  bool get _isInteractive =>
      !widget.loading && !widget.disabled && widget.onPressed != null;

  double _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!.topLeft.x;

    switch (widget.shape) {
      case ShadButtonShape.rounded:
        switch (widget.size) {
          case ShadButtonSize.sm:
            return ShadRadius.sm;
          case ShadButtonSize.md:
            return ShadRadius.md;
          case ShadButtonSize.lg:
            return ShadRadius.lg;
        }
      case ShadButtonShape.pill:
        return ShadRadius.full;
      case ShadButtonShape.square:
        return ShadRadius.xs;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    if (widget.padding != null) return widget.padding!;

    switch (widget.size) {
      case ShadButtonSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.md,
          vertical: ShadSpacing.sm,
        );
      case ShadButtonSize.md:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.lg,
          vertical: ShadSpacing.md,
        );
      case ShadButtonSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.xl,
          vertical: ShadSpacing.lg,
        );
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadButtonSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadButtonSize.md:
        return ShadTypography.fontSizeMd;
      case ShadButtonSize.lg:
        return ShadTypography.fontSizeLg;
    }
  }

  Color _backgroundColor(ShadThemeData theme) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    final baseColor = widget.disabled
        ? ShadBaseColors.getColor(
            theme.baseColor,
            theme.brightness == Brightness.light ? 200 : 800,
          )
        : ShadBaseColors.getColor(
            theme.baseColor,
            theme.brightness == Brightness.light ? 900 : 50,
          );

    switch (widget.variant) {
      case ShadButtonVariant.primary:
        return baseColor;
      case ShadButtonVariant.secondary:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 100 : 800,
        );
      case ShadButtonVariant.destructive:
        return theme.errorColor;
      case ShadButtonVariant.outline:
      case ShadButtonVariant.ghost:
        return theme.brightness == Brightness.light
            ? ShadBaseColors.getColor(theme.baseColor, 50)
            : ShadBaseColors.getColor(theme.baseColor, 900);
      case ShadButtonVariant.link:
        return Colors.transparent;
      case ShadButtonVariant.icon:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
    }
  }

  Color _foregroundColor(ShadThemeData theme) {
    if (widget.foregroundColor != null) return widget.foregroundColor!;

    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }

    switch (widget.variant) {
      case ShadButtonVariant.primary:
        return theme.brightness == Brightness.light
            ? Colors.white
            : Colors.black;
      case ShadButtonVariant.destructive:
        return Colors.white;
      case ShadButtonVariant.secondary:
      case ShadButtonVariant.outline:
      case ShadButtonVariant.ghost:
      case ShadButtonVariant.link:
        return theme.brightness == Brightness.light
            ? Colors.black
            : Colors.white;
      case ShadButtonVariant.icon:
        return theme.brightness == Brightness.light
            ? Colors.black
            : Colors.white;
    }
  }

  BorderSide _borderSide(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadButtonVariant.outline:
        return BorderSide(color: _foregroundColor(theme), width: 1.0);
      case ShadButtonVariant.secondary:
        return BorderSide(
          color: ShadBaseColors.getColor(
            theme.baseColor,
            theme.brightness == Brightness.light ? 200 : 700,
          ),
          width: 1.0,
        );
      case ShadButtonVariant.destructive:
        return BorderSide(color: theme.errorColor, width: 1.5);
      case ShadButtonVariant.primary:
      case ShadButtonVariant.ghost:
      case ShadButtonVariant.link:
      case ShadButtonVariant.icon:
        return BorderSide.none;
    }
  }

  Widget _buildLoadingIndicator(ShadThemeData theme) {
    switch (widget.loadingType) {
      case ShadLoadingType.spinner:
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(_foregroundColor(theme)),
          ),
        );
      case ShadLoadingType.dots:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _foregroundColor(theme),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      case ShadLoadingType.skeleton:
        return Container(
          width: 60,
          height: 16,
          decoration: BoxDecoration(
            color: _foregroundColor(theme).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
    }
  }

  Widget _buildContent(ShadThemeData theme) {
    if (widget.loading) {
      return _buildLoadingIndicator(theme);
    }

    if (widget.variant == ShadButtonVariant.icon) {
      return widget.icon ?? const SizedBox.shrink();
    }

    final List<Widget> children = [];

    if (widget.icon != null) {
      switch (widget.iconPosition) {
        case ShadIconPosition.left:
          children.addAll([
            widget.icon!,
            if (widget.child != null) const SizedBox(width: 8),
          ]);
          break;
        case ShadIconPosition.right:
          if (widget.child != null) children.add(const SizedBox(width: 8));
          children.add(widget.icon!);
          break;
        case ShadIconPosition.top:
          children.addAll([
            widget.icon!,
            if (widget.child != null) const SizedBox(height: 4),
          ]);
          break;
        case ShadIconPosition.bottom:
          if (widget.child != null) children.add(const SizedBox(height: 4));
          children.add(widget.icon!);
          break;
      }
    }

    if (widget.child != null) {
      children.add(widget.child!);
    }

    if (children.isEmpty) return const SizedBox.shrink();

    switch (widget.iconPosition) {
      case ShadIconPosition.left:
      case ShadIconPosition.right:
        return Row(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
      case ShadIconPosition.top:
      case ShadIconPosition.bottom:
        return Column(
          mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final content = _buildContent(theme);

    final ButtonStyle buttonStyle =
        widget.style ??
        ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return _backgroundColor(theme).withValues(alpha: 0.5);
            }
            if (states.contains(WidgetState.pressed)) {
              return _backgroundColor(theme).withValues(alpha: 0.8);
            }
            if (states.contains(WidgetState.hovered)) {
              return _backgroundColor(theme).withValues(alpha: 0.9);
            }
            return _backgroundColor(theme);
          }),
          foregroundColor: WidgetStateProperty.all(_foregroundColor(theme)),
          overlayColor: WidgetStateProperty.all(
            _foregroundColor(theme).withValues(alpha: 0.08),
          ),
          padding: WidgetStateProperty.all(_getPadding()),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_getBorderRadius()),
              side: _borderSide(theme),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontFamily: ShadTypography.fontFamily,
              fontSize: _getFontSize(),
              fontWeight: ShadTypography.fontWeightBold,
              decoration: widget.variant == ShadButtonVariant.link
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return 0;
            if (states.contains(WidgetState.pressed)) return 1;
            return widget.variant == ShadButtonVariant.primary ? 2 : 0;
          }),
          minimumSize: WidgetStateProperty.all(
            Size(
              widget.minWidth ?? (widget.fullWidth ? double.infinity : 0),
              widget.minHeight ?? 0,
            ),
          ),
          maximumSize: WidgetStateProperty.all(
            Size(
              widget.maxWidth ?? double.infinity,
              widget.maxHeight ?? double.infinity,
            ),
          ),
          shadowColor: WidgetStateProperty.all(Colors.black),
        );

    Widget buttonWidget;
    switch (widget.variant) {
      case ShadButtonVariant.link:
        buttonWidget = TextButton(
          onPressed: _isInteractive ? widget.onPressed : null,
          onLongPress: _isInteractive ? widget.onLongPress : null,
          style: buttonStyle,
          child: content,
        );
        break;
      case ShadButtonVariant.ghost:
        buttonWidget = TextButton(
          onPressed: _isInteractive ? widget.onPressed : null,
          onLongPress: _isInteractive ? widget.onLongPress : null,
          style: buttonStyle,
          child: content,
        );
        break;
      case ShadButtonVariant.icon:
        buttonWidget = IconButton(
          onPressed: _isInteractive ? widget.onPressed : null,
          onLongPress: _isInteractive ? widget.onLongPress : null,
          icon: content,
          color: _foregroundColor(theme),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(_backgroundColor(theme)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                side: _borderSide(theme),
              ),
            ),
            iconColor: WidgetStateProperty.all(_foregroundColor(theme)),
            minimumSize: WidgetStateProperty.all(
              Size(widget.minWidth ?? 0, widget.minHeight ?? 0),
            ),
            maximumSize: WidgetStateProperty.all(
              Size(
                widget.maxWidth ?? double.infinity,
                widget.maxHeight ?? double.infinity,
              ),
            ),
          ),
        );
        break;
      case ShadButtonVariant.primary:
      case ShadButtonVariant.secondary:
      case ShadButtonVariant.outline:
      case ShadButtonVariant.destructive:
        buttonWidget = ElevatedButton(
          onPressed: _isInteractive ? widget.onPressed : null,
          onLongPress: _isInteractive ? widget.onLongPress : null,
          style: buttonStyle,
          child: content,
        );
        break;
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: widget.opacity,
            child: Container(
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                boxShadow: widget.shadows,
              ),
              child: MouseRegion(
                onEnter: (_) {
                  widget.onHover?.call();
                },
                onExit: (_) {
                  // Handle exit if needed
                },
                child: GestureDetector(
                  onTapDown: (_) {
                    if (_isInteractive) {
                      _animationController.forward();
                    }
                  },
                  onTapUp: (_) {
                    if (_isInteractive) {
                      _animationController.reverse();
                    }
                  },
                  onTapCancel: () {
                    if (_isInteractive) {
                      _animationController.reverse();
                    }
                  },
                  child: Semantics(
                    label:
                        widget.semanticsLabel ??
                        (widget.child is Text
                            ? (widget.child as Text).data
                            : 'Button'),
                    button: true,
                    enabled: _isInteractive,
                    child: Focus(
                      autofocus: widget.autofocus,
                      child: buttonWidget,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
