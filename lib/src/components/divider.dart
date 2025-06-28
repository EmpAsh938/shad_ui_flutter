import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadDividerVariant { default_, thin, thick, dashed, dotted }

enum ShadDividerOrientation { horizontal, vertical }

enum ShadDividerSize { sm, md, lg }

class ShadDivider extends StatefulWidget {
  final ShadDividerVariant variant;
  final ShadDividerOrientation orientation;
  final ShadDividerSize size;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Widget? label;
  final bool showLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadDivider({
    super.key,
    this.variant = ShadDividerVariant.default_,
    this.orientation = ShadDividerOrientation.horizontal,
    this.size = ShadDividerSize.md,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.label,
    this.showLabel = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadDivider> createState() => _ShadDividerState();
}

class _ShadDividerState extends State<ShadDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ShadDividerSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadDividerSize.sm:
        return ShadDividerSizeTokens(
          thickness: 1.0,
          spacing: 8.0,
          fontSize: 12.0,
        );
      case ShadDividerSize.lg:
        return ShadDividerSizeTokens(
          thickness: 3.0,
          spacing: 16.0,
          fontSize: 16.0,
        );
      case ShadDividerSize.md:
      default:
        return ShadDividerSizeTokens(
          thickness: 2.0,
          spacing: 12.0,
          fontSize: 14.0,
        );
    }
  }

  ShadDividerVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadDividerVariant.default_:
        return ShadDividerVariantTokens(
          color: widget.color ?? theme.borderColor,
          dashPattern: null,
        );
      case ShadDividerVariant.thin:
        return ShadDividerVariantTokens(
          color: widget.color ?? theme.borderColor,
          dashPattern: null,
        );
      case ShadDividerVariant.thick:
        return ShadDividerVariantTokens(
          color: widget.color ?? theme.borderColor,
          dashPattern: null,
        );
      case ShadDividerVariant.dashed:
        return ShadDividerVariantTokens(
          color: widget.color ?? theme.borderColor,
          dashPattern: [5.0, 5.0],
        );
      case ShadDividerVariant.dotted:
        return ShadDividerVariantTokens(
          color: widget.color ?? theme.borderColor,
          dashPattern: [2.0, 2.0],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
            margin: widget.margin,
            child: widget.orientation == ShadDividerOrientation.horizontal
                ? _buildHorizontalDivider(theme, sizeTokens, variantTokens)
                : _buildVerticalDivider(theme, sizeTokens, variantTokens),
          ),
        );
      },
    );
  }

  Widget _buildHorizontalDivider(
    ShadThemeData theme,
    ShadDividerSizeTokens sizeTokens,
    ShadDividerVariantTokens variantTokens,
  ) {
    if (widget.showLabel && widget.label != null) {
      return Row(
        children: [
          Expanded(
            child: _buildDividerLine(
              theme,
              sizeTokens,
              variantTokens,
              isHorizontal: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeTokens.spacing),
            child: widget.label!,
          ),
          Expanded(
            child: _buildDividerLine(
              theme,
              sizeTokens,
              variantTokens,
              isHorizontal: true,
            ),
          ),
        ],
      );
    }

    return _buildDividerLine(
      theme,
      sizeTokens,
      variantTokens,
      isHorizontal: true,
    );
  }

  Widget _buildVerticalDivider(
    ShadThemeData theme,
    ShadDividerSizeTokens sizeTokens,
    ShadDividerVariantTokens variantTokens,
  ) {
    return _buildDividerLine(
      theme,
      sizeTokens,
      variantTokens,
      isHorizontal: false,
    );
  }

  Widget _buildDividerLine(
    ShadThemeData theme,
    ShadDividerSizeTokens sizeTokens,
    ShadDividerVariantTokens variantTokens, {
    required bool isHorizontal,
  }) {
    final thickness = widget.variant == ShadDividerVariant.thin
        ? sizeTokens.thickness * 0.5
        : widget.variant == ShadDividerVariant.thick
        ? sizeTokens.thickness * 2.0
        : sizeTokens.thickness;

    if (variantTokens.dashPattern != null) {
      return CustomPaint(
        size: Size(
          isHorizontal ? (widget.width ?? double.infinity) : thickness,
          isHorizontal ? thickness : (widget.height ?? double.infinity),
        ),
        painter: _DashedLinePainter(
          color: variantTokens.color,
          dashPattern: variantTokens.dashPattern!,
          isHorizontal: isHorizontal,
        ),
      );
    }

    return Container(
      width: isHorizontal ? (widget.width ?? double.infinity) : thickness,
      height: isHorizontal ? thickness : (widget.height ?? double.infinity),
      color: variantTokens.color,
    );
  }
}

class ShadDividerSizeTokens {
  final double thickness;
  final double spacing;
  final double fontSize;

  const ShadDividerSizeTokens({
    required this.thickness,
    required this.spacing,
    required this.fontSize,
  });
}

class ShadDividerVariantTokens {
  final Color color;
  final List<double>? dashPattern;

  const ShadDividerVariantTokens({required this.color, this.dashPattern});
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final List<double> dashPattern;
  final bool isHorizontal;

  _DashedLinePainter({
    required this.color,
    required this.dashPattern,
    required this.isHorizontal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = isHorizontal ? size.height : size.width
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (isHorizontal) {
      double currentX = 0;
      bool drawDash = true;
      int dashIndex = 0;

      while (currentX < size.width) {
        final dashLength = dashPattern[dashIndex % dashPattern.length];

        if (drawDash) {
          path.moveTo(currentX, size.height / 2);
          path.lineTo(currentX + dashLength, size.height / 2);
        }

        currentX += dashLength;
        drawDash = !drawDash;
        dashIndex++;
      }
    } else {
      double currentY = 0;
      bool drawDash = true;
      int dashIndex = 0;

      while (currentY < size.height) {
        final dashLength = dashPattern[dashIndex % dashPattern.length];

        if (drawDash) {
          path.moveTo(size.width / 2, currentY);
          path.lineTo(size.width / 2, currentY + dashLength);
        }

        currentY += dashLength;
        drawDash = !drawDash;
        dashIndex++;
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashPattern != dashPattern ||
        oldDelegate.isHorizontal != isHorizontal;
  }
}
