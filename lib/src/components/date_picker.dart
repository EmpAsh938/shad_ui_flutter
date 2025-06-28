import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadDatePickerVariant { default_, outline, filled, ghost }

enum ShadDatePickerSize { sm, md, lg }

class ShadDatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? label;
  final String? hint;
  final String? placeholder;
  final bool disabled;
  final bool loading;
  final ShadDatePickerVariant variant;
  final ShadDatePickerSize size;
  final ValueChanged<DateTime?>? onChanged;
  final String Function(DateTime)? dateToString;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadDatePicker({
    super.key,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.label,
    this.hint,
    this.placeholder,
    this.disabled = false,
    this.loading = false,
    this.variant = ShadDatePickerVariant.default_,
    this.size = ShadDatePickerSize.md,
    this.onChanged,
    this.dateToString,
    this.prefixIcon,
    this.suffixIcon,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadDatePicker> createState() => _ShadDatePickerState();
}

class _ShadDatePickerState extends State<ShadDatePicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return widget.placeholder ?? 'Select date';
    if (widget.dateToString != null) return widget.dateToString!(date);
    return '${date.day}/${date.month}/${date.year}';
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ShadDatePickerSize.sm:
        return ShadRadius.sm;
      case ShadDatePickerSize.lg:
        return ShadRadius.lg;
      case ShadDatePickerSize.md:
      default:
        return ShadRadius.md;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (widget.size) {
      case ShadDatePickerSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.sm,
          vertical: ShadSpacing.xs,
        );
      case ShadDatePickerSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.lg,
          vertical: ShadSpacing.md,
        );
      case ShadDatePickerSize.md:
      default:
        return const EdgeInsets.symmetric(
          horizontal: ShadSpacing.md,
          vertical: ShadSpacing.sm,
        );
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ShadDatePickerSize.sm:
        return ShadTypography.fontSizeSm;
      case ShadDatePickerSize.lg:
        return ShadTypography.fontSizeLg;
      case ShadDatePickerSize.md:
      default:
        return ShadTypography.fontSizeMd;
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
      case ShadDatePickerVariant.default_:
        return theme.brightness == Brightness.light
            ? Colors.white
            : ShadBaseColors.getColor(theme.baseColor, 800);
      case ShadDatePickerVariant.outline:
        return Colors.transparent;
      case ShadDatePickerVariant.filled:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 50 : 900,
        );
      case ShadDatePickerVariant.ghost:
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

    switch (widget.variant) {
      case ShadDatePickerVariant.outline:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
      case ShadDatePickerVariant.default_:
      case ShadDatePickerVariant.filled:
      case ShadDatePickerVariant.ghost:
        return ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 200 : 700,
        );
    }
  }

  Color _getTextColor(ShadThemeData theme) {
    if (widget.disabled) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 400 : 600,
      );
    }

    if (widget.selectedDate == null) {
      return ShadBaseColors.getColor(
        theme.baseColor,
        theme.brightness == Brightness.light ? 500 : 400,
      );
    }

    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 900 : 50,
    );
  }

  void _showDatePicker() async {
    if (widget.disabled || widget.loading) return;

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ShadTheme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != widget.selectedDate) {
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return MouseRegion(
          onEnter: !widget.disabled && !widget.loading
              ? (_) => setState(() => _isHovered = true)
              : null,
          onExit: !widget.disabled && !widget.loading
              ? (_) => setState(() => _isHovered = false)
              : null,
          child: GestureDetector(
            onTapDown: !widget.disabled && !widget.loading
                ? (_) => setState(() => _isPressed = true)
                : null,
            onTapUp: !widget.disabled && !widget.loading
                ? (_) => setState(() => _isPressed = false)
                : null,
            onTapCancel: !widget.disabled && !widget.loading
                ? () => setState(() => _isPressed = false)
                : null,
            onTap: _showDatePicker,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.label != null) ...[
                    Text(
                      widget.label!,
                      style: TextStyle(
                        color: widget.disabled
                            ? ShadBaseColors.getColor(
                                theme.baseColor,
                                theme.brightness == Brightness.light
                                    ? 400
                                    : 600,
                              )
                            : ShadBaseColors.getColor(
                                theme.baseColor,
                                theme.brightness == Brightness.light ? 900 : 50,
                              ),
                        fontSize: _getFontSize(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: ShadSpacing.xs),
                  ],
                  Container(
                    padding: _getPadding(),
                    decoration: BoxDecoration(
                      color: _getBackgroundColor(theme),
                      border: Border.all(
                        color: _getBorderColor(theme),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(_getBorderRadius()),
                    ),
                    child: Row(
                      children: [
                        if (widget.prefixIcon != null) ...[
                          widget.prefixIcon!,
                          const SizedBox(width: ShadSpacing.sm),
                        ],
                        Expanded(
                          child: Text(
                            _formatDate(widget.selectedDate),
                            style: TextStyle(
                              color: _getTextColor(theme),
                              fontSize: _getFontSize(),
                            ),
                          ),
                        ),
                        if (widget.suffixIcon != null) ...[
                          const SizedBox(width: ShadSpacing.sm),
                          widget.suffixIcon!,
                        ] else ...[
                          const SizedBox(width: ShadSpacing.sm),
                          Icon(
                            Icons.calendar_today,
                            size: _getFontSize(),
                            color: _getTextColor(theme),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
