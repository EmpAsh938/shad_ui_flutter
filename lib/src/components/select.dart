import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadSelectVariant { default_, outline, filled, ghost }

enum ShadSelectSize { sm, md, lg }

enum ShadSelectState { normal, success, error, warning }

class ShadSelectOption<T> {
  final T value;
  final String label;
  final String? description;
  final Widget? icon;
  final bool disabled;
  final Map<String, dynamic>? metadata;

  const ShadSelectOption({
    required this.value,
    required this.label,
    this.description,
    this.icon,
    this.disabled = false,
    this.metadata,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShadSelectOption &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class ShadSelect<T> extends StatefulWidget {
  final List<ShadSelectOption<T>> options;
  final T? value;
  final List<T>? selectedValues; // For multi-select
  final String? label;
  final String? hint;
  final String? placeholder;
  final bool multiple;
  final bool searchable;
  final bool clearable;
  final bool disabled;
  final bool loading;
  final ShadSelectVariant variant;
  final ShadSelectSize size;
  final ShadSelectState state;
  final String? errorText;
  final String? successText;
  final String? warningText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<List<T>>? onMultiChanged;
  final String Function(T)? valueToString;
  final Widget Function(ShadSelectOption<T>)? optionBuilder;
  final Widget Function(List<ShadSelectOption<T>>)? selectedOptionsBuilder;
  final bool Function(ShadSelectOption<T>, String)? filterOption;
  final int? maxSelectedItems;
  final bool showSelectedCount;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadSelect({
    super.key,
    required this.options,
    this.value,
    this.selectedValues,
    this.label,
    this.hint,
    this.placeholder,
    this.multiple = false,
    this.searchable = false,
    this.clearable = true,
    this.disabled = false,
    this.loading = false,
    this.variant = ShadSelectVariant.default_,
    this.size = ShadSelectSize.md,
    this.state = ShadSelectState.normal,
    this.errorText,
    this.successText,
    this.warningText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onMultiChanged,
    this.valueToString,
    this.optionBuilder,
    this.selectedOptionsBuilder,
    this.filterOption,
    this.maxSelectedItems,
    this.showSelectedCount = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  }) : assert(!multiple || selectedValues != null || onMultiChanged != null);

  @override
  State<ShadSelect<T>> createState() => _ShadSelectState<T>();
}

class _ShadSelectState<T> extends State<ShadSelect<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  OverlayEntry? _overlayEntry;
  late FocusNode _focusNode;
  late TextEditingController _searchController;
  bool _isOpen = false;
  bool _isFocused = false;
  String _searchQuery = '';
  List<ShadSelectOption<T>> _filteredOptions = [];
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );

    _focusNode = FocusNode();
    _searchController = TextEditingController();
    _filteredOptions = widget.options;

    _focusNode.addListener(_onFocusChange);
    _searchController.addListener(_onSearchChanged);

    // Add scroll listener after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addScrollListener();
    });
  }

  void _addScrollListener() {
    final scrollable = Scrollable.of(context);
    if (scrollable != null) {
      _scrollPosition = scrollable.position;
      _scrollPosition!.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (_isOpen) {
      _closeDropdown();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    _searchController.dispose();
    _scrollPosition?.removeListener(_onScroll);
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filteredOptions = _getFilteredOptions();
    });
  }

  List<ShadSelectOption<T>> _getFilteredOptions() {
    if (_searchQuery.isEmpty) return widget.options;

    return widget.options.where((option) {
      if (widget.filterOption != null) {
        return widget.filterOption!(option, _searchQuery);
      }
      return option.label.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (option.description?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ??
              false);
    }).toList();
  }

  void _toggleDropdown() {
    if (widget.disabled || widget.loading) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    if (_isOpen) return;

    setState(() {
      _isOpen = true;
    });

    _animationController.forward();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    if (!_isOpen) return;

    setState(() {
      _isOpen = false;
    });

    _animationController.reverse();
    _removeOverlay();
    _focusNode.unfocus();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _selectOption(ShadSelectOption<T> option) {
    if (option.disabled) return;

    if (widget.multiple) {
      _handleMultiSelect(option);
    } else {
      _handleSingleSelect(option);
    }
  }

  void _handleSingleSelect(ShadSelectOption<T> option) {
    widget.onChanged?.call(option.value);
    _closeDropdown();
    _searchController.clear();
  }

  void _handleMultiSelect(ShadSelectOption<T> option) {
    final currentSelected = List<T>.from(widget.selectedValues ?? []);

    if (currentSelected.contains(option.value)) {
      currentSelected.remove(option.value);
    } else {
      if (widget.maxSelectedItems != null &&
          currentSelected.length >= widget.maxSelectedItems!) {
        return; // Max items reached
      }
      currentSelected.add(option.value);
    }

    widget.onMultiChanged?.call(currentSelected);
  }

  bool _isOptionSelected(ShadSelectOption<T> option) {
    if (widget.multiple) {
      return widget.selectedValues?.contains(option.value) ?? false;
    }
    return widget.value == option.value;
  }

  ShadSelectOption<T>? _getSelectedOption() {
    if (widget.multiple || widget.value == null) return null;
    return widget.options.firstWhere(
      (option) => option.value == widget.value,
      orElse: () => ShadSelectOption<T>(value: widget.value!, label: 'Unknown'),
    );
  }

  String _getDisplayText() {
    if (widget.multiple) {
      if (widget.selectedValues?.isEmpty ?? true) {
        return widget.placeholder ?? 'Select options...';
      }

      if (widget.showSelectedCount) {
        return '${widget.selectedValues!.length} selected';
      }

      if (widget.selectedOptionsBuilder != null) {
        final selectedOptions = widget.options
            .where((option) => widget.selectedValues!.contains(option.value))
            .toList();
        return ''; // Custom builder will handle display
      }

      return widget.selectedValues!.length == 1
          ? widget.options
                .firstWhere(
                  (option) => option.value == widget.selectedValues!.first,
                  orElse: () => ShadSelectOption<T>(
                    value: widget.selectedValues!.first,
                    label: 'Unknown',
                  ),
                )
                .label
          : '${widget.selectedValues!.length} items selected';
    } else {
      final selectedOption = _getSelectedOption();
      return selectedOption?.label ??
          widget.placeholder ??
          'Select an option...';
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ShadSelectSize.sm:
        return ShadRadius.sm;
      case ShadSelectSize.lg:
        return ShadRadius.lg;
      case ShadSelectSize.md:
      default:
        return ShadRadius.md;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ShadSelectSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.sm,
          vertical: ShadSpacing.xs,
        );
      case ShadSelectSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.lg,
          vertical: ShadSpacing.md,
        );
      case ShadSelectSize.md:
      default:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.md,
          vertical: ShadSpacing.sm,
        );
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadSelectSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadSelectSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadSelectSize.md:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  Color _getStateColor(ShadThemeData theme) {
    switch (widget.state) {
      case ShadSelectState.success:
        return theme.successColor;
      case ShadSelectState.error:
        return theme.errorColor;
      case ShadSelectState.warning:
        return theme.warningColor;
      case ShadSelectState.normal:
      default:
        return Colors.transparent;
    }
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 100 : 800,
      );
    }

    switch (widget.variant) {
      case ShadSelectVariant.default_:
        return theme.brightness == Brightness.light
            ? Colors.white
            : ShadBaseColors.getColor(theme.baseColor, 800);
      case ShadSelectVariant.outline:
        return Colors.transparent;
      case ShadSelectVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadSelectVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getBorderColor(ShadThemeData theme) {
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 200 : 700,
      );
    }

    final stateColor = _getStateColor(theme);
    if (stateColor != Colors.transparent) {
      return stateColor;
    }

    if (_isFocused || _isOpen) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 600 : 400,
      );
    }

    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 300 : 600,
    );
  }

  Color _getTextColor(ShadThemeData theme) {
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }

    return theme.textColor;
  }

  Color _getLabelColor(ShadThemeData theme) {
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }

    final stateColor = _getStateColor(theme);
    if (stateColor != Colors.transparent) {
      return stateColor;
    }

    if (_isFocused || _isOpen) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 600 : 400,
      );
    }

    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 600 : 400,
    );
  }

  InputBorder _getBorder(ShadThemeData theme) {
    final borderColor = _getBorderColor(theme);
    final radius = _getBorderRadius();

    switch (widget.variant) {
      case ShadSelectVariant.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        );
      case ShadSelectVariant.filled:
      case ShadSelectVariant.ghost:
      case ShadSelectVariant.default_:
      default:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        );
    }
  }

  double _getBorderWidth() {
    if (_isFocused || _isOpen) return 2.0;

    switch (widget.variant) {
      case ShadSelectVariant.default_:
      case ShadSelectVariant.outline:
        return 1.0;
      case ShadSelectVariant.filled:
      case ShadSelectVariant.ghost:
        return 0.0;
      default:
        return 1.0;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final theme = ShadTheme.of(context);

    // Get the widget's position and size before creating the overlay
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            // Full screen overlay to handle taps and scrolls
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeDropdown,
                onPanUpdate: (_) => _closeDropdown(),
                child: Container(color: Colors.transparent),
              ),
            ),
            // Dropdown content
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: size.width,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(_getBorderRadius()),
                    border: Border.all(
                      color: _getBorderColor(theme),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.searchable) _buildSearchField(theme),
                      Flexible(child: _buildOptionsList(theme)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(ShadThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_getBorderRadius()),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        style: TextStyle(fontSize: _getFontSize(), color: theme.textColor),
      ),
    );
  }

  Widget _buildOptionsList(ShadThemeData theme) {
    if (_filteredOptions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'No options found',
          style: TextStyle(fontSize: _getFontSize(), color: theme.mutedColor),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _filteredOptions.length,
      itemBuilder: (context, index) {
        final option = _filteredOptions[index];
        final isSelected = _isOptionSelected(option);

        return _buildOptionItem(theme, option, isSelected);
      },
    );
  }

  Widget _buildOptionItem(
    ShadThemeData theme,
    ShadSelectOption<T> option,
    bool isSelected,
  ) {
    if (widget.optionBuilder != null) {
      return widget.optionBuilder!(option);
    }

    return ListTile(
      leading: option.icon,
      title: Text(
        option.label,
        style: TextStyle(
          fontSize: _getFontSize(),
          color: option.disabled ? theme.mutedColor : theme.textColor,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: option.description != null
          ? Text(
              option.description!,
              style: TextStyle(
                fontSize: _getFontSize() * 0.8,
                color: theme.mutedColor,
              ),
            )
          : null,
      trailing: isSelected
          ? Icon(Icons.check, color: theme.primaryColor, size: 20)
          : null,
      enabled: !option.disabled,
      onTap: () => _selectOption(option),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final backgroundColor = _getBackgroundColor(theme);
    final textColor = _getTextColor(theme);
    final labelColor = _getLabelColor(theme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: _getFontSize(),
                fontWeight: FontWeight.w600,
                color: labelColor,
              ),
            ),
          ),
        GestureDetector(
          onTap: _toggleDropdown,
          child: Focus(
            focusNode: _focusNode,
            child: Container(
              width: widget.multiple && widget.selectedOptionsBuilder != null
                  ? null
                  : double.infinity,
              padding: _getPadding(),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(_getBorderRadius()),
                border: Border.all(
                  color: _getBorderColor(theme),
                  width: _getBorderWidth(),
                ),
              ),
              child: Row(
                children: [
                  if (widget.prefixIcon != null) ...[
                    widget.prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  if (widget.multiple && widget.selectedOptionsBuilder != null)
                    widget.selectedOptionsBuilder!(
                      widget.options
                          .where(
                            (option) =>
                                widget.selectedValues!.contains(option.value),
                          )
                          .toList(),
                    )
                  else
                    Expanded(
                      child: Text(
                        _getDisplayText(),
                        style: TextStyle(
                          fontSize: _getFontSize(),
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (widget.loading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else if (widget.clearable &&
                      ((widget.multiple &&
                              (widget.selectedValues?.isNotEmpty ?? false)) ||
                          (!widget.multiple && widget.value != null)))
                    GestureDetector(
                      onTap: () {
                        if (widget.multiple) {
                          widget.onMultiChanged?.call([]);
                        } else {
                          widget.onChanged?.call(null);
                        }
                      },
                      child: Icon(
                        Icons.clear,
                        size: 16,
                        color: theme.mutedColor,
                      ),
                    )
                  else if (widget.suffixIcon != null)
                    widget.suffixIcon!
                  else
                    AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0,
                      duration: widget.animationDuration,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: theme.mutedColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                fontSize: _getFontSize() * 0.8,
                color: theme.errorColor,
              ),
            ),
          ),
        if (widget.successText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.successText!,
              style: TextStyle(
                fontSize: _getFontSize() * 0.8,
                color: theme.successColor,
              ),
            ),
          ),
        if (widget.warningText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.warningText!,
              style: TextStyle(
                fontSize: _getFontSize() * 0.8,
                color: theme.warningColor,
              ),
            ),
          ),
      ],
    );
  }
}
