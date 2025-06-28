import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';

enum ShadTooltipVariant { default_, destructive, warning, success, info }

enum ShadTooltipSize { sm, md, lg }

enum ShadTooltipPosition {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class ShadTooltip extends StatefulWidget {
  final String message;
  final Widget child;
  final ShadTooltipVariant variant;
  final ShadTooltipSize size;
  final ShadTooltipPosition position;
  final Duration showDuration;
  final Duration hideDuration;
  final bool showArrow;
  final ShadThemeData? theme;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadTooltip({
    super.key,
    required this.message,
    required this.child,
    this.variant = ShadTooltipVariant.default_,
    this.size = ShadTooltipSize.md,
    this.position = ShadTooltipPosition.top,
    this.showDuration = const Duration(seconds: 2),
    this.hideDuration = const Duration(milliseconds: 300),
    this.showArrow = true,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadTooltip> createState() => _ShadTooltipState();
}

class _ShadTooltipState extends State<ShadTooltip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;
  OverlayEntry? _overlayEntry;
  Timer? _showTimer;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _slideAnimation = Tween<Offset>(begin: _getSlideOffset(), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _showTimer?.cancel();
    _hideTimer?.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }

  Offset _getSlideOffset() {
    switch (widget.position) {
      case ShadTooltipPosition.top:
      case ShadTooltipPosition.topLeft:
      case ShadTooltipPosition.topRight:
        return const Offset(0, 0.1);
      case ShadTooltipPosition.bottom:
      case ShadTooltipPosition.bottomLeft:
      case ShadTooltipPosition.bottomRight:
        return const Offset(0, -0.1);
      case ShadTooltipPosition.left:
        return const Offset(0.1, 0);
      case ShadTooltipPosition.right:
        return const Offset(-0.1, 0);
    }
  }

  void _showTooltip() {
    if (_isVisible) return;

    setState(() => _isVisible = true);
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();

    if (widget.showDuration != Duration.zero) {
      _showTimer = Timer(widget.showDuration, _hideTooltip);
    }
  }

  void _hideTooltip() {
    if (!_isVisible) return;

    setState(() => _isVisible = false);
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  void _handleMouseEnter() {
    _hideTimer?.cancel();
    _showTooltip();
  }

  void _handleMouseExit() {
    _showTimer?.cancel();
    _hideTimer = Timer(widget.hideDuration, _hideTooltip);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => _TooltipOverlay(
        tooltip: this,
        position: widget.position,
        animationController: _animationController,
        fadeAnimation: _fadeAnimation,
        scaleAnimation: _scaleAnimation,
        slideAnimation: _slideAnimation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleMouseEnter(),
      onExit: (_) => _handleMouseExit(),
      child: GestureDetector(
        onTapDown: (_) => _handleMouseEnter(),
        onTapUp: (_) => _handleMouseExit(),
        onTapCancel: () => _handleMouseExit(),
        child: widget.child,
      ),
    );
  }
}

class _TooltipOverlay extends StatelessWidget {
  final _ShadTooltipState tooltip;
  final ShadTooltipPosition position;
  final AnimationController animationController;
  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;
  final Animation<Offset> slideAnimation;

  const _TooltipOverlay({
    required this.tooltip,
    required this.position,
    required this.animationController,
    required this.fadeAnimation,
    required this.scaleAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: _TooltipContent(tooltip: tooltip, position: position),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TooltipContent extends StatelessWidget {
  final _ShadTooltipState tooltip;
  final ShadTooltipPosition position;

  const _TooltipContent({required this.tooltip, required this.position});

  @override
  Widget build(BuildContext context) {
    final theme = tooltip.widget.theme ?? ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomSingleChildLayout(
          delegate: _TooltipLayoutDelegate(position),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: sizeTokens.maxWidth,
              minWidth: sizeTokens.minWidth,
            ),
            padding: EdgeInsets.all(sizeTokens.padding),
            decoration: BoxDecoration(
              color: variantTokens.backgroundColor,
              border: Border.all(
                color: variantTokens.borderColor,
                width: sizeTokens.borderWidth,
              ),
              borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (tooltip.widget.showArrow && _shouldShowTopArrow()) ...[
                  _buildArrow(variantTokens, sizeTokens, true),
                  SizedBox(height: sizeTokens.arrowSpacing),
                ],
                Text(
                  tooltip.widget.message,
                  style: TextStyle(
                    fontSize: sizeTokens.textSize,
                    color: variantTokens.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (tooltip.widget.showArrow && _shouldShowBottomArrow()) ...[
                  SizedBox(height: sizeTokens.arrowSpacing),
                  _buildArrow(variantTokens, sizeTokens, false),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  bool _shouldShowTopArrow() {
    return position == ShadTooltipPosition.bottom ||
        position == ShadTooltipPosition.bottomLeft ||
        position == ShadTooltipPosition.bottomRight;
  }

  bool _shouldShowBottomArrow() {
    return position == ShadTooltipPosition.top ||
        position == ShadTooltipPosition.topLeft ||
        position == ShadTooltipPosition.topRight;
  }

  Widget _buildArrow(
    ShadTooltipVariantTokens variantTokens,
    ShadTooltipSizeTokens sizeTokens,
    bool pointingUp,
  ) {
    return CustomPaint(
      size: Size(sizeTokens.arrowSize, sizeTokens.arrowSize),
      painter: _ArrowPainter(
        color: variantTokens.backgroundColor,
        borderColor: variantTokens.borderColor,
        borderWidth: sizeTokens.borderWidth,
        pointingUp: pointingUp,
      ),
    );
  }

  ShadTooltipSizeTokens _getSizeTokens() {
    switch (tooltip.widget.size) {
      case ShadTooltipSize.sm:
        return ShadTooltipSizeTokens(
          padding: 8,
          maxWidth: 200,
          minWidth: 100,
          textSize: 12,
          borderWidth: 1,
          borderRadius: 4,
          arrowSize: 8,
          arrowSpacing: 4,
        );
      case ShadTooltipSize.md:
        return ShadTooltipSizeTokens(
          padding: 12,
          maxWidth: 250,
          minWidth: 120,
          textSize: 14,
          borderWidth: 1,
          borderRadius: 6,
          arrowSize: 10,
          arrowSpacing: 6,
        );
      case ShadTooltipSize.lg:
        return ShadTooltipSizeTokens(
          padding: 16,
          maxWidth: 300,
          minWidth: 150,
          textSize: 16,
          borderWidth: 1,
          borderRadius: 8,
          arrowSize: 12,
          arrowSpacing: 8,
        );
    }
  }

  ShadTooltipVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (tooltip.widget.variant) {
      case ShadTooltipVariant.default_:
        return ShadTooltipVariantTokens(
          backgroundColor: theme.backgroundColor,
          borderColor: theme.borderColor,
          textColor: theme.textColor,
        );
      case ShadTooltipVariant.destructive:
        return ShadTooltipVariantTokens(
          backgroundColor: theme.errorColor,
          borderColor: theme.errorColor,
          textColor: Colors.white,
        );
      case ShadTooltipVariant.warning:
        return ShadTooltipVariantTokens(
          backgroundColor: theme.warningColor,
          borderColor: theme.warningColor,
          textColor: Colors.white,
        );
      case ShadTooltipVariant.success:
        return ShadTooltipVariantTokens(
          backgroundColor: theme.successColor,
          borderColor: theme.successColor,
          textColor: Colors.white,
        );
      case ShadTooltipVariant.info:
        return ShadTooltipVariantTokens(
          backgroundColor: theme.primaryColor,
          borderColor: theme.primaryColor,
          textColor: Colors.white,
        );
    }
  }
}

class _TooltipLayoutDelegate extends SingleChildLayoutDelegate {
  final ShadTooltipPosition position;

  _TooltipLayoutDelegate(this.position);

  @override
  BoxConstraints getConstraints(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    switch (position) {
      case ShadTooltipPosition.top:
        return Offset(
          (size.width - childSize.width) / 2,
          -childSize.height - 8,
        );
      case ShadTooltipPosition.bottom:
        return Offset((size.width - childSize.width) / 2, size.height + 8);
      case ShadTooltipPosition.left:
        return Offset(
          -childSize.width - 8,
          (size.height - childSize.height) / 2,
        );
      case ShadTooltipPosition.right:
        return Offset(size.width + 8, (size.height - childSize.height) / 2);
      case ShadTooltipPosition.topLeft:
        return Offset(0, -childSize.height - 8);
      case ShadTooltipPosition.topRight:
        return Offset(size.width - childSize.width, -childSize.height - 8);
      case ShadTooltipPosition.bottomLeft:
        return Offset(0, size.height + 8);
      case ShadTooltipPosition.bottomRight:
        return Offset(size.width - childSize.width, size.height + 8);
    }
  }

  @override
  bool shouldRelayout(_TooltipLayoutDelegate oldDelegate) {
    return oldDelegate.position != position;
  }
}

class _ArrowPainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final bool pointingUp;

  _ArrowPainter({
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    required this.pointingUp,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final path = Path();
    if (pointingUp) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.pointingUp != pointingUp;
  }
}

class ShadTooltipSizeTokens {
  final double padding;
  final double maxWidth;
  final double minWidth;
  final double textSize;
  final double borderWidth;
  final double borderRadius;
  final double arrowSize;
  final double arrowSpacing;

  const ShadTooltipSizeTokens({
    required this.padding,
    required this.maxWidth,
    required this.minWidth,
    required this.textSize,
    required this.borderWidth,
    required this.borderRadius,
    required this.arrowSize,
    required this.arrowSpacing,
  });
}

class ShadTooltipVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const ShadTooltipVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });
}
