import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadAccordionVariant { default_, outline, ghost }

enum ShadAccordionSize { sm, md, lg }

enum ShadAccordionType { single, multiple }

class ShadAccordionItem {
  final String value;
  final String title;
  final Widget content;
  final IconData? icon;
  final Widget? customIcon;
  final bool isDisabled;
  final Color? titleColor;
  final Color? contentColor;

  const ShadAccordionItem({
    required this.value,
    required this.title,
    required this.content,
    this.icon,
    this.customIcon,
    this.isDisabled = false,
    this.titleColor,
    this.contentColor,
  });
}

class ShadAccordion extends StatefulWidget {
  final List<ShadAccordionItem> items;
  final ShadAccordionVariant variant;
  final ShadAccordionSize size;
  final ShadAccordionType type;
  final String? defaultValue;
  final List<String>? defaultValues;
  final ValueChanged<String>? onValueChange;
  final ValueChanged<List<String>>? onValuesChange;
  final bool collapsible;
  final bool showChevron;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final Color? contentColor;
  final Color? hoverColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadAccordion({
    super.key,
    required this.items,
    this.variant = ShadAccordionVariant.default_,
    this.size = ShadAccordionSize.md,
    this.type = ShadAccordionType.single,
    this.defaultValue,
    this.defaultValues,
    this.onValueChange,
    this.onValuesChange,
    this.collapsible = true,
    this.showChevron = true,
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.contentColor,
    this.hoverColor,
    this.padding,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadAccordion> createState() => _ShadAccordionState();
}

class _ShadAccordionState extends State<ShadAccordion>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _heightAnimations;
  late List<Animation<double>> _rotationAnimations;
  late List<bool> _isExpanded;
  late List<String> _expandedValues;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeExpandedState();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.items.length,
      (index) =>
          AnimationController(duration: widget.animationDuration, vsync: this),
    );

