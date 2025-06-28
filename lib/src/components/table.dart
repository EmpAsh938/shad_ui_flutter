import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadTableVariant { default_, outline, filled, ghost }

enum ShadTableSize { sm, md, lg }

enum ShadTableSortDirection { none, ascending, descending }

class ShadTable<T> extends StatefulWidget {
  final ShadTableVariant variant;
  final ShadTableSize size;
  final List<ShadTableColumn<T>> columns;
  final List<T> data;
  final bool sortable;
  final bool filterable;
  final bool selectable;
  final bool paginated;
  final int itemsPerPage;
  final Function(List<T>)? onSelectionChanged;
  final Function(int, ShadTableSortDirection)? onSort;
  final Function(String)? onFilter;
  final Color? headerColor;
  final Color? rowColor;
  final Color? selectedRowColor;
  final Color? borderColor;
  final bool striped;
  final bool hoverable;

  const ShadTable({
    super.key,
    this.variant = ShadTableVariant.default_,
    this.size = ShadTableSize.md,
    required this.columns,
    required this.data,
    this.sortable = false,
    this.filterable = false,
    this.selectable = false,
    this.paginated = false,
    this.itemsPerPage = 10,
    this.onSelectionChanged,
    this.onSort,
    this.onFilter,
    this.headerColor,
    this.rowColor,
    this.selectedRowColor,
    this.borderColor,
    this.striped = false,
    this.hoverable = true,
  });

  @override
  State<ShadTable<T>> createState() => _ShadTableState<T>();
}

class _ShadTableState<T> extends State<ShadTable<T>> {
  List<T> _filteredData = [];
  List<T> _selectedItems = [];
  Map<int, ShadTableSortDirection> _sortStates = {};
  int _currentPage = 0;
  String _filterText = '';

  @override
  void initState() {
    super.initState();
    _filteredData = List.from(widget.data);
  }

