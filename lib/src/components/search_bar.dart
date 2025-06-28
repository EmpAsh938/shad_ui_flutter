import 'package:flutter/material.dart';
import '../tokens/tokens.dart';
import '../theme/shad_theme.dart';

/// A mobile-specific search bar component with customizable styling,
/// animations, and search functionality.
class ShadSearchBar extends StatefulWidget {
  /// Creates a search bar widget.
  const ShadSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.hintStyle,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 2.0,
    this.shape,
    this.padding = const EdgeInsets.symmetric(horizontal: ShadSpacing.md),
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onClear,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.showClearButton = true,
    this.showSearchIcon = true,
    this.searchIcon = Icons.search,
    this.clearIcon = Icons.clear,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.search,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autocorrect = true,
    this.autofillHints,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.magnifierConfiguration,
    this.undoController,
    this.cursorOpacityAnimates = true,
    this.scribbleEnabled = true,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.contextMenuBuilder,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.variant = ShadSearchBarVariant.filled,
    this.size = ShadSearchBarSize.normal,
  });

  /// Controller for the text input.
  final TextEditingController? controller;

  /// Hint text to display when the field is empty.
  final String hintText;

  /// Style for the hint text.
  final TextStyle? hintStyle;

  /// Leading widget (usually search icon).
  final Widget? leading;

  /// Trailing widget (usually clear button).
  final Widget? trailing;

  /// Background color of the search bar.
  final Color? backgroundColor;

  /// Foreground color of the search bar.
  final Color? foregroundColor;

  /// Elevation of the search bar.
  final double elevation;

  /// Shape of the search bar.
  final ShapeBorder? shape;

  /// Padding around the search bar.
  final EdgeInsetsGeometry padding;

  /// Callback when the text changes.
  final ValueChanged<String>? onChanged;

  /// Callback when the search is submitted.
  final ValueChanged<String>? onSubmitted;

  /// Callback when the search bar is tapped.
  final VoidCallback? onTap;

  /// Callback when the clear button is pressed.
  final VoidCallback? onClear;

  /// Focus node for the search bar.
  final FocusNode? focusNode;

  /// Whether the search bar should autofocus.
  final bool autofocus;

  /// Whether the search bar is enabled.
  final bool enabled;

  /// Whether the search bar is read-only.
  final bool readOnly;

  /// Whether to show the clear button.
  final bool showClearButton;

  /// Whether to show the search icon.
  final bool showSearchIcon;

  /// Icon to display for search.
  final IconData searchIcon;

  /// Icon to display for clear.
  final IconData clearIcon;

  /// Keyboard type for the text input.
  final TextInputType keyboardType;

  /// Text input action.
  final TextInputAction textInputAction;

  /// Text capitalization.
  final TextCapitalization textCapitalization;

  /// Text direction.
  final TextDirection? textDirection;

  /// Style for the text.
  final TextStyle? style;

  /// Strut style for the text.
  final StrutStyle? strutStyle;

  /// Text alignment.
  final TextAlign textAlign;

  /// Vertical text alignment.
  final TextAlignVertical? textAlignVertical;

  /// Whether to enable autocorrect.
  final bool autocorrect;

  /// Autofill hints.
  final Iterable<String>? autofillHints;

  /// Clip behavior.
  final Clip clipBehavior;

  /// Restoration ID.
  final String? restorationId;

  /// Whether to enable IME personalized learning.
  final bool enableIMEPersonalizedLearning;

  /// Width of the cursor.
  final double cursorWidth;

  /// Height of the cursor.
  final double? cursorHeight;

  /// Radius of the cursor.
  final Radius? cursorRadius;

  /// Color of the cursor.
  final Color? cursorColor;

  /// Keyboard appearance.
  final Brightness? keyboardAppearance;

  /// Scroll padding.
  final EdgeInsets scrollPadding;

  /// Whether to enable interactive selection.
  final bool? enableInteractiveSelection;

  /// Selection controls.
  final TextSelectionControls? selectionControls;

  /// Magnifier configuration.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Undo controller.
  final UndoHistoryController? undoController;

  /// Whether cursor opacity animates.
  final bool cursorOpacityAnimates;

  /// Whether scribble is enabled.
  final bool scribbleEnabled;

  /// Whether the widget can request focus.
  final bool canRequestFocus;

  /// Spell check configuration.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Context menu builder.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Duration of the animation.
  final Duration animationDuration;

  /// Curve of the animation.
  final Curve animationCurve;

  /// Variant of the search bar.
  final ShadSearchBarVariant variant;

  /// Size of the search bar.
  final ShadSearchBarSize size;

  @override
  State<ShadSearchBar> createState() => _ShadSearchBarState();
}