    _heightAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: widget.animationCurve),
      );
    }).toList();

    _rotationAnimations = _animationControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 0.5).animate(
        CurvedAnimation(parent: controller, curve: widget.animationCurve),
      );
    }).toList();
  }

  void _initializeExpandedState() {
    _isExpanded = List.filled(widget.items.length, false);
    _expandedValues = [];

    if (widget.type == ShadAccordionType.single) {
      if (widget.defaultValue != null) {
        final index = widget.items.indexWhere(
          (item) => item.value == widget.defaultValue,
        );
        if (index != -1) {
          _isExpanded[index] = true;
          _expandedValues.add(widget.defaultValue!);
          _animationControllers[index].forward();
        }
      }
    } else {
      if (widget.defaultValues != null) {
        for (final value in widget.defaultValues!) {
          final index = widget.items.indexWhere((item) => item.value == value);
          if (index != -1) {
            _isExpanded[index] = true;
            _expandedValues.add(value);
            _animationControllers[index].forward();
          }
        }
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  ShadAccordionSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadAccordionSize.sm:
        return ShadAccordionSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.sm),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.sm,
            vertical: ShadSpacing.xs,
          ),
          contentPadding: const EdgeInsets.all(ShadSpacing.sm),
          fontSize: ShadTypography.fontSizeSm,
          iconSize: 16,
          borderRadius: ShadRadius.sm,
          itemSpacing: ShadSpacing.xs,
        );
      case ShadAccordionSize.lg:
        return ShadAccordionSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.lg),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.lg,
            vertical: ShadSpacing.md,
          ),
          contentPadding: const EdgeInsets.all(ShadSpacing.lg),
          fontSize: ShadTypography.fontSizeLg,
          iconSize: 24,
          borderRadius: ShadRadius.lg,
          itemSpacing: ShadSpacing.md,
        );
      case ShadAccordionSize.md:
      default:
        return ShadAccordionSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.md),
          titlePadding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.md,
            vertical: ShadSpacing.sm,
          ),
          contentPadding: const EdgeInsets.all(ShadSpacing.md),
          fontSize: ShadTypography.fontSizeMd,
          iconSize: 20,
          borderRadius: ShadRadius.md,
          itemSpacing: ShadSpacing.sm,
        );
    }
  }

  ShadAccordionVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadAccordionVariant.default_:
        return ShadAccordionVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          titleColor: widget.titleColor ?? theme.textColor,
          contentColor: widget.contentColor ?? theme.textColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadAccordionVariant.outline:
        return ShadAccordionVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          titleColor: widget.titleColor ?? theme.textColor,
          contentColor: widget.contentColor ?? theme.textColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadAccordionVariant.ghost:
        return ShadAccordionVariantTokens(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          borderColor: widget.borderColor ?? Colors.transparent,
          titleColor: widget.titleColor ?? theme.textColor,
          contentColor: widget.contentColor ?? theme.textColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
    }
  }

  void _toggleItem(int index) {
    final item = widget.items[index];
    if (item.isDisabled) return;

    setState(() {
      if (widget.type == ShadAccordionType.single) {
        // Close all other items
        for (int i = 0; i < _isExpanded.length; i++) {
          if (i != index && _isExpanded[i]) {
            _isExpanded[i] = false;
            _expandedValues.remove(widget.items[i].value);
            _animationControllers[i].reverse();
          }
        }
      }

      // Toggle current item
      if (_isExpanded[index]) {
        if (widget.collapsible) {
          _isExpanded[index] = false;
          _expandedValues.remove(item.value);
          _animationControllers[index].reverse();
        }
      } else {
        _isExpanded[index] = true;
        _expandedValues.add(item.value);
        _animationControllers[index].forward();
      }
    });

    // Call callbacks
    if (widget.type == ShadAccordionType.single) {
      widget.onValueChange?.call(
        _expandedValues.isNotEmpty ? _expandedValues.first : '',
      );
    } else {
      widget.onValuesChange?.call(List.from(_expandedValues));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    return Container(
      padding: widget.padding ?? sizeTokens.padding,
      decoration: BoxDecoration(
        color: variantTokens.backgroundColor,
        border: widget.variant == ShadAccordionVariant.outline
            ? Border.all(color: variantTokens.borderColor)
            : null,
        borderRadius:
            widget.borderRadius ??
            BorderRadius.circular(sizeTokens.borderRadius),
      ),
      child: Column(
        children: widget.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isExpanded = _isExpanded[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index < widget.items.length - 1
                  ? sizeTokens.itemSpacing
                  : 0,
            ),
            child: _buildAccordionItem(
              item,
              index,
              isExpanded,
              sizeTokens,
              variantTokens,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAccordionItem(
    ShadAccordionItem item,
    int index,
    bool isExpanded,
    ShadAccordionSizeTokens sizeTokens,
    ShadAccordionVariantTokens variantTokens,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isExpanded ? variantTokens.hoverColor : Colors.transparent,
        border: widget.variant == ShadAccordionVariant.outline
            ? Border.all(color: variantTokens.borderColor)
            : null,
        borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
      ),
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: () => _toggleItem(index),
            child: MouseRegion(
              cursor: item.isDisabled
                  ? SystemMouseCursors.basic
                  : SystemMouseCursors.click,
              child: Container(
                width: double.infinity,
                padding: sizeTokens.titlePadding,
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
                            ? variantTokens.titleColor.withValues(alpha: 0.5)
                            : item.titleColor ?? variantTokens.titleColor,
                      ),
                      const SizedBox(width: ShadSpacing.sm),
                    ],
                    if (item.customIcon != null) ...[
                      item.customIcon!,
                      const SizedBox(width: ShadSpacing.sm),
                    ],

                    // Title
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: sizeTokens.fontSize,
                          fontWeight: FontWeight.w500,
                          color: item.isDisabled
                              ? variantTokens.titleColor.withValues(alpha: 0.5)
                              : item.titleColor ?? variantTokens.titleColor,
                        ),
                      ),
                    ),

                    // Chevron
                    if (widget.showChevron)
                      AnimatedBuilder(
                        animation: _rotationAnimations[index],
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimations[index].value * 3.14159,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: sizeTokens.iconSize,
                              color: item.isDisabled
                                  ? variantTokens.titleColor.withValues(
                                      alpha: 0.5,
                                    )
                                  : variantTokens.titleColor,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          AnimatedBuilder(
            animation: _heightAnimations[index],
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  heightFactor: _heightAnimations[index].value,
                  child: Container(
                    padding: sizeTokens.contentPadding,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: sizeTokens.fontSize,
                        color: item.contentColor ?? variantTokens.contentColor,
                      ),
                      child: item.content,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ShadAccordionSizeTokens {
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry titlePadding;
  final EdgeInsetsGeometry contentPadding;
  final double fontSize;
  final double iconSize;
  final double borderRadius;
  final double itemSpacing;

  const ShadAccordionSizeTokens({
    required this.padding,
    required this.titlePadding,
    required this.contentPadding,
    required this.fontSize,
    required this.iconSize,
    required this.borderRadius,
    required this.itemSpacing,
  });
}

class ShadAccordionVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color contentColor;
  final Color hoverColor;

  const ShadAccordionVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.contentColor,
    required this.hoverColor,
  });
}
