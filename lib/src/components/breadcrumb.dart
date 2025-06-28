import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadBreadcrumbVariant { default_, subtle, outline }

enum ShadBreadcrumbSize { sm, md, lg }

enum ShadBreadcrumbSeparator { slash, chevron, arrow, dot }

class ShadBreadcrumbItem {
  final String label;
  final VoidCallback? onTap;
  final bool isActive;
  final IconData? icon;
  final Widget? customIcon;

  const ShadBreadcrumbItem({
    required this.label,
    this.onTap,
    this.isActive = false,
    this.icon,
    this.customIcon,
  });
}

class ShadBreadcrumb extends StatefulWidget {
  final List<ShadBreadcrumbItem> items;
  final ShadBreadcrumbVariant variant;
  final ShadBreadcrumbSize size;
  final ShadBreadcrumbSeparator separator;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? activeTextColor;
  final Color? separatorColor;
  final Color? hoverColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool showHomeIcon;
  final IconData homeIcon;
  final String homeLabel;
  final bool collapsible;
  final int maxVisibleItems;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadBreadcrumb({
    super.key,
    required this.items,
    this.variant = ShadBreadcrumbVariant.default_,
    this.size = ShadBreadcrumbSize.md,
    this.separator = ShadBreadcrumbSeparator.slash,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.activeTextColor,
    this.separatorColor,
    this.hoverColor,
    this.padding,
    this.borderRadius,
    this.showHomeIcon = false,
    this.homeIcon = Icons.home,
    this.homeLabel = 'Home',
    this.collapsible = false,
    this.maxVisibleItems = 5,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadBreadcrumb> createState() => _ShadBreadcrumbState();
}

class _ShadBreadcrumbState extends State<ShadBreadcrumb>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isExpanded = false;

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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  ShadBreadcrumbSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadBreadcrumbSize.sm:
        return ShadBreadcrumbSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.sm,
            vertical: ShadSpacing.xs,
          ),
          fontSize: ShadTypography.fontSizeSm,
          iconSize: 16,
          borderRadius: ShadRadius.sm,
        );
      case ShadBreadcrumbSize.lg:
        return ShadBreadcrumbSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.lg,
            vertical: ShadSpacing.md,
          ),
          fontSize: ShadTypography.fontSizeLg,
          iconSize: 24,
          borderRadius: ShadRadius.lg,
        );
      case ShadBreadcrumbSize.md:
      default:
        return ShadBreadcrumbSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.md,
            vertical: ShadSpacing.sm,
          ),
          fontSize: ShadTypography.fontSizeMd,
          iconSize: 20,
          borderRadius: ShadRadius.md,
        );
    }
  }

  ShadBreadcrumbVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadBreadcrumbVariant.default_:
        return ShadBreadcrumbVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          activeTextColor: widget.activeTextColor ?? theme.primaryColor,
          separatorColor: widget.separatorColor ?? theme.mutedColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadBreadcrumbVariant.subtle:
        return ShadBreadcrumbVariantTokens(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          borderColor: widget.borderColor ?? Colors.transparent,
          textColor: widget.textColor ?? theme.mutedColor,
          activeTextColor: widget.activeTextColor ?? theme.textColor,
          separatorColor: widget.separatorColor ?? theme.mutedColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadBreadcrumbVariant.outline:
        return ShadBreadcrumbVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          activeTextColor: widget.activeTextColor ?? theme.primaryColor,
          separatorColor: widget.separatorColor ?? theme.borderColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
    }
  }

  Widget _buildSeparator(ShadBreadcrumbVariantTokens variantTokens) {
    switch (widget.separator) {
      case ShadBreadcrumbSeparator.slash:
        return Text(
          '/',
          style: TextStyle(
            color: variantTokens.separatorColor,
            fontSize: _getSizeTokens().fontSize,
          ),
        );
      case ShadBreadcrumbSeparator.chevron:
        return Icon(
          Icons.chevron_right,
          color: variantTokens.separatorColor,
          size: _getSizeTokens().iconSize,
        );
      case ShadBreadcrumbSeparator.arrow:
        return Icon(
          Icons.arrow_forward_ios,
          color: variantTokens.separatorColor,
          size: _getSizeTokens().iconSize * 0.8,
        );
      case ShadBreadcrumbSeparator.dot:
        return Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: variantTokens.separatorColor,
            shape: BoxShape.circle,
          ),
        );
    }
  }

  List<ShadBreadcrumbItem> _getVisibleItems() {
    if (!widget.collapsible || widget.items.length <= widget.maxVisibleItems) {
      return widget.items;
    }

    if (_isExpanded) {
      return widget.items;
    }

    // Show first, last, and ellipsis
    final visibleItems = <ShadBreadcrumbItem>[];
    visibleItems.add(widget.items.first);

    // Add ellipsis item
    visibleItems.add(ShadBreadcrumbItem(label: '...', onTap: _toggleExpanded));

    visibleItems.add(widget.items.last);
    return visibleItems;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);
    final visibleItems = _getVisibleItems();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          padding: widget.padding ?? sizeTokens.padding,
          decoration: BoxDecoration(
            color: variantTokens.backgroundColor,
            border: widget.variant == ShadBreadcrumbVariant.outline
                ? Border.all(color: variantTokens.borderColor)
                : null,
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(sizeTokens.borderRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Home icon (optional)
              if (widget.showHomeIcon) ...[
                GestureDetector(
                  onTap: () {
                    // Navigate to home or first item
                    if (widget.items.isNotEmpty) {
                      widget.items.first.onTap?.call();
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.all(ShadSpacing.xs),
                      decoration: BoxDecoration(
                        color: variantTokens.hoverColor,
                        borderRadius: BorderRadius.circular(
                          sizeTokens.borderRadius,
                        ),
                      ),
                      child: Icon(
                        widget.homeIcon,
                        size: sizeTokens.iconSize * 0.8,
                        color: variantTokens.textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: ShadSpacing.sm),
                _buildSeparator(variantTokens),
                const SizedBox(width: ShadSpacing.sm),
              ],

              // Breadcrumb items
              ...visibleItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isLast = index == visibleItems.length - 1;
                final isEllipsis = item.label == '...';

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Item
                    GestureDetector(
                      onTap: isEllipsis
                          ? item.onTap
                          : (item.onTap != null ? item.onTap : null),
                      child: MouseRegion(
                        cursor: (isEllipsis || item.onTap != null)
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: ShadSpacing.sm,
                            vertical: ShadSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: item.isActive
                                ? variantTokens.activeTextColor.withValues(
                                    alpha: 0.1,
                                  )
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              sizeTokens.borderRadius,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (item.icon != null) ...[
                                Icon(
                                  item.icon,
                                  size: sizeTokens.iconSize * 0.8,
                                  color: item.isActive
                                      ? variantTokens.activeTextColor
                                      : variantTokens.textColor,
                                ),
                                const SizedBox(width: ShadSpacing.xs),
                              ],
                              if (item.customIcon != null) ...[
                                item.customIcon!,
                                const SizedBox(width: ShadSpacing.xs),
                              ],
                              Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: sizeTokens.fontSize,
                                  fontWeight: item.isActive
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: item.isActive
                                      ? variantTokens.activeTextColor
                                      : variantTokens.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Separator (except for last item)
                    if (!isLast) ...[
                      const SizedBox(width: ShadSpacing.sm),
                      _buildSeparator(variantTokens),
                      const SizedBox(width: ShadSpacing.sm),
                    ],
                  ],
                );
              }).toList(),

              // Expand/Collapse button (if collapsible and collapsed)
              if (widget.collapsible &&
                  widget.items.length > widget.maxVisibleItems &&
                  !_isExpanded) ...[
                const SizedBox(width: ShadSpacing.sm),
                GestureDetector(
                  onTap: _toggleExpanded,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.all(ShadSpacing.xs),
                      decoration: BoxDecoration(
                        color: variantTokens.hoverColor,
                        borderRadius: BorderRadius.circular(
                          sizeTokens.borderRadius,
                        ),
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        size: sizeTokens.iconSize * 0.8,
                        color: variantTokens.textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class ShadBreadcrumbSizeTokens {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double iconSize;
  final double borderRadius;

  const ShadBreadcrumbSizeTokens({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.borderRadius,
  });
}

class ShadBreadcrumbVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color activeTextColor;
  final Color separatorColor;
  final Color hoverColor;

  const ShadBreadcrumbVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.activeTextColor,
    required this.separatorColor,
    required this.hoverColor,
  });
}
