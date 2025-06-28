import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadCommandVariant { default_, outline, ghost }

enum ShadCommandSize { sm, md, lg }

class ShadCommandItem {
  final String id;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback? onSelect;
  final bool isDisabled;
  final List<String>? keywords;
  final Color? color;

  const ShadCommandItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.icon,
    this.customIcon,
    this.onSelect,
    this.isDisabled = false,
    this.keywords,
    this.color,
  });
}

class ShadCommandGroup {
  final String title;
  final List<ShadCommandItem> items;

  const ShadCommandGroup({required this.title, required this.items});
}

class ShadCommand extends StatefulWidget {
  final List<ShadCommandItem> items;
  final List<ShadCommandGroup>? groups;
  final ShadCommandVariant variant;
  final ShadCommandSize size;
  final String? placeholder;
  final bool showSearch;
  final bool showEmptyState;
  final int maxHeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? selectedColor;
  final Color? hoverColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;
  final ValueChanged<ShadCommandItem>? onItemSelected;
  final ValueChanged<String>? onSearchChanged;

  const ShadCommand({
    super.key,
    this.items = const [],
    this.groups,
    this.variant = ShadCommandVariant.default_,
    this.size = ShadCommandSize.md,
    this.placeholder,
    this.showSearch = true,
    this.showEmptyState = true,
    this.maxHeight = 400,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.selectedColor,
    this.hoverColor,
    this.padding,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.onItemSelected,
    this.onSearchChanged,
  });

  @override
  State<ShadCommand> createState() => _ShadCommandState();
}

