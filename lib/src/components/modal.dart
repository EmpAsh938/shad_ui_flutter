import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadModalVariant { default_, destructive, warning, success, info }

enum ShadModalSize { sm, md, lg, xl, full }

enum ShadModalPosition {
  center,
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class ShadModal extends StatefulWidget {
  final ShadModalVariant variant;
  final ShadModalSize size;
  final ShadModalPosition position;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool dismissible;
  final bool showBackdrop;
  final Color? backdropColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? maxWidth;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onClose;

  const ShadModal({
    super.key,
    this.variant = ShadModalVariant.default_,
    this.size = ShadModalSize.md,
    this.position = ShadModalPosition.center,
    this.title,
    this.content,
    this.actions,
    this.dismissible = true,
    this.showBackdrop = true,
    this.backdropColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.backgroundColor,
    this.borderColor,
    this.maxWidth,
    this.maxHeight,
    this.padding,
    this.borderRadius,
    this.onClose,
  });

  @override
  State<ShadModal> createState() => _ShadModalState();
}

class _ShadModalState extends State<ShadModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

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

    _slideAnimation =
        Tween<Offset>(begin: _getSlideBeginOffset(), end: Offset.zero).animate(
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset _getSlideBeginOffset() {
    switch (widget.position) {
      case ShadModalPosition.center:
        return Offset.zero;
      case ShadModalPosition.top:
        return const Offset(0, -1);
      case ShadModalPosition.bottom:
        return const Offset(0, 1);
      case ShadModalPosition.left:
        return const Offset(-1, 0);
      case ShadModalPosition.right:
        return const Offset(1, 0);
      case ShadModalPosition.topLeft:
        return const Offset(-1, -1);
      case ShadModalPosition.topRight:
        return const Offset(1, -1);
      case ShadModalPosition.bottomLeft:
        return const Offset(-1, 1);
      case ShadModalPosition.bottomRight:
        return const Offset(1, 1);
    }
  }

  void _closeModal() {
    _animationController.reverse().then((_) {
      widget.onClose?.call();
    });
  }

  ShadModalSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadModalSize.sm:
        return ShadModalSizeTokens(
          width: 400,
          height: 300,
          padding: const EdgeInsets.all(ShadSpacing.md),
          borderRadius: ShadRadius.md,
        );
      case ShadModalSize.lg:
        return ShadModalSizeTokens(
          width: 800,
          height: 600,
          padding: const EdgeInsets.all(ShadSpacing.xl),
          borderRadius: ShadRadius.lg,
        );
      case ShadModalSize.xl:
        return ShadModalSizeTokens(
          width: 1000,
          height: 800,
          padding: const EdgeInsets.all(ShadSpacing.xxl),
          borderRadius: ShadRadius.xl,
        );
      case ShadModalSize.full:
        return ShadModalSizeTokens(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(ShadSpacing.xl),
          borderRadius: 0.0,
        );
      case ShadModalSize.md:
      default:
        return ShadModalSizeTokens(
          width: 600,
          height: 400,
          padding: const EdgeInsets.all(ShadSpacing.lg),
          borderRadius: ShadRadius.lg,
        );
    }
  }

  ShadModalVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadModalVariant.default_:
        return ShadModalVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: theme.textColor,
          iconColor: theme.textColor,
        );
      case ShadModalVariant.destructive:
        return ShadModalVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.errorColor,
          textColor: theme.textColor,
          iconColor: theme.errorColor,
        );
      case ShadModalVariant.warning:
        return ShadModalVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.warningColor,
          textColor: theme.textColor,
          iconColor: theme.warningColor,
        );
      case ShadModalVariant.success:
        return ShadModalVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.successColor,
          textColor: theme.textColor,
          iconColor: theme.successColor,
        );
      case ShadModalVariant.info:
        return ShadModalVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.primaryColor,
          textColor: theme.textColor,
          iconColor: theme.primaryColor,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Backdrop
              if (widget.showBackdrop)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: widget.dismissible ? _closeModal : null,
                    child: Container(
                      color: (widget.backdropColor ?? Colors.black).withValues(
                        alpha: _fadeAnimation.value * 0.5,
                      ),
                    ),
                  ),
                ),

              // Modal content
              Positioned.fill(
                child: _buildModalContent(theme, sizeTokens, variantTokens),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildModalContent(
    ShadThemeData theme,
    ShadModalSizeTokens sizeTokens,
    ShadModalVariantTokens variantTokens,
  ) {
    Widget modalContent = Container(
      width: widget.maxWidth ?? sizeTokens.width,
      height: widget.maxHeight ?? sizeTokens.height,
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? sizeTokens.width,
        maxHeight: widget.maxHeight ?? sizeTokens.height,
      ),
      decoration: BoxDecoration(
        color: variantTokens.backgroundColor,
        border: Border.all(color: variantTokens.borderColor, width: 1.0),
        borderRadius:
            widget.borderRadius ??
            BorderRadius.circular(sizeTokens.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
          if (widget.title != null)
            Container(
              padding: widget.padding ?? sizeTokens.padding,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: variantTokens.borderColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: widget.title!),
                  if (widget.dismissible)
                    GestureDetector(
                      onTap: _closeModal,
                      child: Icon(
                        Icons.close,
                        color: variantTokens.iconColor,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),

          // Content
          if (widget.content != null)
            Expanded(
              child: Padding(
                padding: widget.padding ?? sizeTokens.padding,
                child: widget.content!,
              ),
            ),

          // Actions
          if (widget.actions != null && widget.actions!.isNotEmpty)
            Container(
              padding: widget.padding ?? sizeTokens.padding,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: variantTokens.borderColor, width: 1.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.actions!
                    .map(
                      (action) => Padding(
                        padding: const EdgeInsets.only(left: ShadSpacing.sm),
                        child: action,
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );

    // Apply animations based on position
    if (widget.position == ShadModalPosition.center) {
      return Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(opacity: _fadeAnimation, child: modalContent),
        ),
      );
    } else {
      return SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: _getPositionedModal(modalContent),
        ),
      );
    }
  }

  Widget _getPositionedModal(Widget modalContent) {
    switch (widget.position) {
      case ShadModalPosition.center:
        return Center(child: modalContent);
      case ShadModalPosition.top:
        return Positioned(
          top: ShadSpacing.lg,
          left: ShadSpacing.lg,
          right: ShadSpacing.lg,
          child: modalContent,
        );
      case ShadModalPosition.bottom:
        return Positioned(
          bottom: ShadSpacing.lg,
          left: ShadSpacing.lg,
          right: ShadSpacing.lg,
          child: modalContent,
        );
      case ShadModalPosition.left:
        return Positioned(
          top: ShadSpacing.lg,
          bottom: ShadSpacing.lg,
          left: ShadSpacing.lg,
          child: modalContent,
        );
      case ShadModalPosition.right:
        return Positioned(
          top: ShadSpacing.lg,
          bottom: ShadSpacing.lg,
          right: ShadSpacing.lg,
          child: modalContent,
        );
      case ShadModalPosition.topLeft:
        return Positioned(
          top: ShadSpacing.lg,
          left: ShadSpacing.lg,
          child: modalContent,
        );
      case ShadModalPosition.topRight:
        return Positioned(
          top: ShadSpacing.lg,
          right: ShadSpacing.lg,
          child: modalContent,
        );
      case ShadModalPosition.bottomLeft:
        return Positioned(
          bottom: ShadSpacing.lg,
          left: ShadSpacing.lg,
          child: modalContent,
        );
      case ShadModalPosition.bottomRight:
        return Positioned(
          bottom: ShadSpacing.lg,
          right: ShadSpacing.lg,
          child: modalContent,
        );
    }
  }
}

class ShadModalSizeTokens {
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const ShadModalSizeTokens({
    required this.width,
    required this.height,
    required this.padding,
    required this.borderRadius,
  });
}

class ShadModalVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;

  const ShadModalVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
  });
}

// Helper class to show modals
class ShadModalHelper {
  static void showModal(
    BuildContext context, {
    ShadModalVariant variant = ShadModalVariant.default_,
    ShadModalSize size = ShadModalSize.md,
    ShadModalPosition position = ShadModalPosition.center,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    bool dismissible = true,
    bool showBackdrop = true,
    Color? backdropColor,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
    Color? backgroundColor,
    Color? borderColor,
    double? maxWidth,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => ShadModal(
        variant: variant,
        size: size,
        position: position,
        title: title,
        content: content,
        actions: actions,
        dismissible: dismissible,
        showBackdrop: showBackdrop,
        backdropColor: backdropColor,
        animationDuration: animationDuration,
        animationCurve: animationCurve,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        padding: padding,
        borderRadius: borderRadius,
        onClose: onClose,
      ),
    );
  }
}