class _ShadSearchBarState extends State<ShadSearchBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _focusAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );

    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();

    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });

    if (_hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _onClear() {
    _controller.clear();
    widget.onClear?.call();
  }

  _SearchBarColors _getColors(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadSearchBarVariant.filled:
        return _SearchBarColors(
          backgroundColor:
              widget.backgroundColor ??
              ShadBaseColors.getColor(
                theme.baseColor,
                theme.brightness == Brightness.light ? 50 : 900,
              ),
          foregroundColor: widget.foregroundColor ?? theme.textColor,
        );
      case ShadSearchBarVariant.outlined:
        return _SearchBarColors(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? theme.textColor,
        );
      case ShadSearchBarVariant.elevated:
        return _SearchBarColors(
          backgroundColor: widget.backgroundColor ?? theme.cardColor,
          foregroundColor: widget.foregroundColor ?? theme.textColor,
        );
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ShadSearchBarSize.small:
        return ShadRadius.sm;
      case ShadSearchBarSize.large:
        return ShadRadius.lg;
      case ShadSearchBarSize.normal:
      default:
        return ShadRadius.md;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadSearchBarSize.small:
        return ShadTypography.fontSizeSm;
      case ShadSearchBarSize.large:
        return ShadTypography.fontSizeLg;
      case ShadSearchBarSize.normal:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = _getColors(theme);

    return AnimatedBuilder(
      animation: _focusAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: colors.backgroundColor,
            borderRadius: BorderRadius.circular(_getBorderRadius()),
            border: widget.variant == ShadSearchBarVariant.outlined
                ? Border.all(
                    color: _hasFocus ? theme.primaryColor : theme.borderColor,
                    width: _hasFocus ? 2.0 : 1.0,
                  )
                : null,
            boxShadow: widget.variant == ShadSearchBarVariant.elevated
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: widget.elevation,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            onTap: widget.onTap,
            autofocus: widget.autofocus,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            textDirection: widget.textDirection,
            style:
                widget.style ??
                TextStyle(
                  color: colors.foregroundColor,
                  fontSize: _getFontSize(),
                ),
            strutStyle: widget.strutStyle,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            autocorrect: widget.autocorrect,
            autofillHints: widget.autofillHints,
            clipBehavior: widget.clipBehavior,
            restorationId: widget.restorationId,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
            cursorWidth: widget.cursorWidth,
            cursorHeight: widget.cursorHeight,
            cursorRadius: widget.cursorRadius,
            cursorColor: widget.cursorColor ?? theme.primaryColor,
            keyboardAppearance: widget.keyboardAppearance,
            scrollPadding: widget.scrollPadding,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            selectionControls: widget.selectionControls,
            magnifierConfiguration: widget.magnifierConfiguration,
            undoController: widget.undoController,
            cursorOpacityAnimates: widget.cursorOpacityAnimates,
            stylusHandwritingEnabled: widget.scribbleEnabled,
            canRequestFocus: widget.canRequestFocus,
            spellCheckConfiguration: widget.spellCheckConfiguration,
            contextMenuBuilder: widget.contextMenuBuilder,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  TextStyle(
                    color: colors.foregroundColor.withValues(alpha: 0.6),
                    fontSize: _getFontSize(),
                  ),
              border: InputBorder.none,
              contentPadding: widget.padding,
              prefixIcon:
                  widget.leading ??
                  (widget.showSearchIcon
                      ? Icon(
                          widget.searchIcon,
                          color: colors.foregroundColor.withValues(alpha: 0.6),
                        )
                      : null),
              suffixIcon:
                  widget.trailing ??
                  (widget.showClearButton && _controller.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            widget.clearIcon,
                            color: colors.foregroundColor.withValues(
                              alpha: 0.6,
                            ),
                          ),
                          onPressed: _onClear,
                          padding: EdgeInsets.zero,
                        )
                      : null),
            ),
          ),
        );
      },
    );
  }
}

