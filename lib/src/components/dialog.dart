import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';

enum ShadDialogVariant { default_, destructive, warning, success, info }

enum ShadDialogSize { sm, md, lg, xl }

class ShadDialog extends StatefulWidget {
  final String title;
  final String? description;
  final Widget? content;
  final List<Widget>? actions;
  final ShadDialogVariant variant;
  final ShadDialogSize size;
  final bool dismissible;
  final VoidCallback? onDismiss;
  final Widget? icon;
  final ShadThemeData? theme;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadDialog({
    super.key,
    required this.title,
    this.description,
    this.content,
    this.actions,
    this.variant = ShadDialogVariant.default_,
    this.size = ShadDialogSize.md,
    this.dismissible = true,
    this.onDismiss,
    this.icon,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadDialog> createState() => _ShadDialogState();
}

class _ShadDialogState extends State<ShadDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

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

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
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

  void _handleDismiss() {
    if (!widget.dismissible) return;

    _animationController.reverse().then((_) {
      widget.onDismiss?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.black.withValues(alpha: 0.2),
            child: Center(
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: sizeTokens.maxWidth,
                      minWidth: sizeTokens.minWidth,
                    ),
                    margin: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: variantTokens.backgroundColor,
                      borderRadius: BorderRadius.circular(
                        sizeTokens.borderRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Container(
                          padding: EdgeInsets.all(sizeTokens.headerPadding),
                          decoration: BoxDecoration(
                            color: variantTokens.headerBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(sizeTokens.borderRadius),
                              topRight: Radius.circular(
                                sizeTokens.borderRadius,
                              ),
                            ),
                          ),
                          child: Row(
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
                                      SizedBox(
                                        height: sizeTokens.descriptionSpacing,
                                      ),
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
                                GestureDetector(
                                  onTap: _handleDismiss,
                                  child: Icon(
                                    Icons.close,
                                    size: sizeTokens.closeIconSize,
                                    color: variantTokens.closeIconColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        // Content
                        if (widget.content != null) ...[
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(
                                sizeTokens.contentPadding,
                              ),
                              child: widget.content!,
                            ),
                          ),
                        ],
                        // Actions
                        if (widget.actions != null &&
                            widget.actions!.isNotEmpty) ...[
                          Container(
                            padding: EdgeInsets.all(sizeTokens.actionsPadding),
                            decoration: BoxDecoration(
                              color: variantTokens.actionsBackgroundColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  sizeTokens.borderRadius,
                                ),
                                bottomRight: Radius.circular(
                                  sizeTokens.borderRadius,
                                ),
                              ),
                            ),
                            child: Row(
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
                          ),
                        ],
                      ],
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

  IconData _getDefaultIcon() {
    switch (widget.variant) {
      case ShadDialogVariant.default_:
        return Icons.info_outline;
      case ShadDialogVariant.destructive:
        return Icons.error_outline;
      case ShadDialogVariant.warning:
        return Icons.warning_amber_outlined;
      case ShadDialogVariant.success:
        return Icons.check_circle_outline;
      case ShadDialogVariant.info:
        return Icons.info_outline;
    }
  }

  ShadDialogSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadDialogSize.sm:
        return ShadDialogSizeTokens(
          maxWidth: 400,
          minWidth: 300,
          headerPadding: 16,
          contentPadding: 16,
          actionsPadding: 16,
          titleSize: 16,
          descriptionSize: 14,
          iconSize: 18,
          closeIconSize: 16,
          borderRadius: 8,
          iconSpacing: 12,
          descriptionSpacing: 6,
          actionSpacing: 12,
        );
      case ShadDialogSize.md:
        return ShadDialogSizeTokens(
          maxWidth: 500,
          minWidth: 400,
          headerPadding: 20,
          contentPadding: 20,
          actionsPadding: 20,
          titleSize: 18,
          descriptionSize: 16,
          iconSize: 20,
          closeIconSize: 18,
          borderRadius: 10,
          iconSpacing: 16,
          descriptionSpacing: 8,
          actionSpacing: 16,
        );
      case ShadDialogSize.lg:
        return ShadDialogSizeTokens(
          maxWidth: 600,
          minWidth: 500,
          headerPadding: 24,
          contentPadding: 24,
          actionsPadding: 24,
          titleSize: 20,
          descriptionSize: 18,
          iconSize: 22,
          closeIconSize: 20,
          borderRadius: 12,
          iconSpacing: 20,
          descriptionSpacing: 10,
          actionSpacing: 20,
        );
      case ShadDialogSize.xl:
        return ShadDialogSizeTokens(
          maxWidth: 800,
          minWidth: 600,
          headerPadding: 28,
          contentPadding: 28,
          actionsPadding: 28,
          titleSize: 22,
          descriptionSize: 20,
          iconSize: 24,
          closeIconSize: 22,
          borderRadius: 14,
          iconSpacing: 24,
          descriptionSpacing: 12,
          actionSpacing: 24,
        );
    }
  }

  ShadDialogVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadDialogVariant.default_:
        return ShadDialogVariantTokens(
          backgroundColor: theme.backgroundColor,
          headerBackgroundColor: theme.primaryColor.withValues(alpha: 0.1),
          actionsBackgroundColor: theme.backgroundColor,
          titleColor: theme.primaryColor,
          descriptionColor: theme.primaryColor.withValues(alpha: 0.8),
          iconColor: theme.primaryColor,
          closeIconColor: theme.primaryColor.withValues(alpha: 0.6),
        );
      case ShadDialogVariant.destructive:
        return ShadDialogVariantTokens(
          backgroundColor: theme.backgroundColor,
          headerBackgroundColor: theme.errorColor.withValues(alpha: 0.1),
          actionsBackgroundColor: theme.backgroundColor,
          titleColor: theme.errorColor,
          descriptionColor: theme.errorColor.withValues(alpha: 0.8),
          iconColor: theme.errorColor,
          closeIconColor: theme.errorColor.withValues(alpha: 0.6),
        );
      case ShadDialogVariant.warning:
        return ShadDialogVariantTokens(
          backgroundColor: theme.backgroundColor,
          headerBackgroundColor: theme.warningColor.withValues(alpha: 0.1),
          actionsBackgroundColor: theme.backgroundColor,
          titleColor: theme.warningColor,
          descriptionColor: theme.warningColor.withValues(alpha: 0.8),
          iconColor: theme.warningColor,
          closeIconColor: theme.warningColor.withValues(alpha: 0.6),
        );
      case ShadDialogVariant.success:
        return ShadDialogVariantTokens(
          backgroundColor: theme.backgroundColor,
          headerBackgroundColor: theme.successColor.withValues(alpha: 0.1),
          actionsBackgroundColor: theme.backgroundColor,
          titleColor: theme.successColor,
          descriptionColor: theme.successColor.withValues(alpha: 0.8),
          iconColor: theme.successColor,
          closeIconColor: theme.successColor.withValues(alpha: 0.6),
        );
      case ShadDialogVariant.info:
        return ShadDialogVariantTokens(
          backgroundColor: theme.backgroundColor,
          headerBackgroundColor: theme.primaryColor.withOpacity(0.1),
          actionsBackgroundColor: theme.backgroundColor,
          titleColor: theme.primaryColor,
          descriptionColor: theme.primaryColor.withOpacity(0.8),
          iconColor: theme.primaryColor,
          closeIconColor: theme.primaryColor.withOpacity(0.6),
        );
    }
  }
}

