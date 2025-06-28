import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadMenuVariant { default_, outline, ghost }

enum ShadMenuSize { sm, md, lg }

enum ShadMenuTrigger { click, hover }

class ShadMenuItem {
  final String label;
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback? onTap;
  final bool isDisabled;
  final bool isSeparator;
  final List<ShadMenuItem>? subItems;
  final String? shortcut;
  final Color? color;

  const ShadMenuItem({
    required this.label,
    this.icon,
    this.customIcon,
    this.onTap,
    this.isDisabled = false,
    this.isSeparator = false,
    this.subItems,
    this.shortcut,
    this.color,
  });
}

class ShadMenu extends StatefulWidget {
  final Widget trigger;
  final List<ShadMenuItem> items;
  final ShadMenuVariant variant;
  final ShadMenuSize size;
  final ShadMenuTrigger triggerType;
  final bool showArrow;
  final Offset? offset;
  final Alignment alignment;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hoverColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? maxWidth;
  final double? maxHeight;
  final Duration animationDuration;
  final Curve animationCurve;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

  const ShadMenu({
    super.key,
    required this.trigger,
    required this.items,
    this.variant = ShadMenuVariant.default_,
    this.size = ShadMenuSize.md,
    this.triggerType = ShadMenuTrigger.click,
    this.showArrow = true,
    this.offset,
    this.alignment = Alignment.topLeft,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.hoverColor,
    this.padding,
    this.borderRadius,
    this.maxWidth,
    this.maxHeight,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.onOpen,
    this.onClose,
  });

  @override
  State<ShadMenu> createState() => _ShadMenuState();
}

