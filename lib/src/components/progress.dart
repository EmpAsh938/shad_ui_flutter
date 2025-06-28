import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';

enum ShadProgressVariant { default_, destructive, warning, success, info }

enum ShadProgressSize { sm, md, lg }

enum ShadProgressType { linear, circular }

class ShadProgress extends StatefulWidget {
  final double value;
  final double? maxValue;
  final ShadProgressVariant variant;
  final ShadProgressSize size;
  final ShadProgressType type;
  final String? label;
  final bool showValue;
  final bool animated;
  final ShadThemeData? theme;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadProgress({
    super.key,
    required this.value,
    this.maxValue,
    this.variant = ShadProgressVariant.default_,
    this.size = ShadProgressSize.md,
    this.type = ShadProgressType.linear,
    this.label,
    this.showValue = false,
    this.animated = true,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadProgress> createState() => _ShadProgressState();
}

class _ShadProgressState extends State<ShadProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _progressAnimation =
        Tween<double>(
          begin: 0.0,
          end: widget.value / (widget.maxValue ?? 100.0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ),
        );

    if (widget.animated) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(ShadProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value ||
        oldWidget.maxValue != widget.maxValue) {
      _progressAnimation =
          Tween<double>(
            begin: _progressAnimation.value,
            end: widget.value / (widget.maxValue ?? 100.0),
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

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label!,
                style: TextStyle(
                  fontSize: sizeTokens.labelSize,
                  fontWeight: FontWeight.w500,
                  color: variantTokens.labelColor,
                ),
              ),
              if (widget.showValue)
                Text(
                  '${widget.value.toInt()}/${(widget.maxValue ?? 100).toInt()}',
                  style: TextStyle(
                    fontSize: sizeTokens.valueSize,
                    color: variantTokens.valueColor,
                  ),
                ),
            ],
          ),
          SizedBox(height: sizeTokens.labelSpacing),
        ],
        if (widget.type == ShadProgressType.linear)
          _buildLinearProgress(sizeTokens, variantTokens)
        else
          _buildCircularProgress(sizeTokens, variantTokens),
      ],
    );
  }

  Widget _buildLinearProgress(
    ShadProgressSizeTokens sizeTokens,
    ShadProgressVariantTokens variantTokens,
  ) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          height: sizeTokens.height,
          decoration: BoxDecoration(
            color: variantTokens.trackColor,
            borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _progressAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: variantTokens.progressColor,
                borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCircularProgress(
    ShadProgressSizeTokens sizeTokens,
    ShadProgressVariantTokens variantTokens,
  ) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SizedBox(
          width: sizeTokens.circularSize,
          height: sizeTokens.circularSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: sizeTokens.circularSize,
                height: sizeTokens.circularSize,
                child: CircularProgressIndicator(
                  value: _progressAnimation.value,
                  strokeWidth: sizeTokens.strokeWidth,
                  backgroundColor: variantTokens.trackColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    variantTokens.progressColor,
                  ),
                ),
              ),
              if (widget.showValue)
                Text(
                  '${(_progressAnimation.value * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: sizeTokens.circularTextSize,
                    fontWeight: FontWeight.w600,
                    color: variantTokens.valueColor,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  ShadProgressSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadProgressSize.sm:
        return ShadProgressSizeTokens(
          height: 4,
          circularSize: 40,
          strokeWidth: 3,
          borderRadius: 2,
          labelSize: 12,
          valueSize: 12,
          circularTextSize: 10,
          labelSpacing: 4,
        );
      case ShadProgressSize.md:
        return ShadProgressSizeTokens(
          height: 6,
          circularSize: 60,
          strokeWidth: 4,
          borderRadius: 3,
          labelSize: 14,
          valueSize: 14,
          circularTextSize: 12,
          labelSpacing: 6,
        );
      case ShadProgressSize.lg:
        return ShadProgressSizeTokens(
          height: 8,
          circularSize: 80,
          strokeWidth: 6,
          borderRadius: 4,
          labelSize: 16,
          valueSize: 16,
          circularTextSize: 14,
          labelSpacing: 8,
        );
    }
  }

  ShadProgressVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadProgressVariant.default_:
        return ShadProgressVariantTokens(
          trackColor: theme.mutedColor.withValues(alpha: 0.2),
          progressColor: theme.primaryColor,
          labelColor: theme.textColor,
          valueColor: theme.mutedColor,
        );
      case ShadProgressVariant.destructive:
        return ShadProgressVariantTokens(
          trackColor: theme.errorColor.withValues(alpha: 0.2),
          progressColor: theme.errorColor,
          labelColor: theme.textColor,
          valueColor: theme.errorColor,
        );
      case ShadProgressVariant.warning:
        return ShadProgressVariantTokens(
          trackColor: theme.warningColor.withValues(alpha: 0.2),
          progressColor: theme.warningColor,
          labelColor: theme.textColor,
          valueColor: theme.warningColor,
        );
      case ShadProgressVariant.success:
        return ShadProgressVariantTokens(
          trackColor: theme.successColor.withValues(alpha: 0.2),
          progressColor: theme.successColor,
          labelColor: theme.textColor,
          valueColor: theme.successColor,
        );
      case ShadProgressVariant.info:
        return ShadProgressVariantTokens(
          trackColor: theme.primaryColor.withValues(alpha: 0.2),
          progressColor: theme.primaryColor,
          labelColor: theme.textColor,
          valueColor: theme.primaryColor,
        );
    }
  }
}

class ShadProgressSizeTokens {
  final double height;
  final double circularSize;
  final double strokeWidth;
  final double borderRadius;
  final double labelSize;
  final double valueSize;
  final double circularTextSize;
  final double labelSpacing;

  const ShadProgressSizeTokens({
    required this.height,
    required this.circularSize,
    required this.strokeWidth,
    required this.borderRadius,
    required this.labelSize,
    required this.valueSize,
    required this.circularTextSize,
    required this.labelSpacing,
  });
}

class ShadProgressVariantTokens {
  final Color trackColor;
  final Color progressColor;
  final Color labelColor;
  final Color valueColor;

  const ShadProgressVariantTokens({
    required this.trackColor,
    required this.progressColor,
    required this.labelColor,
    required this.valueColor,
  });
}