class ShadDialogSizeTokens {
  final double maxWidth;
  final double minWidth;
  final double headerPadding;
  final double contentPadding;
  final double actionsPadding;
  final double titleSize;
  final double descriptionSize;
  final double iconSize;
  final double closeIconSize;
  final double borderRadius;
  final double iconSpacing;
  final double descriptionSpacing;
  final double actionSpacing;

  const ShadDialogSizeTokens({
    required this.maxWidth,
    required this.minWidth,
    required this.headerPadding,
    required this.contentPadding,
    required this.actionsPadding,
    required this.titleSize,
    required this.descriptionSize,
    required this.iconSize,
    required this.closeIconSize,
    required this.borderRadius,
    required this.iconSpacing,
    required this.descriptionSpacing,
    required this.actionSpacing,
  });
}

class ShadDialogVariantTokens {
  final Color backgroundColor;
  final Color headerBackgroundColor;
  final Color actionsBackgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color iconColor;
  final Color closeIconColor;

  const ShadDialogVariantTokens({
    required this.backgroundColor,
    required this.headerBackgroundColor,
    required this.actionsBackgroundColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.iconColor,
    required this.closeIconColor,
  });
}

// Dialog Manager for showing dialogs
class ShadDialogManager {
  static void show(
    BuildContext context, {
    required String title,
    String? description,
    Widget? content,
    List<Widget>? actions,
    ShadDialogVariant variant = ShadDialogVariant.default_,
    ShadDialogSize size = ShadDialogSize.md,
    bool dismissible = true,
    VoidCallback? onDismiss,
    Widget? icon,
    ShadThemeData? theme,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => ShadDialog(
        title: title,
        description: description,
        content: content,
        actions: actions,
        variant: variant,
        size: size,
        dismissible: dismissible,
        onDismiss: () {
          Navigator.of(context).pop();
          onDismiss?.call();
        },
        icon: icon,
        theme: theme,
      ),
    );
  }
}