class _ShadMenuState extends State<ShadMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;

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
        Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: widget.animationCurve,
          ),
        );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    if (_isOpen) return;

    setState(() => _isOpen = true);
    widget.onOpen?.call();

    _overlayEntry = OverlayEntry(builder: (context) => _buildOverlay());

    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _closeMenu() {
    if (!_isOpen) return;

    _animationController.reverse().then((_) {
      setState(() => _isOpen = false);
      _removeOverlay();
      widget.onClose?.call();
    });
  }

  ShadMenuSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadMenuSize.sm:
        return ShadMenuSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.sm,
            vertical: ShadSpacing.xs,
          ),
          fontSize: ShadTypography.fontSizeSm,
          iconSize: 16,
          borderRadius: ShadRadius.sm,
          itemHeight: 32,
        );
      case ShadMenuSize.lg:
        return ShadMenuSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.lg,
            vertical: ShadSpacing.md,
          ),
          fontSize: ShadTypography.fontSizeLg,
          iconSize: 24,
          borderRadius: ShadRadius.lg,
          itemHeight: 48,
        );
      case ShadMenuSize.md:
      default:
        return ShadMenuSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.md,
            vertical: ShadSpacing.sm,
          ),
          fontSize: ShadTypography.fontSizeMd,
          iconSize: 20,
          borderRadius: ShadRadius.md,
          itemHeight: 40,
        );
    }
  }

  ShadMenuVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadMenuVariant.default_:
        return ShadMenuVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadMenuVariant.outline:
        return ShadMenuVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadMenuVariant.ghost:
        return ShadMenuVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? Colors.transparent,
          textColor: widget.textColor ?? theme.textColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.triggerType == ShadMenuTrigger.click ? _toggleMenu : null,
      child: MouseRegion(
        onEnter: widget.triggerType == ShadMenuTrigger.hover
            ? (_) => _openMenu()
            : null,
        onExit: widget.triggerType == ShadMenuTrigger.hover
            ? (_) => _closeMenu()
            : null,
        child: widget.trigger,
      ),
    );
  }

  Widget _buildOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: _closeMenu,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildMenuContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuContent() {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: widget.maxWidth ?? 300,
                    maxHeight: widget.maxHeight ?? 400,
                  ),
                  decoration: BoxDecoration(
                    color: variantTokens.backgroundColor,
                    border: widget.variant == ShadMenuVariant.outline
                        ? Border.all(color: variantTokens.borderColor)
                        : null,
                    borderRadius:
                        widget.borderRadius ??
                        BorderRadius.circular(sizeTokens.borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Arrow indicator
                      if (widget.showArrow)
                        Container(
                          width: 0,
                          height: 0,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.transparent,
                                width: 8,
                              ),
                              top: BorderSide(
                                color: Colors.transparent,
                                width: 8,
                              ),
                              left: BorderSide(
                                color: Colors.transparent,
                                width: 8,
                              ),
                              right: BorderSide(
                                color: Colors.transparent,
                                width: 8,
                              ),
                            ),
                          ),
                        ),

                      // Menu items
                      Flexible(
                        child: SingleChildScrollView(
                          padding: widget.padding ?? sizeTokens.padding,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.items.map((item) {
                              if (item.isSeparator) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: ShadSpacing.xs,
                                  ),
                                  child: Divider(
                                    color: variantTokens.borderColor,
                                    height: 1,
                                  ),
                                );
                              }

                              return _buildMenuItem(
                                item,
                                sizeTokens,
                                variantTokens,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    ShadMenuItem item,
    ShadMenuSizeTokens sizeTokens,
    ShadMenuVariantTokens variantTokens,
  ) {
    return GestureDetector(
      onTap: item.isDisabled
          ? null
          : () {
              if (item.subItems != null) {
                // Handle submenu
                _showSubmenu(item, sizeTokens, variantTokens);
              } else {
                item.onTap?.call();
                _closeMenu();
              }
            },
      child: MouseRegion(
        cursor: item.isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: Container(
          width: double.infinity,
          height: sizeTokens.itemHeight,
          padding: const EdgeInsets.symmetric(horizontal: ShadSpacing.sm),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
          ),
          child: Row(
            children: [
              // Icon
              if (item.icon != null) ...[
                Icon(
                  item.icon,
                  size: sizeTokens.iconSize,
                  color: item.isDisabled
                      ? variantTokens.textColor.withValues(alpha: 0.5)
                      : item.color ?? variantTokens.textColor,
                ),
                const SizedBox(width: ShadSpacing.sm),
              ],
              if (item.customIcon != null) ...[
                item.customIcon!,
                const SizedBox(width: ShadSpacing.sm),
              ],

              // Label
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: sizeTokens.fontSize,
                    color: item.isDisabled
                        ? variantTokens.textColor.withValues(alpha: 0.5)
                        : item.color ?? variantTokens.textColor,
                  ),
                ),
              ),

              // Shortcut
              if (item.shortcut != null) ...[
                const SizedBox(width: ShadSpacing.sm),
                Text(
                  item.shortcut!,
                  style: TextStyle(
                    fontSize: sizeTokens.fontSize * 0.8,
                    color: variantTokens.textColor.withValues(alpha: 0.7),
                  ),
                ),
              ],

              // Submenu arrow
              if (item.subItems != null) ...[
                const SizedBox(width: ShadSpacing.sm),
                Icon(
                  Icons.chevron_right,
                  size: sizeTokens.iconSize * 0.8,
                  color: variantTokens.textColor.withValues(alpha: 0.7),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showSubmenu(
    ShadMenuItem parentItem,
    ShadMenuSizeTokens sizeTokens,
    ShadMenuVariantTokens variantTokens,
  ) {
    // Implementation for submenu would go here
    // For now, just show a snackbar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Submenu: ${parentItem.label}')));
  }
}

class ShadMenuSizeTokens {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double iconSize;
  final double borderRadius;
  final double itemHeight;

  const ShadMenuSizeTokens({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.borderRadius,
    required this.itemHeight,
  });
}

class ShadMenuVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color hoverColor;

  const ShadMenuVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.hoverColor,
  });
}