  @override
  void didUpdateWidget(ShadTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _filteredData = List.from(widget.data);
      _applyFilter();
    }
  }

  void _applyFilter() {
    if (_filterText.isEmpty) {
      _filteredData = List.from(widget.data);
    } else {
      _filteredData = widget.data.where((item) {
        return widget.columns.any((column) {
          final value = column.getData(item);
          return value.toString().toLowerCase().contains(
            _filterText.toLowerCase(),
          );
        });
      }).toList();
    }
    _currentPage = 0;
  }

  void _sortColumn(int columnIndex) {
    if (!widget.sortable) return;

    final column = widget.columns[columnIndex];
    final currentSort = _sortStates[columnIndex] ?? ShadTableSortDirection.none;

    ShadTableSortDirection newSort;
    switch (currentSort) {
      case ShadTableSortDirection.none:
        newSort = ShadTableSortDirection.ascending;
        break;
      case ShadTableSortDirection.ascending:
        newSort = ShadTableSortDirection.descending;
        break;
      case ShadTableSortDirection.descending:
        newSort = ShadTableSortDirection.none;
        break;
    }

    setState(() {
      _sortStates.clear();
      if (newSort != ShadTableSortDirection.none) {
        _sortStates[columnIndex] = newSort;

        _filteredData.sort((a, b) {
          final aValue = column.getData(a);
          final bValue = column.getData(b);

          int comparison = 0;
          if (aValue is Comparable && bValue is Comparable) {
            comparison = aValue.compareTo(bValue);
          } else {
            comparison = aValue.toString().compareTo(bValue.toString());
          }

          return newSort == ShadTableSortDirection.ascending
              ? comparison
              : -comparison;
        });
      } else {
        _filteredData = List.from(widget.data);
        _applyFilter();
      }
    });

    widget.onSort?.call(columnIndex, newSort);
  }

  void _toggleSelection(T item) {
    if (!widget.selectable) return;

    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });

    widget.onSelectionChanged?.call(_selectedItems);
  }

  void _toggleAllSelection() {
    if (!widget.selectable) return;

    setState(() {
      if (_selectedItems.length == _filteredData.length) {
        _selectedItems.clear();
      } else {
        _selectedItems = List.from(_filteredData);
      }
    });

    widget.onSelectionChanged?.call(_selectedItems);
  }

  ShadTableSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadTableSize.sm:
        return ShadTableSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.xs),
          fontSize: ShadTypography.fontSizeSm,
          headerFontSize: ShadTypography.fontSizeSm,
          borderRadius: ShadRadius.xs,
        );
      case ShadTableSize.lg:
        return ShadTableSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.md),
          fontSize: ShadTypography.fontSizeLg,
          headerFontSize: ShadTypography.fontSizeLg,
          borderRadius: ShadRadius.lg,
        );
      case ShadTableSize.md:
      default:
        return ShadTableSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.sm),
          fontSize: ShadTypography.fontSizeMd,
          headerFontSize: ShadTypography.fontSizeMd,
          borderRadius: ShadRadius.md,
        );
    }
  }

  ShadTableVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadTableVariant.default_:
        return ShadTableVariantTokens(
          backgroundColor: theme.backgroundColor,
          headerColor: widget.headerColor ?? theme.cardColor,
          rowColor: widget.rowColor ?? theme.backgroundColor,
          selectedRowColor:
              widget.selectedRowColor ??
              theme.primaryColor.withValues(alpha: 0.1),
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: theme.textColor,
          headerTextColor: theme.textColor,
        );
      case ShadTableVariant.outline:
        return ShadTableVariantTokens(
          backgroundColor: theme.backgroundColor,
          headerColor: widget.headerColor ?? theme.backgroundColor,
          rowColor: widget.rowColor ?? theme.backgroundColor,
          selectedRowColor:
              widget.selectedRowColor ??
              theme.primaryColor.withValues(alpha: 0.1),
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: theme.textColor,
          headerTextColor: theme.textColor,
        );
      case ShadTableVariant.filled:
        return ShadTableVariantTokens(
          backgroundColor: theme.cardColor,
          headerColor: widget.headerColor ?? theme.backgroundColor,
          rowColor: widget.rowColor ?? theme.cardColor,
          selectedRowColor:
              widget.selectedRowColor ??
              theme.primaryColor.withValues(alpha: 0.1),
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: theme.textColor,
          headerTextColor: theme.textColor,
        );
      case ShadTableVariant.ghost:
        return ShadTableVariantTokens(
          backgroundColor: Colors.transparent,
          headerColor: widget.headerColor ?? Colors.transparent,
          rowColor: widget.rowColor ?? Colors.transparent,
          selectedRowColor:
              widget.selectedRowColor ??
              theme.primaryColor.withValues(alpha: 0.1),
          borderColor: Colors.transparent,
          textColor: theme.textColor,
          headerTextColor: theme.textColor,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    final paginatedData = widget.paginated
        ? _filteredData
              .skip(_currentPage * widget.itemsPerPage)
              .take(widget.itemsPerPage)
              .toList()
        : _filteredData;

    return Column(
      children: [
        // Filter
        if (widget.filterable) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: ShadSpacing.md),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Filter data...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ShadRadius.md),
                ),
                contentPadding: const EdgeInsets.all(ShadSpacing.sm),
              ),
              onChanged: (value) {
                setState(() {
                  _filterText = value;
                  _applyFilter();
                });
                widget.onFilter?.call(value);
              },
            ),
          ),
        ],

        // Table
        Container(
          decoration: BoxDecoration(
            color: variantTokens.backgroundColor,
            border: variantTokens.borderColor != Colors.transparent
                ? Border.all(color: variantTokens.borderColor)
                : null,
            borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
          ),
          child: Column(
            children: [
              // Header
              Container(
                color: variantTokens.headerColor,
                child: Row(
                  children: [
                    if (widget.selectable) ...[
                      SizedBox(
                        width: 50,
                        child: Checkbox(
                          value:
                              _selectedItems.length == _filteredData.length &&
                              _filteredData.isNotEmpty,
                          tristate: true,
                          onChanged: (_) => _toggleAllSelection(),
                        ),
                      ),
                    ],
                    ...widget.columns.asMap().entries.map((entry) {
                      final index = entry.key;
                      final column = entry.value;
                      final sortDirection = _sortStates[index];

                      return Expanded(
                        flex: column.flex ?? 1,
                        child: GestureDetector(
                          onTap: widget.sortable
                              ? () => _sortColumn(index)
                              : null,
                          child: Container(
                            padding: sizeTokens.padding,
                            decoration: BoxDecoration(
                              border:
                                  variantTokens.borderColor !=
                                      Colors.transparent
                                  ? Border(
                                      bottom: BorderSide(
                                        color: variantTokens.borderColor,
                                      ),
                                      right: index < widget.columns.length - 1
                                          ? BorderSide(
                                              color: variantTokens.borderColor,
                                            )
                                          : BorderSide.none,
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    column.header,
                                    style: TextStyle(
                                      fontSize: sizeTokens.headerFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: variantTokens.headerTextColor,
                                    ),
                                  ),
                                ),
                                if (widget.sortable) ...[
                                  const SizedBox(width: ShadSpacing.xs),
                                  Icon(
                                    sortDirection ==
                                            ShadTableSortDirection.ascending
                                        ? Icons.keyboard_arrow_up
                                        : sortDirection ==
                                              ShadTableSortDirection.descending
                                        ? Icons.keyboard_arrow_down
                                        : Icons.unfold_more,
                                    size: 16,
                                    color: variantTokens.headerTextColor,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Rows
              ...paginatedData.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = _selectedItems.contains(item);
                final isStriped = widget.striped && index % 2 == 1;

                return _ShadTableRow<T>(
                  item: item,
                  columns: widget.columns,
                  isSelected: isSelected,
                  isStriped: isStriped,
                  selectable: widget.selectable,
                  hoverable: widget.hoverable,
                  sizeTokens: sizeTokens,
                  variantTokens: variantTokens,
                  onTap: () => _toggleSelection(item),
                );
              }).toList(),
            ],
          ),
        ),

        // Pagination
        if (widget.paginated && _filteredData.length > widget.itemsPerPage) ...[
          const SizedBox(height: ShadSpacing.md),
          _buildPagination(theme, variantTokens),
        ],
      ],
    );
  }

  Widget _buildPagination(
    ShadThemeData theme,
    ShadTableVariantTokens variantTokens,
  ) {
    final totalPages = (_filteredData.length / widget.itemsPerPage).ceil();
    final startItem = _currentPage * widget.itemsPerPage + 1;
    final endItem = (_currentPage + 1) * widget.itemsPerPage;
    final actualEndItem = endItem > _filteredData.length
        ? _filteredData.length
        : endItem;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing $startItem to $actualEndItem of ${_filteredData.length} results',
          style: TextStyle(
            color: variantTokens.textColor,
            fontSize: ShadTypography.fontSizeSm,
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: _currentPage > 0
                  ? () => setState(() => _currentPage--)
                  : null,
              child: const Text('Previous'),
            ),
            const SizedBox(width: ShadSpacing.sm),
            ...List.generate(totalPages, (index) {
              final pageNumber = index + 1;
              final isCurrentPage = pageNumber == _currentPage + 1;

              return Padding(
                padding: const EdgeInsets.only(right: ShadSpacing.xs),
                child: TextButton(
                  onPressed: () => setState(() => _currentPage = index),
                  style: TextButton.styleFrom(
                    backgroundColor: isCurrentPage ? theme.primaryColor : null,
                    foregroundColor: isCurrentPage ? Colors.white : null,
                  ),
                  child: Text(pageNumber.toString()),
                ),
              );
            }),
            const SizedBox(width: ShadSpacing.sm),
            TextButton(
              onPressed: _currentPage < totalPages - 1
                  ? () => setState(() => _currentPage++)
                  : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ShadTableRow<T> extends StatefulWidget {
  final T item;
  final List<ShadTableColumn<T>> columns;
  final bool isSelected;
  final bool isStriped;
  final bool selectable;
  final bool hoverable;
  final ShadTableSizeTokens sizeTokens;
  final ShadTableVariantTokens variantTokens;
  final VoidCallback onTap;

  const _ShadTableRow({
    required this.item,
    required this.columns,
    required this.isSelected,
    required this.isStriped,
    required this.selectable,
    required this.hoverable,
    required this.sizeTokens,
    required this.variantTokens,
    required this.onTap,
  });

  @override
  State<_ShadTableRow<T>> createState() => _ShadTableRowState<T>();
}

class _ShadTableRowState<T> extends State<_ShadTableRow<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = widget.variantTokens.rowColor;

    if (widget.isSelected) {
      backgroundColor = widget.variantTokens.selectedRowColor;
    } else if (widget.isStriped) {
      backgroundColor = backgroundColor.withValues(alpha: 0.5);
    }

    if (widget.hoverable && _isHovered) {
      backgroundColor = backgroundColor.withValues(alpha: 0.8);
    }

    return MouseRegion(
      onEnter: widget.hoverable
          ? (_) => setState(() => _isHovered = true)
          : null,
      onExit: widget.hoverable
          ? (_) => setState(() => _isHovered = false)
          : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          color: backgroundColor,
          child: Row(
            children: [
              if (widget.selectable) ...[
                SizedBox(
                  width: 50,
                  child: Checkbox(
                    value: widget.isSelected,
                    onChanged: (_) => widget.onTap(),
                  ),
                ),
              ],
              ...widget.columns.asMap().entries.map((entry) {
                final index = entry.key;
                final column = entry.value;
                final data = column.getData(widget.item);

                return Expanded(
                  flex: column.flex ?? 1,
                  child: Container(
                    padding: widget.sizeTokens.padding,
                    decoration: BoxDecoration(
                      border:
                          widget.variantTokens.borderColor != Colors.transparent
                          ? Border(
                              bottom: BorderSide(
                                color: widget.variantTokens.borderColor,
                              ),
                              right: index < widget.columns.length - 1
                                  ? BorderSide(
                                      color: widget.variantTokens.borderColor,
                                    )
                                  : BorderSide.none,
                            )
                          : null,
                    ),
                    child: column.builder != null
                        ? column.builder!(data, widget.item)
                        : Text(
                            data.toString(),
                            style: TextStyle(
                              fontSize: widget.sizeTokens.fontSize,
                              color: widget.variantTokens.textColor,
                            ),
                          ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class ShadTableColumn<T> {
  final String header;
  final dynamic Function(T) getData;
  final Widget Function(dynamic, T)? builder;
  final int? flex;

  const ShadTableColumn({
    required this.header,
    required this.getData,
    this.builder,
    this.flex,
  });
}

class ShadTableSizeTokens {
  final EdgeInsets padding;
  final double fontSize;
  final double headerFontSize;
  final double borderRadius;

  const ShadTableSizeTokens({
    required this.padding,
    required this.fontSize,
    required this.headerFontSize,
    required this.borderRadius,
  });
}

class ShadTableVariantTokens {
  final Color backgroundColor;
  final Color headerColor;
  final Color rowColor;
  final Color selectedRowColor;
  final Color borderColor;
  final Color textColor;
  final Color headerTextColor;

  const ShadTableVariantTokens({
    required this.backgroundColor,
    required this.headerColor,
    required this.rowColor,
    required this.selectedRowColor,
    required this.borderColor,
    required this.textColor,
    required this.headerTextColor,
  });
}
