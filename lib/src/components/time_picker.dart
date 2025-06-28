import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';

enum ShadTimePickerVariant { default_, outline, filled, ghost }

enum ShadTimePickerSize { sm, md, lg }

class ShadTimePicker extends StatefulWidget {
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay>? onChanged;
  final ShadTimePickerVariant variant;
  final ShadTimePickerSize size;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final bool disabled;
  final bool required;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ShadThemeData? theme;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadTimePicker({
    super.key,
    this.value,
    this.onChanged,
    this.variant = ShadTimePickerVariant.default_,
    this.size = ShadTimePickerSize.md,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.disabled = false,
    this.required = false,
    this.prefixIcon,
    this.suffixIcon,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadTimePicker> createState() => _ShadTimePickerState();
}

class _ShadTimePickerState extends State<ShadTimePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.disabled) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.disabled) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (!widget.disabled) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  Future<void> _showTimePicker() async {
    if (widget.disabled) return;

    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: widget.value ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: widget.theme?.backgroundColor,
              hourMinuteTextColor: widget.theme?.textColor,
              hourMinuteColor: widget.theme?.mutedColor,
              dayPeriodTextColor: widget.theme?.textColor,
              dayPeriodColor: widget.theme?.mutedColor,
              dialHandColor: widget.theme?.primaryColor,
              dialBackgroundColor: widget.theme?.mutedColor,
              dialTextColor: widget.theme?.textColor,
              entryModeIconColor: widget.theme?.textColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null && widget.onChanged != null) {
      widget.onChanged!(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ShadTheme.of(context);

    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);

    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final isDisabled = widget.disabled;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.label != null) ...[
                  Row(
                    children: [
                      Text(
                        widget.label!,
                        style: TextStyle(
                          fontSize: sizeTokens.labelSize,
                          fontWeight: FontWeight.w500,
                          color: hasError
                              ? theme.errorColor
                              : isDisabled
                              ? theme.mutedColor
                              : theme.textColor,
                        ),
                      ),
                      if (widget.required)
                        Text(
                          ' *',
                          style: TextStyle(
                            fontSize: sizeTokens.labelSize,
                            color: theme.errorColor,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: sizeTokens.labelSpacing),
                ],
                GestureDetector(
                  onTapDown: _handleTapDown,
                  onTapUp: _handleTapUp,
                  onTapCancel: _handleTapCancel,
                  onTap: _showTimePicker,
                  child: Container(
                    height: sizeTokens.height,
                    padding: EdgeInsets.symmetric(
                      horizontal: sizeTokens.paddingX,
                      vertical: sizeTokens.paddingY,
                    ),
                    decoration: BoxDecoration(
                      color: _getBackgroundColor(
                        variantTokens,
                        hasError,
                        isDisabled,
                      ),
                      border: Border.all(
                        color: _getBorderColor(
                          variantTokens,
                          hasError,
                          isDisabled,
                        ),
                        width: sizeTokens.borderWidth,
                      ),
                      borderRadius: BorderRadius.circular(
                        sizeTokens.borderRadius,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (widget.prefixIcon != null) ...[
                          widget.prefixIcon!,
                          SizedBox(width: sizeTokens.iconSpacing),
                        ],
                        Expanded(
                          child: Text(
                            widget.value != null
                                ? widget.value!.format(context)
                                : widget.placeholder ?? 'Select time',
                            style: TextStyle(
                              fontSize: sizeTokens.textSize,
                              color: _getTextColor(
                                variantTokens,
                                hasError,
                                isDisabled,
                              ),
                            ),
                          ),
                        ),
                        if (widget.suffixIcon != null) ...[
                          SizedBox(width: sizeTokens.iconSpacing),
                          widget.suffixIcon!,
                        ] else ...[
                          SizedBox(width: sizeTokens.iconSpacing),
                          Icon(
                            Icons.access_time,
                            size: sizeTokens.iconSize,
                            color: _getIconColor(
                              variantTokens,
                              hasError,
                              isDisabled,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (widget.helperText != null && !hasError) ...[
                  SizedBox(height: sizeTokens.helperSpacing),
                  Text(
                    widget.helperText!,
                    style: TextStyle(
                      fontSize: sizeTokens.helperSize,
                      color: isDisabled ? theme.mutedColor : theme.mutedColor,
                    ),
                  ),
                ],
                if (hasError) ...[
                  SizedBox(height: sizeTokens.helperSpacing),
                  Text(
                    widget.errorText!,
                    style: TextStyle(
                      fontSize: sizeTokens.helperSize,
                      color: theme.errorColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  ShadTimePickerSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadTimePickerSize.sm:
        return ShadTimePickerSizeTokens(
          height: 32,
          paddingX: 8,
          paddingY: 4,
          textSize: 14,
          labelSize: 12,
          helperSize: 11,
          iconSize: 16,
          borderWidth: 1,
          borderRadius: 6,
          labelSpacing: 4,
          helperSpacing: 4,
          iconSpacing: 8,
        );
      case ShadTimePickerSize.md:
        return ShadTimePickerSizeTokens(
          height: 40,
          paddingX: 12,
          paddingY: 8,
          textSize: 16,
          labelSize: 14,
          helperSize: 12,
          iconSize: 18,
          borderWidth: 1,
          borderRadius: 8,
          labelSpacing: 6,
          helperSpacing: 6,
          iconSpacing: 10,
        );
      case ShadTimePickerSize.lg:
        return ShadTimePickerSizeTokens(
          height: 48,
          paddingX: 16,
          paddingY: 12,
          textSize: 18,
          labelSize: 16,
          helperSize: 14,
          iconSize: 20,
          borderWidth: 1,
          borderRadius: 10,
          labelSpacing: 8,
          helperSpacing: 8,
          iconSpacing: 12,
        );
    }
  }

  ShadTimePickerVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadTimePickerVariant.default_:
        return ShadTimePickerVariantTokens(
          backgroundColor: theme.backgroundColor,
          borderColor: theme.borderColor,
          textColor: theme.textColor,
          iconColor: theme.mutedColor,
          hoverBackgroundColor: theme.secondaryColor,
          hoverBorderColor: theme.borderColor,
          focusBackgroundColor: theme.backgroundColor,
          focusBorderColor: theme.primaryColor,
        );
      case ShadTimePickerVariant.outline:
        return ShadTimePickerVariantTokens(
          backgroundColor: Colors.transparent,
          borderColor: theme.borderColor,
          textColor: theme.textColor,
          iconColor: theme.mutedColor,
          hoverBackgroundColor: theme.secondaryColor,
          hoverBorderColor: theme.borderColor,
          focusBackgroundColor: Colors.transparent,
          focusBorderColor: theme.primaryColor,
        );
      case ShadTimePickerVariant.filled:
        return ShadTimePickerVariantTokens(
          backgroundColor: theme.mutedColor,
          borderColor: Colors.transparent,
          textColor: theme.textColor,
          iconColor: theme.mutedColor,
          hoverBackgroundColor: theme.mutedColor,
          hoverBorderColor: Colors.transparent,
          focusBackgroundColor: theme.mutedColor,
          focusBorderColor: theme.primaryColor,
        );
      case ShadTimePickerVariant.ghost:
        return ShadTimePickerVariantTokens(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          textColor: theme.textColor,
          iconColor: theme.mutedColor,
          hoverBackgroundColor: theme.secondaryColor,
          hoverBorderColor: Colors.transparent,
          focusBackgroundColor: Colors.transparent,
          focusBorderColor: theme.primaryColor,
        );
    }
  }

  Color _getBackgroundColor(
    ShadTimePickerVariantTokens tokens,
    bool hasError,
    bool isDisabled,
  ) {
    if (isDisabled) return tokens.backgroundColor.withValues(alpha: 0.5);
    if (hasError) return tokens.backgroundColor;
    if (_isPressed) return tokens.hoverBackgroundColor;
    return tokens.backgroundColor;
  }

  Color _getBorderColor(
    ShadTimePickerVariantTokens tokens,
    bool hasError,
    bool isDisabled,
  ) {
    if (isDisabled) return tokens.borderColor.withValues(alpha: 0.5);
    if (hasError) return Colors.red;
    if (_isPressed) return tokens.focusBorderColor;
    return tokens.borderColor;
  }

  Color _getTextColor(
    ShadTimePickerVariantTokens tokens,
    bool hasError,
    bool isDisabled,
  ) {
    if (isDisabled) return tokens.textColor.withValues(alpha: 0.5);
    if (hasError) return Colors.red;
    return tokens.textColor;
  }

  Color _getIconColor(
    ShadTimePickerVariantTokens tokens,
    bool hasError,
    bool isDisabled,
  ) {
    if (isDisabled) return tokens.iconColor.withValues(alpha: 0.5);
    if (hasError) return Colors.red;
    return tokens.iconColor;
  }
}

class ShadTimePickerSizeTokens {
  final double height;
  final double paddingX;
  final double paddingY;
  final double textSize;
  final double labelSize;
  final double helperSize;
  final double iconSize;
  final double borderWidth;
  final double borderRadius;
  final double labelSpacing;
  final double helperSpacing;
  final double iconSpacing;

  const ShadTimePickerSizeTokens({
    required this.height,
    required this.paddingX,
    required this.paddingY,
    required this.textSize,
    required this.labelSize,
    required this.helperSize,
    required this.iconSize,
    required this.borderWidth,
    required this.borderRadius,
    required this.labelSpacing,
    required this.helperSpacing,
    required this.iconSpacing,
  });
}

class ShadTimePickerVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final Color hoverBackgroundColor;
  final Color hoverBorderColor;
  final Color focusBackgroundColor;
  final Color focusBorderColor;

  const ShadTimePickerVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    required this.hoverBackgroundColor,
    required this.hoverBorderColor,
    required this.focusBackgroundColor,
    required this.focusBorderColor,
  });
}
