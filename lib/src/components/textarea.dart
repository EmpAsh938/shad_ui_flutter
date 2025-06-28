import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadTextareaVariant { default_, outline, filled, ghost }

enum ShadTextareaSize { sm, md, lg }

enum ShadTextareaState { normal, success, error, warning }

class ShadTextarea extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final int? maxLength;
  final int maxLines;
  final bool showCounter;
  final bool enabled;
  final bool readOnly;
  final bool fullWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ShadTextareaVariant variant;
  final ShadTextareaSize size;
  final ShadTextareaState state;
  final String? successText;
  final String? errorText;
  final String? warningText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? hintColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const ShadTextarea({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.maxLength,
    this.maxLines = 5,
    this.showCounter = false,
    this.enabled = true,
    this.readOnly = false,
    this.fullWidth = false,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = ShadTextareaVariant.default_,
    this.size = ShadTextareaSize.md,
    this.state = ShadTextareaState.normal,
    this.successText,
    this.errorText,
    this.warningText,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.multiline,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.labelColor,
    this.hintColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
  });

  @override
  State<ShadTextarea> createState() => _ShadTextareaState();
}

class _ShadTextareaState extends State<ShadTextarea> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocus);
  }

  void _handleFocus() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  double _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!.topLeft.x;

    switch (widget.size) {
      case ShadTextareaSize.sm:
        return ShadRadius.sm;
      case ShadTextareaSize.lg:
        return ShadRadius.lg;
      case ShadTextareaSize.md:
      default:
        return ShadRadius.md;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    if (widget.padding != null) return widget.padding!;

    switch (widget.size) {
      case ShadTextareaSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.sm,
          vertical: ShadSpacing.xs,
        );
      case ShadTextareaSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.lg,
          vertical: ShadSpacing.md,
        );
      case ShadTextareaSize.md:
      default:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.md,
          vertical: ShadSpacing.sm,
        );
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadTextareaSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadTextareaSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadTextareaSize.md:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  double _getLabelFontSize() {
    switch (widget.size) {
      case ShadTextareaSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadTextareaSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadTextareaSize.md:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  Color _getStateColor(ShadThemeData theme) {
    switch (widget.state) {
      case ShadTextareaState.success:
        return theme.successColor;
      case ShadTextareaState.error:
        return theme.errorColor;
      case ShadTextareaState.warning:
        return theme.warningColor;
      case ShadTextareaState.normal:
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
      case ShadTextareaVariant.default_:
        return theme.brightness == Brightness.light
            ? Colors.white
            : ShadBaseColors.getColor(theme.baseColor, 800);
      case ShadTextareaVariant.outline:
        return Colors.transparent;
      case ShadTextareaVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadTextareaVariant.ghost:
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
      case ShadTextareaVariant.default_:
      case ShadTextareaVariant.outline:
        return 1.0;
      case ShadTextareaVariant.filled:
      case ShadTextareaVariant.ghost:
        return 0.0;
    }
  }

  String? _getHelperText() {
    if (widget.errorText != null) return widget.errorText;
    if (widget.successText != null) return widget.successText;
    if (widget.warningText != null) return widget.warningText;
    return null;
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

  InputBorder _getBorder(ShadThemeData theme) {
    final borderColor = _getBorderColor(theme);
    final borderWidth = _getBorderWidth();
    final radius = _getBorderRadius();

    switch (widget.variant) {
      case ShadTextareaVariant.outline:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        );
      case ShadTextareaVariant.filled:
      case ShadTextareaVariant.ghost:
      case ShadTextareaVariant.default_:
      default:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final backgroundColor = _getBackgroundColor(theme);
    final textColor = _getTextColor(theme);
    final labelColor = _getLabelColor(theme);
    final hintColor = _getHintColor(theme);
    final helperText = _getHelperText();
    final helperTextColor = _getHelperTextColor(theme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: _getLabelFontSize(),
                fontWeight: FontWeight.w600,
                color: labelColor,
              ),
            ),
          ),
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style: TextStyle(fontSize: _getFontSize(), color: textColor),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: _getFontSize(), color: hintColor),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            filled: backgroundColor != Colors.transparent,
            fillColor: backgroundColor,
            contentPadding: _getPadding(),
            enabledBorder: _getBorder(theme),
            focusedBorder: _getBorder(theme),
            errorBorder: _getBorder(theme),
            disabledBorder: _getBorder(theme),
            counterText: widget.showCounter ? null : '',
            counterStyle: TextStyle(
              fontSize: _getFontSize() * 0.8,
              color: hintColor,
            ),
          ),
        ),
        if (helperText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              helperText,
              style: TextStyle(
                fontSize: _getFontSize() * 0.8,
                color: helperTextColor,
              ),
            ),
          ),
      ],
    );
  }
}
