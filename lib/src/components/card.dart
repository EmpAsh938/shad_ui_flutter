import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadCardVariant { default_, outline, filled, ghost }

enum ShadCardSize { sm, md, lg }

class ShadCard extends StatefulWidget {
  final Widget? child;
  final Widget? header;
  final Widget? footer;
  final ShadCardVariant variant;
  final ShadCardSize size;
  final bool interactive;
  final bool disabled;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final double opacity;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadCard({
    super.key,
    this.child,
    this.header,
    this.footer,
    this.variant = ShadCardVariant.default_,
    this.size = ShadCardSize.md,
    this.interactive = false,
    this.disabled = false,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.shadows,
    this.gradient,
    this.opacity = 1.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadCard> createState() => _ShadCardState();
}

class _ShadCardState extends State<ShadCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
    _elevationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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

  bool get _isInteractive =>
      widget.interactive &&
      !widget.disabled &&
      (widget.onTap != null || widget.onLongPress != null);

  double _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!.topLeft.x;

    switch (widget.size) {
      case ShadCardSize.sm:
        return ShadRadius.sm;
      case ShadCardSize.md:
        return ShadRadius.md;
      case ShadCardSize.lg:
        return ShadRadius.lg;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    if (widget.padding != null) return widget.padding!;

    switch (widget.size) {
      case ShadCardSize.sm:
        return const EdgeInsets.all(ShadSpacing.sm);
      case ShadCardSize.md:
        return const EdgeInsets.all(ShadSpacing.md);
      case ShadCardSize.lg:
        return const EdgeInsets.all(ShadSpacing.lg);
    }
  }

  EdgeInsetsGeometry _getMargin() {
    if (widget.margin != null) return widget.margin!;

    switch (widget.size) {
      case ShadCardSize.sm:
        return const EdgeInsets.all(ShadSpacing.xs);
      case ShadCardSize.md:
        return const EdgeInsets.all(ShadSpacing.sm);
      case ShadCardSize.lg:
        return const EdgeInsets.all(ShadSpacing.md);
    }
  }

  double _getBorderWidth() {
    if (widget.borderWidth != null) return widget.borderWidth!;

    switch (widget.variant) {
      case ShadCardVariant.outline:
        return 1.0;
      case ShadCardVariant.default_:
      case ShadCardVariant.filled:
      case ShadCardVariant.ghost:
        return 0.0;
    }
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 100 : 800,
      );
    }

    switch (widget.variant) {
      case ShadCardVariant.default_:
        return theme.brightness == Brightness.light
            ? Colors.white
            : ShadBaseColors.getColor(theme.baseColor, 800);
      case ShadCardVariant.outline:
        return Colors.transparent;
      case ShadCardVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadCardVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getBorderColor(ShadThemeData theme) {
    if (widget.borderColor != null) return widget.borderColor!;

    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 200 : 700,
      );
    }

    switch (widget.variant) {
      case ShadCardVariant.outline:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
      case ShadCardVariant.default_:
      case ShadCardVariant.filled:
      case ShadCardVariant.ghost:
        return Colors.transparent;
    }
  }

  List<BoxShadow> _getShadows(ShadThemeData theme) {
    if (widget.shadows != null) return widget.shadows!;

    if (widget.disabled) return [];

    final baseColor = ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 900 : 50,
    );

    switch (widget.variant) {
      case ShadCardVariant.default_:
        return [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ];
      case ShadCardVariant.outline:
      case ShadCardVariant.filled:
      case ShadCardVariant.ghost:
        return [];
    }
  }

  void _handleTap() {
    if (!_isInteractive) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onTap?.call();
  }

  void _handleLongPress() {
    if (!_isInteractive) return;

    widget.onLongPress?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return MouseRegion(
          onEnter: _isInteractive
              ? (_) => setState(() => _isHovered = true)
              : null,
          onExit: _isInteractive
              ? (_) => setState(() => _isHovered = false)
              : null,
          child: GestureDetector(
            onTapDown: _isInteractive
                ? (_) => setState(() => _isPressed = true)
                : null,
            onTapUp: _isInteractive
                ? (_) => setState(() => _isPressed = false)
                : null,
            onTapCancel: _isInteractive
                ? () => setState(() => _isPressed = false)
                : null,
            onTap: _handleTap,
            onLongPress: _handleLongPress,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: _getMargin(),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(theme),
                  border: Border.all(
                    color: _getBorderColor(theme),
                    width: _getBorderWidth(),
                  ),
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                  boxShadow: _getShadows(theme),
                  gradient: widget.gradient,
                ),
                child: Opacity(
                  opacity: widget.opacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.header != null)
                        Container(
                          padding: EdgeInsets.only(
                            left: _getPadding().resolve(TextDirection.ltr).left,
                            right: _getPadding()
                                .resolve(TextDirection.ltr)
                                .right,
                            top: _getPadding().resolve(TextDirection.ltr).top,
                          ),
                          child: widget.header!,
                        ),
                      if (widget.child != null)
                        Container(padding: _getPadding(), child: widget.child!),
                      if (widget.footer != null)
                        Container(
                          padding: EdgeInsets.only(
                            left: _getPadding().resolve(TextDirection.ltr).left,
                            right: _getPadding()
                                .resolve(TextDirection.ltr)
                                .right,
                            bottom: _getPadding()
                                .resolve(TextDirection.ltr)
                                .bottom,
                          ),
                          child: widget.footer!,
                        ),
                    ],
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
