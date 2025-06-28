import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadCheckboxVariant { default_, outline, filled, ghost }

enum ShadCheckboxSize { sm, md, lg }

enum ShadCheckboxState { normal, success, error, warning }

class ShadCheckbox extends StatefulWidget {
  final bool? value;
  final bool? tristate;
  final String? label;
  final String? description;
  final bool disabled;
  final bool loading;
  final ShadCheckboxVariant variant;
  final ShadCheckboxSize size;
  final ShadCheckboxState state;
  final String? errorText;
  final String? successText;
  final String? warningText;
  final Widget? icon;
  final ValueChanged<bool?>? onChanged;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadCheckbox({
    super.key,
    this.value,
    this.tristate = false,
    this.label,
    this.description,
    this.disabled = false,
    this.loading = false,
    this.variant = ShadCheckboxVariant.default_,
    this.size = ShadCheckboxSize.md,
    this.state = ShadCheckboxState.normal,
    this.errorText,
    this.successText,
    this.warningText,
    this.icon,
    this.onChanged,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadCheckbox> createState() => _ShadCheckboxState();
}

class _ShadCheckboxState extends State<ShadCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;
  bool _isHovered = false;
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
    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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

  void _handleTap() {
    if (widget.disabled || widget.loading) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    final newValue = _getNextValue();
    widget.onChanged?.call(newValue);
  }

  bool? _getNextValue() {
    if (widget.tristate == true) {
      if (widget.value == null) return false;
      if (widget.value == false) return true;
      return null;
    }
    return !(widget.value ?? false);
  }

  double _getSize() {
    switch (widget.size) {
      case ShadCheckboxSize.sm:
        return 16.0;
      case ShadCheckboxSize.lg:
        return 24.0;
      case ShadCheckboxSize.md:
      default:
        return 20.0;
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ShadCheckboxSize.sm:
        return ShadRadius.xs;
      case ShadCheckboxSize.lg:
        return ShadRadius.md;
      case ShadCheckboxSize.md:
      default:
        return ShadRadius.sm;
    }
  }

  double _getBorderWidth() {
    switch (widget.size) {
      case ShadCheckboxSize.sm:
        return 1.5;
      case ShadCheckboxSize.lg:
        return 2.5;
      case ShadCheckboxSize.md:
      default:
        return 2.0;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadCheckboxSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadCheckboxSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadCheckboxSize.md:
      default:
        return ShadTypography.fontSizeMd;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ShadCheckboxSize.sm:
        return const EdgeInsets.all(ShadSpacing.xs);
      case ShadCheckboxSize.lg:
        return const EdgeInsets.all(ShadSpacing.sm);
      case ShadCheckboxSize.md:
      default:
        return const EdgeInsets.all(ShadSpacing.xs);
    }
  }

  Color _getStateColor(ShadThemeData theme) {
    switch (widget.state) {
      case ShadCheckboxState.success:
        return theme.successColor;
      case ShadCheckboxState.error:
        return theme.errorColor;
      case ShadCheckboxState.warning:
        return theme.warningColor;
      case ShadCheckboxState.normal:
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

    if (widget.value == true) {
      return theme.primaryColor;
    }

    switch (widget.variant) {
      case ShadCheckboxVariant.default_:
        return theme.brightness == Brightness.light
            ? Colors.white
            : ShadBaseColors.getColor(theme.baseColor, 800);
      case ShadCheckboxVariant.outline:
        return Colors.transparent;
      case ShadCheckboxVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadCheckboxVariant.ghost:
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

    if (widget.value == true) {
      return theme.primaryColor;
    }

    if (_isHovered || _isPressed) {
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

    return theme.textColor;
  }

  Widget _buildCheckbox(ShadThemeData theme) {
    final size = _getSize();
    final borderRadius = _getBorderRadius();
    final borderWidth = _getBorderWidth();
    final backgroundColor = _getBackgroundColor(theme);
    final borderColor = _getBorderColor(theme);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: borderWidth),
            ),
            child: widget.loading
                ? Center(
                    child: SizedBox(
                      width: size * 0.5,
                      height: size * 0.5,
                      child: CircularProgressIndicator(
                        strokeWidth: borderWidth * 0.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.value == true
                              ? Colors.white
                              : theme.primaryColor,
                        ),
                      ),
                    ),
                  )
                : widget.value == true
                ? Center(
                    child: AnimatedBuilder(
                      animation: _checkAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _checkAnimation.value,
                          child: Icon(
                            Icons.check,
                            size: size * 0.6,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  )
                : widget.value == null && widget.tristate == true
                ? Center(
                    child: Container(
                      width: size * 0.3,
                      height: size * 0.3,
                      decoration: BoxDecoration(
                        color: borderColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final textColor = _getTextColor(theme);
    final labelColor = _getLabelColor(theme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: GestureDetector(
                onTapDown: (_) => setState(() => _isPressed = true),
                onTapUp: (_) => setState(() => _isPressed = false),
                onTapCancel: () => setState(() => _isPressed = false),
                onTap: _handleTap,
                child: _buildCheckbox(theme),
              ),
            ),
            if (widget.label != null) ...[
              const SizedBox(width: ShadSpacing.sm),
              Expanded(
                child: GestureDetector(
                  onTap: _handleTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label!,
                        style: TextStyle(
                          fontSize: _getFontSize(),
                          fontWeight: FontWeight.w500,
                          color: labelColor,
                        ),
                      ),
                      if (widget.description != null) ...[
                        const SizedBox(height: ShadSpacing.xs),
                        Text(
                          widget.description!,
                          style: TextStyle(
                            fontSize: _getFontSize() * 0.8,
                            color: theme.mutedColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
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
