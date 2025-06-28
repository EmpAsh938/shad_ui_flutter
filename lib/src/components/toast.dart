import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';

enum ShadToastVariant { default_, destructive, warning, success, info }

enum ShadToastSize { sm, md, lg }

enum ShadToastPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class ShadToast extends StatefulWidget {
  final String title;
  final String? description;
  final ShadToastVariant variant;
  final ShadToastSize size;
  final Duration duration;
  final bool dismissible;
  final VoidCallback? onDismiss;
  final Widget? icon;
  final List<Widget>? actions;
  final ShadThemeData? theme;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadToast({
    super.key,
    required this.title,
    this.description,
    this.variant = ShadToastVariant.default_,
    this.size = ShadToastSize.md,
    this.duration = const Duration(seconds: 4),
    this.dismissible = true,
    this.onDismiss,
    this.icon,
    this.actions,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadToast> createState() => _ShadToastState();
}

class _ShadToastState extends State<ShadToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
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

    _animationController.forward();

    if (widget.duration != Duration.zero) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          dismiss();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void dismiss() {
    if (!_isVisible) return;

    setState(() => _isVisible = false);
    widget.onDismiss?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.icon != null) ...[
                          widget.icon!,
                          SizedBox(width: sizeTokens.iconSpacing),
                        ] else ...[
                          Icon(
                            _getDefaultIcon(),
                            size: sizeTokens.iconSize,
                            color: variantTokens.iconColor,
                          ),
                          SizedBox(width: sizeTokens.iconSpacing),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: sizeTokens.titleSize,
                                  fontWeight: FontWeight.w600,
                                  color: variantTokens.titleColor,
                                ),
                              ),
                              if (widget.description != null) ...[
                                SizedBox(height: sizeTokens.descriptionSpacing),
                                Text(
                                  widget.description!,
                                  style: TextStyle(
                                    fontSize: sizeTokens.descriptionSize,
                                    color: variantTokens.descriptionColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (widget.dismissible) ...[
                          SizedBox(width: sizeTokens.iconSpacing),
                          GestureDetector(
                            onTap: dismiss,
                            child: Icon(
                              Icons.close,
                              size: sizeTokens.closeIconSize,
                              color: variantTokens.closeIconColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (widget.actions != null &&
                        widget.actions!.isNotEmpty) ...[
                      SizedBox(height: sizeTokens.actionsSpacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: widget.actions!
                            .map(
                              (action) => Padding(
                                padding: EdgeInsets.only(
                                  left: sizeTokens.actionSpacing,
                                ),
                                child: action,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getDefaultIcon() {
    switch (widget.variant) {
      case ShadToastVariant.default_:
        return Icons.info_outline;
      case ShadToastVariant.destructive:
        return Icons.error_outline;
      case ShadToastVariant.warning:
        return Icons.warning_amber_outlined;
      case ShadToastVariant.success:
        return Icons.check_circle_outline;
      case ShadToastVariant.info:
        return Icons.info_outline;
    }
  }

  ShadToastSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadToastSize.sm:
        return ShadToastSizeTokens(
          padding: 12,
          maxWidth: 300,
          minWidth: 200,
          titleSize: 14,
          descriptionSize: 12,
          iconSize: 16,
          closeIconSize: 14,
          borderWidth: 1,
          borderRadius: 6,
          iconSpacing: 8,
          descriptionSpacing: 4,
          actionsSpacing: 12,
          actionSpacing: 8,
        );
      case ShadToastSize.md:
        return ShadToastSizeTokens(
          padding: 16,
          maxWidth: 400,
          minWidth: 250,
          titleSize: 16,
          descriptionSize: 14,
          iconSize: 18,
          closeIconSize: 16,
          borderWidth: 1,
          borderRadius: 8,
          iconSpacing: 12,
          descriptionSpacing: 6,
          actionsSpacing: 16,
          actionSpacing: 12,
        );
      case ShadToastSize.lg:
        return ShadToastSizeTokens(
          padding: 20,
          maxWidth: 500,
          minWidth: 300,
          titleSize: 18,
          descriptionSize: 16,
          iconSize: 20,
          closeIconSize: 18,
          borderWidth: 1,
          borderRadius: 10,
          iconSpacing: 16,
          descriptionSpacing: 8,
          actionsSpacing: 20,
          actionSpacing: 16,
        );
    }
  }

  ShadToastVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadToastVariant.default_:
        return ShadToastVariantTokens(
          backgroundColor: theme.backgroundColor,
          borderColor: theme.borderColor,
          titleColor: theme.textColor,
          descriptionColor: theme.mutedColor,
          iconColor: theme.primaryColor,
          closeIconColor: theme.mutedColor,
        );
      case ShadToastVariant.destructive:
        return ShadToastVariantTokens(
          backgroundColor: theme.errorColor.withOpacity(0.1),
          borderColor: theme.errorColor.withOpacity(0.2),
          titleColor: theme.errorColor,
          descriptionColor: theme.errorColor.withOpacity(0.8),
          iconColor: theme.errorColor,
          closeIconColor: theme.errorColor.withOpacity(0.6),
        );
      case ShadToastVariant.warning:
        return ShadToastVariantTokens(
          backgroundColor: theme.warningColor.withOpacity(0.1),
          borderColor: theme.warningColor.withOpacity(0.2),
          titleColor: theme.warningColor,
          descriptionColor: theme.warningColor.withOpacity(0.8),
          iconColor: theme.warningColor,
          closeIconColor: theme.warningColor.withOpacity(0.6),
        );
      case ShadToastVariant.success:
        return ShadToastVariantTokens(
          backgroundColor: theme.successColor.withOpacity(0.1),
          borderColor: theme.successColor.withOpacity(0.2),
          titleColor: theme.successColor,
          descriptionColor: theme.successColor.withOpacity(0.8),
          iconColor: theme.successColor,
          closeIconColor: theme.successColor.withOpacity(0.6),
        );
      case ShadToastVariant.info:
        return ShadToastVariantTokens(
          backgroundColor: theme.primaryColor.withOpacity(0.1),
          borderColor: theme.primaryColor.withOpacity(0.2),
          titleColor: theme.primaryColor,
          descriptionColor: theme.primaryColor.withOpacity(0.8),
          iconColor: theme.primaryColor,
          closeIconColor: theme.primaryColor.withOpacity(0.6),
        );
    }
  }
}

class ShadToastSizeTokens {
  final double padding;
  final double maxWidth;
  final double minWidth;
  final double titleSize;
  final double descriptionSize;
  final double iconSize;
  final double closeIconSize;
  final double borderWidth;
  final double borderRadius;
  final double iconSpacing;
  final double descriptionSpacing;
  final double actionsSpacing;
  final double actionSpacing;

  const ShadToastSizeTokens({
    required this.padding,
    required this.maxWidth,
    required this.minWidth,
    required this.titleSize,
    required this.descriptionSize,
    required this.iconSize,
    required this.closeIconSize,
    required this.borderWidth,
    required this.borderRadius,
    required this.iconSpacing,
    required this.descriptionSpacing,
    required this.actionsSpacing,
    required this.actionSpacing,
  });
}

class ShadToastVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color iconColor;
  final Color closeIconColor;

  const ShadToastVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.iconColor,
    required this.closeIconColor,
  });
}

// Toast Manager for showing toasts
class ShadToastManager {
  static final Map<ShadToastPosition, List<_ToastEntry>> _toasts = {};
  static final Map<ShadToastPosition, OverlayEntry> _overlays = {};

  static void show(
    BuildContext context, {
    required String title,
    String? description,
    ShadToastVariant variant = ShadToastVariant.default_,
    ShadToastSize size = ShadToastSize.md,
    Duration duration = const Duration(seconds: 4),
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? icon,
    List<Widget>? actions,
    ShadToastPosition position = ShadToastPosition.topRight,
    ShadThemeData? theme,
  }) {
    ShadToast? toastRef;

    final toast = ShadToast(
      title: title,
      description: description,
      variant: variant,
      size: size,
      duration: duration,
      dismissible: dismissible,
      onDismiss: () {
        if (toastRef != null) {
          _removeToast(position, toastRef!);
        }
        onDismiss?.call();
      },
      icon: icon,
      actions: actions,
      theme: theme,
    );

    toastRef = toast;
    _addToast(context, position, toast);
  }

  static void _addToast(
    BuildContext context,
    ShadToastPosition position,
    ShadToast toast,
  ) {
    if (!_toasts.containsKey(position)) {
      _toasts[position] = [];
      _createOverlay(context, position);
    }

    _toasts[position]!.add(_ToastEntry(toast));
    _updateOverlay(position);
  }

  static void _removeToast(ShadToastPosition position, ShadToast toast) {
    if (_toasts.containsKey(position)) {
      _toasts[position]!.removeWhere((entry) => entry.toast == toast);
      _updateOverlay(position);
    }
  }

  static void _createOverlay(BuildContext context, ShadToastPosition position) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastOverlay(position: position),
    );
    _overlays[position] = overlayEntry;
    overlay.insert(overlayEntry);
  }

  static void _updateOverlay(ShadToastPosition position) {
    _overlays[position]?.markNeedsBuild();
  }
}

class _ToastEntry {
  final ShadToast toast;
  final DateTime createdAt;

  _ToastEntry(this.toast) : createdAt = DateTime.now();
}

class _ToastOverlay extends StatelessWidget {
  final ShadToastPosition position;

  const _ToastOverlay({required this.position});

  @override
  Widget build(BuildContext context) {
    final toasts = ShadToastManager._toasts[position] ?? [];
    if (toasts.isEmpty) return const SizedBox.shrink();

    return Positioned(
      top: position.toString().contains('top') ? 20 : null,
      bottom: position.toString().contains('bottom') ? 20 : null,
      left: position.toString().contains('Left') ? 20 : null,
      right: position.toString().contains('Right') ? 20 : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _getCrossAxisAlignment(),
        children: toasts.map((entry) => entry.toast).toList(),
      ),
    );
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    switch (position) {
      case ShadToastPosition.topLeft:
      case ShadToastPosition.bottomLeft:
        return CrossAxisAlignment.start;
      case ShadToastPosition.topCenter:
      case ShadToastPosition.bottomCenter:
        return CrossAxisAlignment.center;
      case ShadToastPosition.topRight:
      case ShadToastPosition.bottomRight:
        return CrossAxisAlignment.end;
    }
  }
}
