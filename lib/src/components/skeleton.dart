import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadSkeletonVariant { default_, rounded, circular }

enum ShadSkeletonSize { sm, md, lg }

enum ShadSkeletonType { text, title, avatar, button, card, list }

class ShadSkeleton extends StatefulWidget {
  final ShadSkeletonVariant variant;
  final ShadSkeletonSize size;
  final ShadSkeletonType type;
  final double? width;
  final double? height;
  final bool animated;
  final Color? color;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadSkeleton({
    super.key,
    this.variant = ShadSkeletonVariant.default_,
    this.size = ShadSkeletonSize.md,
    this.type = ShadSkeletonType.text,
    this.width,
    this.height,
    this.animated = true,
    this.color,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadSkeleton> createState() => _ShadSkeletonState();
}

class _ShadSkeletonState extends State<ShadSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    if (widget.animated) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ShadSkeletonSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadSkeletonSize.sm:
        return ShadSkeletonSizeTokens(
          height: 12.0,
          borderRadius: 4.0,
          spacing: 4.0,
        );
      case ShadSkeletonSize.lg:
        return ShadSkeletonSizeTokens(
          height: 20.0,
          borderRadius: 8.0,
          spacing: 8.0,
        );
      case ShadSkeletonSize.md:
      default:
        return ShadSkeletonSizeTokens(
          height: 16.0,
          borderRadius: 6.0,
          spacing: 6.0,
        );
    }
  }

  ShadSkeletonVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadSkeletonVariant.default_:
        return ShadSkeletonVariantTokens(
          color: widget.color ?? theme.mutedColor.withValues(alpha: 0.2),
          borderRadius: _getSizeTokens().borderRadius,
        );
      case ShadSkeletonVariant.rounded:
        return ShadSkeletonVariantTokens(
          color: widget.color ?? theme.mutedColor.withValues(alpha: 0.2),
          borderRadius: _getSizeTokens().borderRadius * 2,
        );
      case ShadSkeletonVariant.circular:
        return ShadSkeletonVariantTokens(
          color: widget.color ?? theme.mutedColor.withValues(alpha: 0.2),
          borderRadius: _getSizeTokens().height / 2,
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
        return _buildSkeletonByType(theme, sizeTokens, variantTokens);
      },
    );
  }

  Widget _buildSkeletonByType(
    ShadThemeData theme,
    ShadSkeletonSizeTokens sizeTokens,
    ShadSkeletonVariantTokens variantTokens,
  ) {
    switch (widget.type) {
      case ShadSkeletonType.text:
        return _buildTextSkeleton(theme, sizeTokens, variantTokens);
      case ShadSkeletonType.title:
        return _buildTitleSkeleton(theme, sizeTokens, variantTokens);
      case ShadSkeletonType.avatar:
        return _buildAvatarSkeleton(theme, sizeTokens, variantTokens);
      case ShadSkeletonType.button:
        return _buildButtonSkeleton(theme, sizeTokens, variantTokens);
      case ShadSkeletonType.card:
        return _buildCardSkeleton(theme, sizeTokens, variantTokens);
      case ShadSkeletonType.list:
        return _buildListSkeleton(theme, sizeTokens, variantTokens);
    }
  }

  Widget _buildTextSkeleton(
    ShadThemeData theme,
    ShadSkeletonSizeTokens sizeTokens,
    ShadSkeletonVariantTokens variantTokens,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSkeletonItem(
          width: widget.width ?? double.infinity,
          height: sizeTokens.height,
          borderRadius: variantTokens.borderRadius,
          color: variantTokens.color,
        ),
        SizedBox(height: sizeTokens.spacing),
        _buildSkeletonItem(
          width: (widget.width ?? double.infinity) * 0.8,
          height: sizeTokens.height,
          borderRadius: variantTokens.borderRadius,
          color: variantTokens.color,
        ),
        SizedBox(height: sizeTokens.spacing),
        _buildSkeletonItem(
          width: (widget.width ?? double.infinity) * 0.6,
          height: sizeTokens.height,
          borderRadius: variantTokens.borderRadius,
          color: variantTokens.color,
        ),
      ],
    );
  }

  Widget _buildTitleSkeleton(
    ShadThemeData theme,
    ShadSkeletonSizeTokens sizeTokens,
    ShadSkeletonVariantTokens variantTokens,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSkeletonItem(
          width: widget.width ?? double.infinity,
          height: sizeTokens.height * 1.5,
          borderRadius: variantTokens.borderRadius,
          color: variantTokens.color,
        ),
        SizedBox(height: sizeTokens.spacing),
        _buildSkeletonItem(
          width: (widget.width ?? double.infinity) * 0.7,
          height: sizeTokens.height,
          borderRadius: variantTokens.borderRadius,
          color: variantTokens.color,
        ),
      ],
    );
  }

  Widget _buildAvatarSkeleton(
    ShadThemeData theme,
    ShadSkeletonSizeTokens sizeTokens,
    ShadSkeletonVariantTokens variantTokens,
  ) {
    final avatarSize = widget.height ?? sizeTokens.height * 3;
    return _buildSkeletonItem(
      width: avatarSize,
      height: avatarSize,
      borderRadius: variantTokens.borderRadius,
      color: variantTokens.color,
    );
  }

  Widget _buildButtonSkeleton(
    ShadThemeData theme,
    ShadSkeletonSizeTokens sizeTokens,
    ShadSkeletonVariantTokens variantTokens,
  ) {
    return _buildSkeletonItem(
      width: widget.width ?? 120,
      height: widget.height ?? sizeTokens.height * 2.5,
      borderRadius: variantTokens.borderRadius,
      color: variantTokens.color,
    );
  }

  Widget _buildCardSkeleton(
    ShadThemeData theme,
    ShadSkeletonSizeTokens sizeTokens,
    ShadSkeletonVariantTokens variantTokens,
  ) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 200,
      padding: const EdgeInsets.all(ShadSpacing.md),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(variantTokens.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonItem(
            width: double.infinity,
            height: sizeTokens.height * 1.5,
            borderRadius: variantTokens.borderRadius,
            color: variantTokens.color,
          ),
          SizedBox(height: sizeTokens.spacing),
          _buildSkeletonItem(
            width: double.infinity,
            height: sizeTokens.height,
            borderRadius: variantTokens.borderRadius,
            color: variantTokens.color,
          ),
          SizedBox(height: sizeTokens.spacing),
          _buildSkeletonItem(
            width: double.infinity * 0.8,
            height: sizeTokens.height,
            borderRadius: variantTokens.borderRadius,
            color: variantTokens.color,
          ),
          const Spacer(),
          Row(
            children: [
              _buildSkeletonItem(
                width: 80,
                height: sizeTokens.height * 1.5,
                borderRadius: variantTokens.borderRadius,
                color: variantTokens.color,
              ),
              const Spacer(),
              _buildSkeletonItem(
                width: 60,
                height: sizeTokens.height * 1.5,
                borderRadius: variantTokens.borderRadius,
                color: variantTokens.color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListSkeleton(
    ShadThemeData theme,
    ShadSkeletonSizeTokens sizeTokens,
    ShadSkeletonVariantTokens variantTokens,
  ) {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: sizeTokens.spacing),
          child: Row(
            children: [
              _buildSkeletonItem(
                width: sizeTokens.height * 2,
                height: sizeTokens.height * 2,
                borderRadius: variantTokens.borderRadius,
                color: variantTokens.color,
              ),
              SizedBox(width: sizeTokens.spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSkeletonItem(
                      width: double.infinity,
                      height: sizeTokens.height,
                      borderRadius: variantTokens.borderRadius,
                      color: variantTokens.color,
                    ),
                    SizedBox(height: sizeTokens.spacing * 0.5),
                    _buildSkeletonItem(
                      width: double.infinity * 0.7,
                      height: sizeTokens.height * 0.8,
                      borderRadius: variantTokens.borderRadius,
                      color: variantTokens.color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonItem({
    required double width,
    required double height,
    required double borderRadius,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: widget.animated
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _SkeletonPainter(
                      color: color,
                      animationValue: _animation.value,
                    ),
                    size: Size(width, height),
                  );
                },
              ),
            )
          : null,
    );
  }
}

class _SkeletonPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _SkeletonPainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [color, color.withValues(alpha: 0.5), color],
        stops: [animationValue - 0.3, animationValue, animationValue + 0.3],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ShadSkeletonSizeTokens {
  final double height;
  final double borderRadius;
  final double spacing;

  const ShadSkeletonSizeTokens({
    required this.height,
    required this.borderRadius,
    required this.spacing,
  });
}

class ShadSkeletonVariantTokens {
  final Color color;
  final double borderRadius;

  const ShadSkeletonVariantTokens({
    required this.color,
    required this.borderRadius,
  });
}
