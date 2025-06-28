import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadAlertVariant { default_, destructive, warning, success, info }

enum ShadAlertSize { sm, md, lg }

class ShadAlert extends StatefulWidget {
  final String? title;
  final String? description;
  final Widget? icon;
  final Widget? action;
  final ShadAlertVariant variant;
  final ShadAlertSize size;
  final bool dismissible;
  final VoidCallback? onDismiss;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadAlert({
    super.key,
    this.title,
    this.description,
    this.icon,
    this.action,
    this.variant = ShadAlertVariant.default_,
    this.size = ShadAlertSize.md,
    this.dismissible = false,
    this.onDismiss,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  }) : assert(
         title != null || description != null,
         'Either title or description must be provided',
       );

  @override
  State<ShadAlert> createState() => _ShadAlertState();
}

class _ShadAlertState extends State<ShadAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
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
    switch (widget.size) {
      case ShadAlertSize.sm:
        return ShadRadius.sm;
      case ShadAlertSize.lg:
        return ShadRadius.lg;
      case ShadAlertSize.md:
      default:
        return ShadRadius.md;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ShadAlertSize.sm:
        return const EdgeInsets.all(ShadSpacing.sm);
      case ShadAlertSize.lg:
        return const EdgeInsets.all(ShadSpacing.lg);
      case ShadAlertSize.md:
      default:
        return const EdgeInsets.all(ShadSpacing.md);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadAlertSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadAlertSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadAlertSize.md:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ShadAlertSize.sm:
        return 16.0;
      case ShadAlertSize.lg:
        return 24.0;
      case ShadAlertSize.md:
      default:
        return 20.0;
    }
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadAlertVariant.default_:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadAlertVariant.destructive:
        return theme.errorColor.withValues(alpha: 0.1);
      case ShadAlertVariant.warning:
        return theme.warningColor.withValues(alpha: 0.1);
      case ShadAlertVariant.success:
        return theme.successColor.withValues(alpha: 0.1);
      case ShadAlertVariant.info:
        return theme.primaryColor.withValues(alpha: 0.1);
    }
  }

  Color _getBorderColor(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadAlertVariant.default_:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
      case ShadAlertVariant.destructive:
        return theme.errorColor.withValues(alpha: 0.3);
      case ShadAlertVariant.warning:
        return theme.warningColor.withValues(alpha: 0.3);
      case ShadAlertVariant.success:
        return theme.successColor.withValues(alpha: 0.3);
      case ShadAlertVariant.info:
        return theme.primaryColor.withValues(alpha: 0.3);
    }
  }

  Color _getTextColor(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadAlertVariant.default_:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 900 : 50,
        );
      case ShadAlertVariant.destructive:
        return theme.errorColor;
      case ShadAlertVariant.warning:
        return theme.warningColor;
      case ShadAlertVariant.success:
        return theme.successColor;
      case ShadAlertVariant.info:
        return theme.primaryColor;
    }
  }

  Widget _getDefaultIcon() {
    switch (widget.variant) {
      case ShadAlertVariant.default_:
        return Icon(Icons.info, size: _getIconSize());
      case ShadAlertVariant.destructive:
        return Icon(Icons.error, size: _getIconSize());
      case ShadAlertVariant.warning:
        return Icon(Icons.warning, size: _getIconSize());
      case ShadAlertVariant.success:
        return Icon(Icons.check_circle, size: _getIconSize());
      case ShadAlertVariant.info:
        return Icon(Icons.info, size: _getIconSize());
    }
  }

  void _handleDismiss() {
    if (!widget.dismissible || widget.onDismiss == null) return;
    _animationController.forward().then((_) {
      setState(() {
        _isDismissed = true;
      });
      widget.onDismiss!();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed) return const SizedBox.shrink();

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
              border: Border.all(color: _getBorderColor(theme), width: 1.0),
              borderRadius: BorderRadius.circular(_getBorderRadius()),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.icon != null ||
                    widget.variant != ShadAlertVariant.default_) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: _getTextColor(theme),
                      size: _getIconSize(),
                    ),
                    child: widget.icon ?? _getDefaultIcon(),
                  ),
                  const SizedBox(width: ShadSpacing.sm),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.title != null) ...[
                        Text(
                          widget.title!,
                          style: TextStyle(
                            color: _getTextColor(theme),
                            fontSize: _getFontSize(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (widget.description != null) ...[
                          const SizedBox(height: ShadSpacing.xs),
                        ],
                      ],
                      if (widget.description != null) ...[
                        Text(
                          widget.description!,
                          style: TextStyle(
                            color: _getTextColor(theme).withValues(alpha: 0.8),
                            fontSize: _getFontSize() - 1,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.action != null) ...[
                  const SizedBox(width: ShadSpacing.sm),
                  widget.action!,
                ],
                if (widget.dismissible) ...[
                  const SizedBox(width: ShadSpacing.sm),
                  IconButton(
                    onPressed: _handleDismiss,
                    icon: Icon(
                      Icons.close,
                      size: _getIconSize(),
                      color: _getTextColor(theme).withValues(alpha: 0.6),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                      minWidth: _getIconSize() + 8,
                      minHeight: _getIconSize() + 8,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