/// Colors for the search bar.
class _SearchBarColors {
  const _SearchBarColors({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
}

/// Size options for the search bar.
enum ShadSearchBarSize {
  /// Small size (40px height).
  small,

  /// Normal size (48px height).
  normal,

  /// Large size (56px height).
  large,
}

/// Variant options for the search bar.
enum ShadSearchBarVariant {
  /// Filled variant with background color.
  filled,

  /// Outlined variant with border.
  outlined,

  /// Elevated variant with shadow.
  elevated,
}

/// A search bar with suggestions.
class ShadSearchBarWithSuggestions extends StatefulWidget {
  /// Creates a search bar with suggestions.
  const ShadSearchBarWithSuggestions({
    super.key,
    required this.onSearch,
    this.suggestions = const [],
    this.hintText = 'Search...',
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 2.0,
    this.variant = ShadSearchBarVariant.filled,
    this.size = ShadSearchBarSize.normal,
    this.onSuggestionSelected,
    this.maxSuggestions = 5,
    this.suggestionBuilder,
  });

  /// Callback when search is performed.
  final ValueChanged<String> onSearch;

  /// List of suggestions to display.
  final List<String> suggestions;

  /// Hint text for the search bar.
  final String hintText;

  /// Background color of the search bar.
  final Color? backgroundColor;

  /// Foreground color of the search bar.
  final Color? foregroundColor;

  /// Elevation of the search bar.
  final double elevation;

  /// Variant of the search bar.
  final ShadSearchBarVariant variant;

  /// Size of the search bar.
  final ShadSearchBarSize size;

  /// Callback when a suggestion is selected.
  final ValueChanged<String>? onSuggestionSelected;

  /// Maximum number of suggestions to show.
  final int maxSuggestions;

  /// Builder for custom suggestion widgets.
  final Widget Function(BuildContext, String)? suggestionBuilder;

  @override
  State<ShadSearchBarWithSuggestions> createState() =>
      _ShadSearchBarWithSuggestionsState();
}

class _ShadSearchBarWithSuggestionsState
    extends State<ShadSearchBarWithSuggestions> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final query = _controller.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _filteredSuggestions = widget.suggestions
            .take(widget.maxSuggestions)
            .toList();
      });
    } else {
      setState(() {
        _filteredSuggestions = widget.suggestions
            .where((suggestion) => suggestion.toLowerCase().contains(query))
            .take(widget.maxSuggestions)
            .toList();
      });
    }
  }

  void _onFocusChanged() {
    setState(() {
      _showSuggestions = _focusNode.hasFocus;
    });
  }

  void _onSuggestionSelected(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: suggestion.length),
    );
    widget.onSuggestionSelected?.call(suggestion);
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadSearchBar(
          controller: _controller,
          focusNode: _focusNode,
          hintText: widget.hintText,
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.foregroundColor,
          elevation: widget.elevation,
          variant: widget.variant,
          size: widget.size,
          onSubmitted: widget.onSearch,
        ),
        if (_showSuggestions && _filteredSuggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: ShadSpacing.xs),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(ShadRadius.md),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: _filteredSuggestions.map((suggestion) {
                return widget.suggestionBuilder?.call(context, suggestion) ??
                    ListTile(
                      title: Text(suggestion),
                      onTap: () => _onSuggestionSelected(suggestion),
                    );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
