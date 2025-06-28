import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadCalendarVariant { default_, outline, ghost }

enum ShadCalendarSize { sm, md, lg }

enum ShadCalendarView { month, year }

class ShadCalendarEvent {
  final DateTime date;
  final String title;
  final String? description;
  final Color? color;
  final bool isAllDay;
  final DateTime? startTime;
  final DateTime? endTime;

  const ShadCalendarEvent({
    required this.date,
    required this.title,
    this.description,
    this.color,
    this.isAllDay = false,
    this.startTime,
    this.endTime,
  });
}

class ShadCalendar extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? focusedDate;
  final List<ShadCalendarEvent>? events;
  final ShadCalendarVariant variant;
  final ShadCalendarSize size;
  final ShadCalendarView view;
  final bool showTodayButton;
  final bool showViewToggle;
  final bool showWeekNumbers;
  final bool showEventIndicators;
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTime>? onDateFocused;
  final ValueChanged<ShadCalendarEvent>? onEventTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? selectedColor;
  final Color? todayColor;
  final Color? eventColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadCalendar({
    super.key,
    this.selectedDate,
    this.focusedDate,
    this.events,
    this.variant = ShadCalendarVariant.default_,
    this.size = ShadCalendarSize.md,
    this.view = ShadCalendarView.month,
    this.showTodayButton = true,
    this.showViewToggle = true,
    this.showWeekNumbers = false,
    this.showEventIndicators = true,
    this.onDateSelected,
    this.onDateFocused,
    this.onEventTap,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.padding,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadCalendar> createState() => _ShadCalendarState();
}

class _ShadCalendarState extends State<ShadCalendar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late DateTime _focusedDate;
  late ShadCalendarView _currentView;

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.focusedDate ?? DateTime.now();
    _currentView = widget.view;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ShadCalendarSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadCalendarSize.sm:
        return ShadCalendarSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.sm),
          cellSize: 32,
          fontSize: ShadTypography.fontSizeSm,
          headerFontSize: ShadTypography.fontSizeSm,
          borderRadius: ShadRadius.sm,
        );
      case ShadCalendarSize.lg:
        return ShadCalendarSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.lg),
          cellSize: 48,
          fontSize: ShadTypography.fontSizeLg,
          headerFontSize: ShadTypography.fontSizeLg,
          borderRadius: ShadRadius.lg,
        );
      case ShadCalendarSize.md:
      default:
        return ShadCalendarSizeTokens(
          padding: const EdgeInsets.all(ShadSpacing.md),
          cellSize: 40,
          fontSize: ShadTypography.fontSizeMd,
          headerFontSize: ShadTypography.fontSizeMd,
          borderRadius: ShadRadius.md,
        );
    }
  }

  ShadCalendarVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadCalendarVariant.default_:
        return ShadCalendarVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          selectedColor: widget.selectedColor ?? theme.primaryColor,
          todayColor:
              widget.todayColor ?? theme.primaryColor.withValues(alpha: 0.1),
          eventColor: widget.eventColor ?? theme.primaryColor,
        );
      case ShadCalendarVariant.outline:
        return ShadCalendarVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          selectedColor: widget.selectedColor ?? theme.primaryColor,
          todayColor:
              widget.todayColor ?? theme.primaryColor.withValues(alpha: 0.1),
          eventColor: widget.eventColor ?? theme.primaryColor,
        );
      case ShadCalendarVariant.ghost:
        return ShadCalendarVariantTokens(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          borderColor: widget.borderColor ?? Colors.transparent,
          textColor: widget.textColor ?? theme.textColor,
          selectedColor: widget.selectedColor ?? theme.primaryColor,
          todayColor:
              widget.todayColor ?? theme.primaryColor.withValues(alpha: 0.1),
          eventColor: widget.eventColor ?? theme.primaryColor,
        );
    }
  }

  void _goToPreviousMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
    });
    widget.onDateFocused?.call(_focusedDate);
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
    });
    widget.onDateFocused?.call(_focusedDate);
  }

  void _goToToday() {
    setState(() {
      _focusedDate = DateTime.now();
    });
    widget.onDateFocused?.call(_focusedDate);
  }

  void _toggleView() {
    setState(() {
      _currentView = _currentView == ShadCalendarView.month
          ? ShadCalendarView.year
          : ShadCalendarView.month;
    });
  }

  void _selectDate(DateTime date) {
    widget.onDateSelected?.call(date);
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDay.day;
    final firstWeekday = firstDay.weekday;

    final List<DateTime> days = [];

    // Add days from previous month
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDay.subtract(Duration(days: i)));
    }

    // Add days from current month
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    // Add days from next month to complete the grid
    final remainingDays = 42 - days.length; // 6 rows * 7 days
    for (int i = 1; i <= remainingDays; i++) {
      days.add(lastDay.add(Duration(days: i)));
    }

    return days;
  }

  List<ShadCalendarEvent> _getEventsForDate(DateTime date) {
    if (widget.events == null) return [];
    return widget.events!.where((event) {
      return event.date.year == date.year &&
          event.date.month == date.month &&
          event.date.day == date.day;
    }).toList();
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
              padding: widget.padding ?? sizeTokens.padding,
              decoration: BoxDecoration(
                color: variantTokens.backgroundColor,
                border: widget.variant == ShadCalendarVariant.outline
                    ? Border.all(color: variantTokens.borderColor)
                    : null,
                borderRadius:
                    widget.borderRadius ??
                    BorderRadius.circular(sizeTokens.borderRadius),
              ),
              child: Column(
                children: [
                  // Header
                  _buildHeader(sizeTokens, variantTokens),

                  const SizedBox(height: ShadSpacing.md),

                  // Calendar grid
                  _currentView == ShadCalendarView.month
                      ? _buildMonthView(sizeTokens, variantTokens)
                      : _buildYearView(sizeTokens, variantTokens),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    ShadCalendarSizeTokens sizeTokens,
    ShadCalendarVariantTokens variantTokens,
  ) {
    return Row(
      children: [
        // Previous button
        IconButton(
          onPressed: _goToPreviousMonth,
          icon: Icon(
            Icons.chevron_left,
            color: variantTokens.textColor,
            size: sizeTokens.fontSize,
          ),
        ),

        // Month/Year display
        Expanded(
          child: Text(
            _currentView == ShadCalendarView.month
                ? '${_getMonthName(_focusedDate.month)} ${_focusedDate.year}'
                : '${_focusedDate.year}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sizeTokens.headerFontSize,
              fontWeight: FontWeight.w600,
              color: variantTokens.textColor,
            ),
          ),
        ),

        // Next button
        IconButton(
          onPressed: _goToNextMonth,
          icon: Icon(
            Icons.chevron_right,
            color: variantTokens.textColor,
            size: sizeTokens.fontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthView(
    ShadCalendarSizeTokens sizeTokens,
    ShadCalendarVariantTokens variantTokens,
  ) {
    final days = _getDaysInMonth(_focusedDate);
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Column(
      children: [
        // Weekday headers
        Row(
          children: weekdays.map((weekday) {
            return Expanded(
              child: Container(
                height: sizeTokens.cellSize,
                alignment: Alignment.center,
                child: Text(
                  weekday,
                  style: TextStyle(
                    fontSize: sizeTokens.fontSize * 0.8,
                    fontWeight: FontWeight.w500,
                    color: variantTokens.textColor.withValues(alpha: 0.7),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: ShadSpacing.xs),

        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final date = days[index];
            final isCurrentMonth = date.month == _focusedDate.month;
            final isToday = _isToday(date);
            final isSelected =
                widget.selectedDate != null &&
                _isSameDay(date, widget.selectedDate!);
            final events = _getEventsForDate(date);

            return _buildDayCell(
              date,
              isCurrentMonth,
              isToday,
              isSelected,
              events,
              sizeTokens,
              variantTokens,
            );
          },
        ),

        // Today button
        if (widget.showTodayButton) ...[
          const SizedBox(height: ShadSpacing.md),
          ElevatedButton(
            onPressed: _goToToday,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: ShadSpacing.md,
                vertical: ShadSpacing.sm,
              ),
            ),
            child: const Text('Today'),
          ),
        ],
      ],
    );
  }

  Widget _buildYearView(
    ShadCalendarSizeTokens sizeTokens,
    ShadCalendarVariantTokens variantTokens,
  ) {
    final months = List.generate(12, (index) => index + 1);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      itemCount: months.length,
      itemBuilder: (context, index) {
        final month = months[index];
        final isCurrentMonth =
            month == DateTime.now().month &&
            _focusedDate.year == DateTime.now().year;
        final isSelected =
            widget.selectedDate != null &&
            widget.selectedDate!.month == month &&
            widget.selectedDate!.year == _focusedDate.year;

        return GestureDetector(
          onTap: () {
            setState(() {
              _focusedDate = DateTime(_focusedDate.year, month, 1);
              _currentView = ShadCalendarView.month;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? variantTokens.selectedColor
                  : isCurrentMonth
                  ? variantTokens.todayColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
              border: widget.variant == ShadCalendarVariant.outline
                  ? Border.all(color: variantTokens.borderColor)
                  : null,
            ),
            child: Center(
              child: Text(
                _getMonthName(month),
                style: TextStyle(
                  fontSize: sizeTokens.fontSize,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.white : variantTokens.textColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayCell(
    DateTime date,
    bool isCurrentMonth,
    bool isToday,
    bool isSelected,
    List<ShadCalendarEvent> events,
    ShadCalendarSizeTokens sizeTokens,
    ShadCalendarVariantTokens variantTokens,
  ) {
    return GestureDetector(
      onTap: () => _selectDate(date),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isSelected
              ? variantTokens.selectedColor
              : isToday
              ? variantTokens.todayColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
          border: widget.variant == ShadCalendarVariant.outline
              ? Border.all(color: variantTokens.borderColor)
              : null,
        ),
        child: Stack(
          children: [
            // Date number
            Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: sizeTokens.fontSize,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : isCurrentMonth
                      ? variantTokens.textColor
                      : variantTokens.textColor.withValues(alpha: 0.5),
                ),
              ),
            ),

            // Event indicators
            if (widget.showEventIndicators && events.isNotEmpty)
              Positioned(
                bottom: 2,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: events.take(3).map((event) {
                    return Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: event.color ?? variantTokens.eventColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class ShadCalendarSizeTokens {
  final EdgeInsetsGeometry padding;
  final double cellSize;
  final double fontSize;
  final double headerFontSize;
  final double borderRadius;

  const ShadCalendarSizeTokens({
    required this.padding,
    required this.cellSize,
    required this.fontSize,
    required this.headerFontSize,
    required this.borderRadius,
  });
}

class ShadCalendarVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color selectedColor;
  final Color todayColor;
  final Color eventColor;

  const ShadCalendarVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.selectedColor,
    required this.todayColor,
    required this.eventColor,
  });
}
