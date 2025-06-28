import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadTabsVariant { default_, outline, filled, ghost }

enum ShadTabsSize { sm, md, lg }

enum ShadTabsOrientation { horizontal, vertical }

class ShadTabs extends StatefulWidget {
  final ShadTabsVariant variant;
  final ShadTabsSize size;
  final ShadTabsOrientation orientation;
  final List<ShadTab> tabs;
  final int initialIndex;
  final Function(int)? onTabChanged;
  final bool animated;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? indicatorColor;

  const ShadTabs({
    super.key,
    this.variant = ShadTabsVariant.default_,
    this.size = ShadTabsSize.md,
    this.orientation = ShadTabsOrientation.horizontal,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.activeColor,
    this.inactiveColor,
    this.indicatorColor,
  });

  @override
  State<ShadTabs> createState() => _ShadTabsState();
}

class _ShadTabsState extends State<ShadTabs>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;
  late AnimationController _animationController;
  late Animation<double> _indicatorAnimation;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _indicatorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      widget.onTabChanged?.call(index);

      if (widget.animated) {
        _animationController.reset();
        _animationController.forward();
      }
    }
  }

  ShadTabsSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadTabsSize.sm:
        return ShadTabsSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.sm,
            vertical: ShadSpacing.xs,
          ),
          fontSize: ShadTypography.fontSizeSm,
          iconSize: 16.0,
          indicatorHeight: 2.0,
          borderRadius: ShadRadius.sm,
        );
      case ShadTabsSize.lg:
        return ShadTabsSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.lg,
            vertical: ShadSpacing.md,
          ),
          fontSize: ShadTypography.fontSizeLg,
          iconSize: 20.0,
          indicatorHeight: 3.0,
          borderRadius: ShadRadius.lg,
        );
      case ShadTabsSize.md:
      default:
        return ShadTabsSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.md,
            vertical: ShadSpacing.sm,
          ),
          fontSize: ShadTypography.fontSizeMd,
          iconSize: 18.0,
          indicatorHeight: 2.5,
          borderRadius: ShadRadius.md,
        );
    }
  }

  ShadTabsVariantTokens _getVariantTokens(ShadThemeData theme, bool isActive) {
    switch (widget.variant) {
      case ShadTabsVariant.default_:
        return ShadTabsVariantTokens(
          backgroundColor: Colors.transparent,
          textColor: isActive
              ? (widget.activeColor ?? theme.textColor)
              : (widget.inactiveColor ?? theme.mutedColor),
          borderColor: Colors.transparent,
          indicatorColor: widget.indicatorColor ?? theme.primaryColor,
        );
      case ShadTabsVariant.outline:
        return ShadTabsVariantTokens(
          backgroundColor: Colors.transparent,
          textColor: isActive
              ? (widget.activeColor ?? theme.textColor)
              : (widget.inactiveColor ?? theme.mutedColor),
          borderColor: isActive
              ? (widget.activeColor ?? theme.borderColor)
              : theme.borderColor,
          indicatorColor: widget.indicatorColor ?? theme.primaryColor,
        );
      case ShadTabsVariant.filled:
        return ShadTabsVariantTokens(
          backgroundColor: isActive
              ? (widget.activeColor ?? theme.primaryColor).withValues(
                  alpha: 0.1,
                )
              : Colors.transparent,
          textColor: isActive
              ? (widget.activeColor ?? theme.primaryColor)
              : (widget.inactiveColor ?? theme.mutedColor),
          borderColor: Colors.transparent,
          indicatorColor: widget.indicatorColor ?? theme.primaryColor,
        );
      case ShadTabsVariant.ghost:
        return ShadTabsVariantTokens(
          backgroundColor: isActive
              ? (widget.activeColor ?? theme.primaryColor).withValues(
                  alpha: 0.1,
                )
              : Colors.transparent,
          textColor: isActive
              ? (widget.activeColor ?? theme.primaryColor)
              : (widget.inactiveColor ?? theme.mutedColor),
          borderColor: Colors.transparent,
          indicatorColor: widget.indicatorColor ?? theme.primaryColor,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();

    return widget.orientation == ShadTabsOrientation.horizontal
        ? _buildHorizontalTabs(theme, sizeTokens)
        : _buildVerticalTabs(theme, sizeTokens);
  }

  Widget _buildHorizontalTabs(
    ShadThemeData theme,
    ShadTabsSizeTokens sizeTokens,
  ) {
    return Column(
      children: [
        // Tab headers
        Container(
          decoration: BoxDecoration(
            border: widget.variant == ShadTabsVariant.outline
                ? Border(
                    bottom: BorderSide(color: theme.borderColor, width: 1.0),
                  )
                : null,
          ),
          child: Row(
            children: widget.tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final tab = entry.value;
              final isActive = index == _selectedIndex;
              final variantTokens = _getVariantTokens(theme, isActive);

              return Expanded(
                child: _buildTabHeader(
                  tab: tab,
                  index: index,
                  isActive: isActive,
                  variantTokens: variantTokens,
                  sizeTokens: sizeTokens,
                  theme: theme,
                ),
              );
            }).toList(),
          ),
        ),
        // Tab content
        Expanded(
          child: AnimatedSwitcher(
            duration: widget.animationDuration,
            child: widget.tabs[_selectedIndex].content,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalTabs(
    ShadThemeData theme,
    ShadTabsSizeTokens sizeTokens,
  ) {
    return Row(
      children: [
        // Tab headers
        Container(
          width: 200,
          decoration: BoxDecoration(
            border: widget.variant == ShadTabsVariant.outline
                ? Border(
                    right: BorderSide(color: theme.borderColor, width: 1.0),
                  )
                : null,
          ),
          child: Column(
            children: widget.tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final tab = entry.value;
              final isActive = index == _selectedIndex;
              final variantTokens = _getVariantTokens(theme, isActive);

              return _buildTabHeader(
                tab: tab,
                index: index,
                isActive: isActive,
                variantTokens: variantTokens,
                sizeTokens: sizeTokens,
                theme: theme,
              );
            }).toList(),
          ),
        ),
        // Tab content
        Expanded(
          child: AnimatedSwitcher(
            duration: widget.animationDuration,
            child: widget.tabs[_selectedIndex].content,
          ),
        ),
      ],
    );
  }

  Widget _buildTabHeader({
    required ShadTab tab,
    required int index,
    required bool isActive,
    required ShadTabsVariantTokens variantTokens,
    required ShadTabsSizeTokens sizeTokens,
    required ShadThemeData theme,
  }) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: sizeTokens.padding,
        decoration: BoxDecoration(
          color: variantTokens.backgroundColor,
          border: variantTokens.borderColor != Colors.transparent
              ? Border.all(color: variantTokens.borderColor, width: 1.0)
              : null,
          borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tab.icon != null) ...[
              Icon(
                tab.icon,
                size: sizeTokens.iconSize,
                color: variantTokens.textColor,
              ),
              const SizedBox(width: ShadSpacing.xs),
            ],
            Text(
              tab.label,
              style: TextStyle(
                fontSize: sizeTokens.fontSize,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: variantTokens.textColor,
              ),
            ),
            if (tab.badge != null) ...[
              const SizedBox(width: ShadSpacing.xs),
              tab.badge!,
            ],
          ],
        ),
      ),
    );
  }
}

class ShadTab {
  final String label;
  final Widget content;
  final IconData? icon;
  final Widget? badge;

  const ShadTab({
    required this.label,
    required this.content,
    this.icon,
    this.badge,
  });
}

class ShadTabsSizeTokens {
  final EdgeInsets padding;
  final double fontSize;
  final double iconSize;
  final double indicatorHeight;
  final double borderRadius;

  const ShadTabsSizeTokens({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.indicatorHeight,
    required this.borderRadius,
  });
}

class ShadTabsVariantTokens {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color indicatorColor;

  const ShadTabsVariantTokens({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.indicatorColor,
  });
}
