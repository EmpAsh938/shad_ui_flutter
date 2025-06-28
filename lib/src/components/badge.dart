import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadBadgeVariant { default_, secondary, destructive, outline, ghost }

enum ShadBadgeSize { sm, md, lg }

enum ShadBadgeShape { rounded, pill, square }

class ShadBadge extends StatefulWidget {
  final Widget? child;
  final String? text;
  final ShadBadgeVariant variant;
  final ShadBadgeSize size;
  final ShadBadgeShape shape;
  final bool disabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final bool showDot;
  final Color? dotColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadBadge({
    super.key,
    this.child,
    this.text,
    this.variant = ShadBadgeVariant.default_,
    this.size = ShadBadgeSize.md,
    this.shape = ShadBadgeShape.rounded,
    this.disabled = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.icon,
    this.showDot = false,
    this.dotColor,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  }) : assert(
         child != null || text != null,
         'Either child or text must be provided',
       );

  @override
  State<ShadBadge> createState() => _ShadBadgeState();
}

class _ShadBadgeState extends State<ShadBadge>
    with SingleTickerProviderStateMixin {
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

  double _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!.topLeft.x;

    switch (widget.shape) {
      case ShadBadgeShape.rounded:
        switch (widget.size) {
          case ShadBadgeSize.sm:
            return ShadRadius.xs;
          case ShadBadgeSize.md:
            return ShadRadius.sm;
          case ShadBadgeSize.lg:
            return ShadRadius.md;
        }
      case ShadBadgeShape.pill:
        return ShadRadius.full;
      case ShadBadgeShape.square:
        return ShadRadius.xs;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    if (widget.padding != null) return widget.padding!;

    switch (widget.size) {
      case ShadBadgeSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.xs,
          vertical: 2,
        );
      case ShadBadgeSize.md:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.sm,
          vertical: 4,
        );
      case ShadBadgeSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.md,
          vertical: 6,
        );
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadBadgeSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadBadgeSize.md:
        return ShadTypography.fontSizeSm;
      case ShadBadgeSize.lg:
        return ShadTypography.fontSizeMd;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ShadBadgeSize.sm:
        return 12.0;
      case ShadBadgeSize.md:
        return 14.0;
      case ShadBadgeSize.lg:
        return 16.0;
    }
  }

  double _getDotSize() {
    switch (widget.size) {
      case ShadBadgeSize.sm:
        return 4.0;
      case ShadBadgeSize.md:
        return 6.0;
      case ShadBadgeSize.lg:
        return 8.0;
    }
  }

  double _getBorderWidth() {
    if (widget.borderWidth != null) return widget.borderWidth!;

    switch (widget.variant) {
      case ShadBadgeVariant.outline:
        return 1.0;
      case ShadBadgeVariant.default_:
      case ShadBadgeVariant.secondary:
      case ShadBadgeVariant.destructive:
      case ShadBadgeVariant.ghost:
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
      case ShadBadgeVariant.default_:
        return theme.primaryColor;
      case ShadBadgeVariant.secondary:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 100 : 800,
        );
      case ShadBadgeVariant.destructive:
        return theme.errorColor;
      case ShadBadgeVariant.outline:
        return Colors.transparent;
      case ShadBadgeVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getTextColor(ShadThemeData theme) {
    if (widget.textColor != null) return widget.textColor!;

    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }

    switch (widget.variant) {
      case ShadBadgeVariant.default_:
        return Colors.white;
      case ShadBadgeVariant.secondary:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 900 : 50,
        );
      case ShadBadgeVariant.destructive:
        return Colors.white;
      case ShadBadgeVariant.outline:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 700 : 300,
        );
      case ShadBadgeVariant.ghost:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 700 : 300,
        );
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
      case ShadBadgeVariant.outline:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
      case ShadBadgeVariant.default_:
      case ShadBadgeVariant.secondary:
      case ShadBadgeVariant.destructive:
      case ShadBadgeVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getDotColor(ShadThemeData theme) {
    if (widget.dotColor != null) return widget.dotColor!;

    return _getTextColor(theme);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            padding: _getPadding(),
            decoration: BoxDecoration(
              color: _getBackgroundColor(theme),
              border: Border.all(
                color: _getBorderColor(theme),
                width: _getBorderWidth(),
              ),
              borderRadius: BorderRadius.circular(_getBorderRadius()),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showDot) ...[
                  Container(
                    width: _getDotSize(),
                    height: _getDotSize(),
                    decoration: BoxDecoration(
                      color: _getDotColor(theme),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                if (widget.icon != null) ...[
                  SizedBox(
                    width: _getIconSize(),
                    height: _getIconSize(),
                    child: IconTheme(
                      data: IconThemeData(
                        color: _getTextColor(theme),
                        size: _getIconSize(),
                      ),
                      child: widget.icon!,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: TextStyle(
                      color: _getTextColor(theme),
                      fontSize: _getFontSize(),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else if (widget.child != null)
                  DefaultTextStyle(
                    style: TextStyle(
                      color: _getTextColor(theme),
                      fontSize: _getFontSize(),
                      fontWeight: FontWeight.w500,
                    ),
                    child: widget.child!,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
