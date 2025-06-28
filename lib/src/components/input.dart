import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadInputVariant { default_, outline, filled, ghost }

enum ShadInputSize { sm, md, lg }

enum ShadInputState { normal, success, error, warning }

class ShadInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final String? warningText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ShadInputVariant variant;
  final ShadInputSize size;
  final ShadInputState state;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool enableInteractiveSelection;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool showCounter;
  final String? counterText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final String? semanticsLabel;
  final bool fullWidth;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? hintColor;
  final double? borderWidth;
  final List<BoxShadow>? shadows;
  final bool enableHapticFeedback;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadInput({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.warningText,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = ShadInputVariant.default_,
    this.size = ShadInputSize.md,
    this.state = ShadInputState.normal,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.enableInteractiveSelection = true,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.counterText,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.inputFormatters,
    this.focusNode,
    this.semanticsLabel,
    this.fullWidth = false,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.labelColor,
    this.hintColor,
    this.borderWidth,
    this.shadows,
    this.enableHapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadInput> createState() => _ShadInputState();
}

class _ShadInputState extends State<ShadInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool _isFocused = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _focusAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _focusNode = widget.focusNode ?? FocusNode();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);

    _focusNode.addListener(_onFocusChange);
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

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_isFocused) {
      _animationController.forward();
      if (widget.enableHapticFeedback) {
        HapticFeedback.selectionClick();
      }
    } else {
      _animationController.reverse();
    }
  }

  double _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!.topLeft.x;

    switch (widget.size) {
      case ShadInputSize.sm:
        return ShadRadius.sm;
      case ShadInputSize.md:
        return ShadRadius.md;
      case ShadInputSize.lg:
        return ShadRadius.lg;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    if (widget.padding != null) return widget.padding!;

    switch (widget.size) {
      case ShadInputSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.sm,
          vertical: ShadSpacing.xs,
        );
      case ShadInputSize.md:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.md,
          vertical: ShadSpacing.sm,
        );
      case ShadInputSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.lg,
          vertical: ShadSpacing.md,
        );
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadInputSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadInputSize.md:
        return ShadTypography.fontSizeMd;
      case ShadInputSize.lg:
        return ShadTypography.fontSizeLg;
    }
  }

  double _getLabelFontSize() {
    switch (widget.size) {
      case ShadInputSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadInputSize.md:
        return ShadTypography.fontSizeMd;
      case ShadInputSize.lg:
        return ShadTypography.fontSizeLg;
    }
  }

  Color _getStateColor(ShadThemeData theme) {
    switch (widget.state) {
      case ShadInputState.success:
        return theme.successColor;
      case ShadInputState.error:
        return theme.errorColor;
      case ShadInputState.warning:
        return theme.warningColor;
      case ShadInputState.normal:
      default:
        return Colors.transparent;
    }
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    if (!widget.enabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 100 : 800,
      );
    }

    switch (widget.variant) {
      case ShadInputVariant.default_:
        return theme.brightness == Brightness.light
            ? Colors.white
            : ShadBaseColors.getColor(theme.baseColor, 800);
      case ShadInputVariant.outline:
        return Colors.transparent;
      case ShadInputVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadInputVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getBorderColor(ShadThemeData theme) {
    if (widget.borderColor != null) return widget.borderColor!;

    if (!widget.enabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 200 : 700,
      );
    }

    final stateColor = _getStateColor(theme);
    if (stateColor != Colors.transparent) {
      return stateColor;
    }

    if (_isFocused) {
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
    if (widget.textColor != null) return widget.textColor!;

    if (!widget.enabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }

    return theme.textColor;
  }

  Color _getLabelColor(ShadThemeData theme) {
    if (widget.labelColor != null) return widget.labelColor!;

    if (!widget.enabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }

    final stateColor = _getStateColor(theme);
    if (stateColor != Colors.transparent) {
      return stateColor;
    }

    if (_isFocused) {
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

  Color _getHintColor(ShadThemeData theme) {
    if (widget.hintColor != null) return widget.hintColor!;

    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 400 : 500,
    );
  }

  double _getBorderWidth() {
    if (widget.borderWidth != null) return widget.borderWidth!;

    if (_isFocused) return 2.0;

    switch (widget.variant) {
      case ShadInputVariant.default_:
      case ShadInputVariant.outline:
        return 1.0;
      case ShadInputVariant.filled:
      case ShadInputVariant.ghost:
        return 0.0;
    }
  }

  String? _getHelperText() {
    if (widget.errorText != null) return widget.errorText;
    if (widget.successText != null) return widget.successText;
    if (widget.warningText != null) return widget.warningText;
    return widget.helperText;
  }

  Color _getHelperTextColor(ShadThemeData theme) {
    if (widget.errorText != null) return theme.errorColor;
    if (widget.successText != null) return theme.successColor;
    if (widget.warningText != null) return theme.warningColor;
    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 500 : 400,
    );
  }

  Widget _buildPasswordToggle(ShadThemeData theme) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showPassword = !_showPassword;
        });
        if (widget.enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
      },
      child: Icon(
        _showPassword ? Icons.visibility_off : Icons.visibility,
        color: _getHintColor(theme),
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final helperText = _getHelperText();

    return AnimatedBuilder(
      animation: _focusAnimation,
      builder: (context, child) {
        return Container(
          width: widget.fullWidth ? double.infinity : widget.minWidth,
          constraints: BoxConstraints(
            minWidth: widget.minWidth ?? 0,
            maxWidth: widget.maxWidth ?? double.infinity,
            minHeight: widget.minHeight ?? 0,
            maxHeight: widget.maxHeight ?? double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Label
              if (widget.label != null) ...[
                AnimatedDefaultTextStyle(
                  duration: widget.animationDuration,
                  style: TextStyle(
                    color: _getLabelColor(theme),
                    fontSize: _getLabelFontSize(),
                    fontWeight: ShadTypography.fontWeightMedium,
                    fontFamily: ShadTypography.fontFamily,
                  ),
                  child: Text(widget.label!),
                ),
                const SizedBox(height: ShadSpacing.xs),
              ],

              // Input Container
              Container(
                decoration: BoxDecoration(
                  color: _getBackgroundColor(theme),
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                  border: Border.all(
                    color: _getBorderColor(theme),
                    width: _getBorderWidth(),
                  ),
                  boxShadow: widget.shadows,
                ),
                child: Row(
                  children: [
                    // Prefix Icon
                    if (widget.prefixIcon != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: ShadSpacing.sm),
                        child: IconTheme(
                          data: IconThemeData(
                            color: _getHintColor(theme),
                            size: 20,
                          ),
                          child: widget.prefixIcon!,
                        ),
                      ),
                    ],

                    // Text Field
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        focusNode: _focusNode,
                        enabled: widget.enabled,
                        readOnly: widget.readOnly,
                        obscureText: widget.obscureText && !_showPassword,
                        autofocus: widget.autofocus,
                        autocorrect: widget.autocorrect,
                        enableSuggestions: widget.enableSuggestions,
                        enableInteractiveSelection:
                            widget.enableInteractiveSelection,
                        keyboardType: widget.keyboardType,
                        textInputAction: widget.textInputAction,
                        textCapitalization: widget.textCapitalization,
                        maxLines: widget.maxLines,
                        minLines: widget.minLines,
                        maxLength: widget.maxLength,
                        onChanged: widget.onChanged,
                        onFieldSubmitted: widget.onSubmitted,
                        onTap: widget.onTap,
                        onEditingComplete: widget.onEditingComplete,
                        inputFormatters: widget.inputFormatters,
                        style: TextStyle(
                          color: _getTextColor(theme),
                          fontSize: _getFontSize(),
                          fontWeight: ShadTypography.fontWeightRegular,
                          fontFamily: ShadTypography.fontFamily,
                        ),
                        decoration: InputDecoration(
                          hintText: widget.hint,
                          hintStyle: TextStyle(
                            color: _getHintColor(theme),
                            fontSize: _getFontSize(),
                            fontWeight: ShadTypography.fontWeightRegular,
                            fontFamily: ShadTypography.fontFamily,
                          ),
                          border: InputBorder.none,
                          contentPadding: _getPadding(),
                          counterText: widget.showCounter
                              ? widget.counterText
                              : null,
                          counterStyle: TextStyle(
                            color: _getHintColor(theme),
                            fontSize: ShadTypography.fontSizeSm,
                            fontFamily: ShadTypography.fontFamily,
                          ),
                        ),
                      ),
                    ),

                    // Suffix Icon or Password Toggle
                    if (widget.obscureText) ...[
                      Padding(
                        padding: const EdgeInsets.only(right: ShadSpacing.sm),
                        child: _buildPasswordToggle(theme),
                      ),
                    ] else if (widget.suffixIcon != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(right: ShadSpacing.sm),
                        child: IconTheme(
                          data: IconThemeData(
                            color: _getHintColor(theme),
                            size: 20,
                          ),
                          child: widget.suffixIcon!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Helper Text
              if (helperText != null) ...[
                const SizedBox(height: ShadSpacing.xs),
                AnimatedDefaultTextStyle(
                  duration: widget.animationDuration,
                  style: TextStyle(
                    color: _getHelperTextColor(theme),
                    fontSize: ShadTypography.fontSizeSm,
                    fontWeight: ShadTypography.fontWeightRegular,
                    fontFamily: ShadTypography.fontFamily,
                  ),
                  child: Text(helperText),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
