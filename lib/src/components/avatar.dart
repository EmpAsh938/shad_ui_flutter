import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadAvatarVariant { default_, outline, filled, ghost }

enum ShadAvatarSize { sm, md, lg, xl }

enum ShadAvatarShape { circle, square, rounded }

class ShadAvatar extends StatefulWidget {
  final String? imageUrl;
  final String? name;
  final Widget? child;
  final ShadAvatarVariant variant;
  final ShadAvatarSize size;
  final ShadAvatarShape shape;
  final bool disabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.child,
    this.variant = ShadAvatarVariant.default_,
    this.size = ShadAvatarSize.md,
    this.shape = ShadAvatarShape.circle,
    this.disabled = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  }) : assert(
         imageUrl != null || name != null || child != null,
         'Either imageUrl, name, or child must be provided',
       );

  @override
  State<ShadAvatar> createState() => _ShadAvatarState();
}

class _ShadAvatarState extends State<ShadAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _imageError = false;

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

  double _getSize() {
    switch (widget.size) {
      case ShadAvatarSize.sm:
        return 32.0;
      case ShadAvatarSize.lg:
        return 64.0;
      case ShadAvatarSize.xl:
        return 96.0;
      case ShadAvatarSize.md:
        return 48.0;
    }
  }

  double _getBorderRadius() {
    switch (widget.shape) {
      case ShadAvatarShape.circle:
        return _getSize() / 2;
      case ShadAvatarShape.square:
        return ShadRadius.xs;
      case ShadAvatarShape.rounded:
        return ShadRadius.md;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadAvatarSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadAvatarSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadAvatarSize.xl:
        return ShadTypography.fontSizeXl;
      case ShadAvatarSize.md:
        return ShadTypography.fontSizeMd;
    }
  }

  double _getBorderWidth() {
    if (widget.borderWidth != null) return widget.borderWidth!;
    switch (widget.variant) {
      case ShadAvatarVariant.outline:
        return 2.0;
      case ShadAvatarVariant.default_:
      case ShadAvatarVariant.filled:
      case ShadAvatarVariant.ghost:
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
      case ShadAvatarVariant.default_:
        return theme.primaryColor;
      case ShadAvatarVariant.outline:
        return Colors.transparent;
      case ShadAvatarVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 100 : 800,
        );
      case ShadAvatarVariant.ghost:
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
      case ShadAvatarVariant.default_:
        return Colors.white;
      case ShadAvatarVariant.outline:
      case ShadAvatarVariant.filled:
      case ShadAvatarVariant.ghost:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 900 : 50,
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
      case ShadAvatarVariant.outline:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
      case ShadAvatarVariant.default_:
      case ShadAvatarVariant.filled:
      case ShadAvatarVariant.ghost:
        return Colors.transparent;
    }
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  Widget _buildContent() {
    if (widget.child != null) {
      return widget.child!;
    }

    if (widget.imageUrl != null && !_imageError) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        child: Image.network(
          widget.imageUrl!,
          width: _getSize(),
          height: _getSize(),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            _imageError = true;
            return _buildFallback();
          },
        ),
      );
    }

    return _buildFallback();
  }

  Widget _buildFallback() {
    if (widget.name != null) {
      return Center(
        child: Text(
          _getInitials(widget.name!),
          style: TextStyle(
            color: _getTextColor(ShadTheme.of(context)),
            fontSize: _getFontSize(),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Icon(
      Icons.person,
      size: _getFontSize(),
      color: _getTextColor(ShadTheme.of(context)),
    );
  }

  void _handleTap() {
    if (widget.disabled || widget.onTap == null) return;
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: _handleTap,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: _getSize(),
              height: _getSize(),
              decoration: BoxDecoration(
                color: _getBackgroundColor(theme),
                border: Border.all(
                  color: _getBorderColor(theme),
                  width: _getBorderWidth(),
                ),
                borderRadius: BorderRadius.circular(_getBorderRadius()),
              ),
              child: _buildContent(),
            ),
          ),
        );
      },
    );
  }
}