class _ShadCommandState extends State<ShadCommand>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  late List<ShadCommandItem> _filteredItems;
  late List<ShadCommandGroup> _filteredGroups;
  int _selectedIndex = 0;
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _filteredItems = List.from(widget.items);
    _filteredGroups = widget.groups != null ? List.from(widget.groups!) : [];

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

    _animationController.forward();
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  ShadCommandSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadCommandSize.sm:
        return ShadCommandSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.sm),
          itemHeight: 36,
          fontSize: ShadTypography.fontSizeSm,
          iconSize: 16,
          borderRadius: ShadRadius.sm,
        );
      case ShadCommandSize.lg:
        return ShadCommandSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.lg),
          itemHeight: 52,
          fontSize: ShadTypography.fontSizeLg,
          iconSize: 24,
          borderRadius: ShadRadius.lg,
        );
      case ShadCommandSize.md:
      default:
        return ShadCommandSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.md),
          itemHeight: 44,
          fontSize: ShadTypography.fontSizeMd,
          iconSize: 20,
          borderRadius: ShadRadius.md,
        );
    }
  }

  ShadCommandVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadCommandVariant.default_:
        return ShadCommandVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          selectedColor: widget.selectedColor ?? theme.primaryColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadCommandVariant.outline:
        return ShadCommandVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          selectedColor: widget.selectedColor ?? theme.primaryColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadCommandVariant.ghost:
        return ShadCommandVariantTokens(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          borderColor: widget.borderColor ?? Colors.transparent,
          textColor: widget.textColor ?? theme.textColor,
          selectedColor: widget.selectedColor ?? theme.primaryColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (widget.groups != null) {
        _filteredGroups = widget.groups!
            .map((group) {
              final filteredItems = group.items.where((item) {
                if (item.isDisabled) return false;
                if (query.isEmpty) return true;

                final searchText = query.toLowerCase();
                final titleMatch = item.title.toLowerCase().contains(
                  searchText,
                );
                final subtitleMatch =
                    item.subtitle?.toLowerCase().contains(searchText) ?? false;
                final keywordMatch =
                    item.keywords?.any(
                      (keyword) => keyword.toLowerCase().contains(searchText),
                    ) ??
                    false;

                return titleMatch || subtitleMatch || keywordMatch;
              }).toList();

              return ShadCommandGroup(title: group.title, items: filteredItems);
            })
            .where((group) => group.items.isNotEmpty)
            .toList();
      } else {
        _filteredItems = widget.items.where((item) {
          if (item.isDisabled) return false;
          if (query.isEmpty) return true;

          final searchText = query.toLowerCase();
          final titleMatch = item.title.toLowerCase().contains(searchText);
          final subtitleMatch =
              item.subtitle?.toLowerCase().contains(searchText) ?? false;
          final keywordMatch =
              item.keywords?.any(
                (keyword) => keyword.toLowerCase().contains(searchText),
              ) ??
              false;

          return titleMatch || subtitleMatch || keywordMatch;
        }).toList();
      }

      _selectedIndex = 0;
    });

    widget.onSearchChanged?.call(query);
  }

  void _selectItem(ShadCommandItem item) {
    if (item.isDisabled) return;

    item.onSelect?.call();
    widget.onItemSelected?.call(item);
  }

  void _moveSelection(int direction) {
    final totalItems = _getTotalItems();
    if (totalItems == 0) return;

    setState(() {
      _selectedIndex = (_selectedIndex + direction) % totalItems;
      if (_selectedIndex < 0) _selectedIndex = totalItems - 1;
    });
  }

  int _getTotalItems() {
    if (widget.groups != null) {
      return _filteredGroups.fold(0, (sum, group) => sum + group.items.length);
    }
    return _filteredItems.length;
  }

  ShadCommandItem? _getSelectedItem() {
    if (widget.groups != null) {
      int currentIndex = 0;
      for (final group in _filteredGroups) {
        for (final item in group.items) {
          if (currentIndex == _selectedIndex) return item;
          currentIndex++;
        }
      }
    } else {
      if (_selectedIndex < _filteredItems.length) {
        return _filteredItems[_selectedIndex];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.maxHeight.toDouble(),
              ),
              padding: widget.padding ?? sizeTokens.padding,
              decoration: BoxDecoration(
                color: variantTokens.backgroundColor,
                border: widget.variant == ShadCommandVariant.outline
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
                  // Search input
                  if (widget.showSearch) ...[
                    TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: widget.placeholder ?? 'Search commands...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            sizeTokens.borderRadius,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: ShadSpacing.md,
                          vertical: ShadSpacing.sm,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: sizeTokens.fontSize,
                        color: variantTokens.textColor,
                      ),
                    ),
                    const SizedBox(height: ShadSpacing.md),
                  ],

                  // Command list
                  Flexible(child: _buildCommandList(sizeTokens, variantTokens)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCommandList(
    ShadCommandSizeTokens sizeTokens,
    ShadCommandVariantTokens variantTokens,
  ) {
    if (widget.groups != null) {
      if (_filteredGroups.isEmpty) {
        return _buildEmptyState(sizeTokens, variantTokens);
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: _filteredGroups.length,
        itemBuilder: (context, groupIndex) {
          final group = _filteredGroups[groupIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ShadSpacing.sm,
                  vertical: ShadSpacing.xs,
                ),
                child: Text(
                  group.title,
                  style: TextStyle(
                    fontSize: sizeTokens.fontSize * 0.8,
                    fontWeight: FontWeight.w600,
                    color: variantTokens.textColor.withValues(alpha: 0.7),
                  ),
                ),
              ),

              // Group items
              ...group.items.map((item) {
                final itemIndex = _getItemIndex(
                  groupIndex,
                  group.items.indexOf(item),
                );
                return _buildCommandItem(
                  item,
                  itemIndex,
                  sizeTokens,
                  variantTokens,
                );
              }).toList(),

              if (groupIndex < _filteredGroups.length - 1)
                const SizedBox(height: ShadSpacing.sm),
            ],
          );
        },
      );
    } else {
      if (_filteredItems.isEmpty) {
        return _buildEmptyState(sizeTokens, variantTokens);
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          return _buildCommandItem(
            _filteredItems[index],
            index,
            sizeTokens,
            variantTokens,
          );
        },
      );
    }
  }

  int _getItemIndex(int groupIndex, int itemIndex) {
    int totalIndex = 0;
    for (int i = 0; i < groupIndex; i++) {
      totalIndex += _filteredGroups[i].items.length;
    }
    return totalIndex + itemIndex;
  }

  Widget _buildCommandItem(
    ShadCommandItem item,
    int index,
    ShadCommandSizeTokens sizeTokens,
    ShadCommandVariantTokens variantTokens,
  ) {
    final isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => _selectItem(item),
      child: MouseRegion(
        cursor: item.isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: Container(
          height: sizeTokens.itemHeight,
          padding: const EdgeInsets.symmetric(horizontal: ShadSpacing.sm),
          decoration: BoxDecoration(
            color: isSelected
                ? variantTokens.selectedColor
                : Colors.transparent,
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
                      : isSelected
                      ? Colors.white
                      : item.color ?? variantTokens.textColor,
                ),
                const SizedBox(width: ShadSpacing.sm),
              ],
              if (item.customIcon != null) ...[
                item.customIcon!,
                const SizedBox(width: ShadSpacing.sm),
              ],

              // Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: sizeTokens.fontSize,
                        fontWeight: FontWeight.w500,
                        color: item.isDisabled
                            ? variantTokens.textColor.withValues(alpha: 0.5)
                            : isSelected
                            ? Colors.white
                            : variantTokens.textColor,
                      ),
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle!,
                        style: TextStyle(
                          fontSize: sizeTokens.fontSize * 0.8,
                          color: item.isDisabled
                              ? variantTokens.textColor.withValues(alpha: 0.3)
                              : isSelected
                              ? Colors.white.withValues(alpha: 0.8)
                              : variantTokens.textColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Keyboard shortcut hint
              if (isSelected)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ShadSpacing.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '↵',
                    style: TextStyle(
                      fontSize: sizeTokens.fontSize * 0.8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    ShadCommandSizeTokens sizeTokens,
    ShadCommandVariantTokens variantTokens,
  ) {
    if (!widget.showEmptyState) return const SizedBox.shrink();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              size: sizeTokens.iconSize * 2,
              color: variantTokens.textColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: ShadSpacing.sm),
            Text(
              'No commands found',
              style: TextStyle(
                fontSize: sizeTokens.fontSize,
                fontWeight: FontWeight.w500,
                color: variantTokens.textColor.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: ShadSpacing.xs),
            Text(
              'Try adjusting your search terms',
              style: TextStyle(
                fontSize: sizeTokens.fontSize * 0.8,
                color: variantTokens.textColor.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShadCommandSizeTokens {
  final EdgeInsetsGeometry padding;
  final double itemHeight;
  final double fontSize;
  final double iconSize;
  final double borderRadius;

  const ShadCommandSizeTokens({
    required this.padding,
    required this.itemHeight,
    required this.fontSize,
    required this.iconSize,
    required this.borderRadius,
  });
}

class ShadCommandVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color selectedColor;
  final Color hoverColor;

  const ShadCommandVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.selectedColor,
    required this.hoverColor,
  });
}
