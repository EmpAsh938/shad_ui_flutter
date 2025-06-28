import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class CalendarDemo extends StatefulWidget {
  const CalendarDemo({super.key});

  @override
  State<CalendarDemo> createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<CalendarDemo> {
  ShadCalendarVariant _variant = ShadCalendarVariant.default_;
  ShadCalendarSize _size = ShadCalendarSize.md;
  ShadCalendarView _view = ShadCalendarView.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  bool _showTodayButton = true;
  bool _showNavigationButtons = true;
  bool _showWeekNumbers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ShadSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Controls',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: ShadSpacing.md),

                    // Variant
                    Text(
                      'Variant:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Wrap(
                      spacing: ShadSpacing.sm,
                      children: ShadCalendarVariant.values.map((variant) {
                        return ChoiceChip(
                          label: Text(variant.name),
                          selected: _variant == variant,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _variant = variant);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: ShadSpacing.md),

                    // Size
                    Text(
                      'Size:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Wrap(
                      spacing: ShadSpacing.sm,
                      children: ShadCalendarSize.values.map((size) {
                        return ChoiceChip(
                          label: Text(size.name),
                          selected: _size == size,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _size = size);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: ShadSpacing.md),

                    // View
                    Text(
                      'View:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Wrap(
                      spacing: ShadSpacing.sm,
                      children: ShadCalendarView.values.map((view) {
                        return ChoiceChip(
                          label: Text(view.name),
                          selected: _view == view,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _view = view);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: ShadSpacing.md),

                    // Options
                    Text(
                      'Options:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    CheckboxListTile(
                      title: const Text('Show Today Button'),
                      value: _showTodayButton,
                      onChanged: (value) {
                        setState(() => _showTodayButton = value ?? true);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Show Navigation Buttons'),
                      value: _showNavigationButtons,
                      onChanged: (value) {
                        setState(() => _showNavigationButtons = value ?? true);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Show Week Numbers'),
                      value: _showWeekNumbers,
                      onChanged: (value) {
                        setState(() => _showWeekNumbers = value ?? false);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: ShadSpacing.lg),

            // Examples
            Text('Examples', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: ShadSpacing.md),

            // Default Calendar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ShadSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Default Calendar',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Text(
                      'A basic calendar with month view and date selection.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    ShadCalendar(
                      selectedDate: _selectedDate,
                      focusedDate: _focusedDate,
                      variant: _variant,
                      size: _size,
                      view: _view,
                      showTodayButton: _showTodayButton,
                      showWeekNumbers: _showWeekNumbers,
                      onDateSelected: (date) {
                        setState(() => _selectedDate = date);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selected: ${date.toString().split(' ')[0]}',
                            ),
                          ),
                        );
                      },
                      onDateFocused: (date) {
                        setState(() => _focusedDate = date);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: ShadSpacing.lg),

            // Custom Calendar
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ShadSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Calendar',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Text(
                      'Calendar with custom styling and colors.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    ShadCalendar(
                      selectedDate: _selectedDate,
                      focusedDate: _focusedDate,
                      variant: ShadCalendarVariant.outline,
                      size: _size,
                      view: _view,
                      showTodayButton: _showTodayButton,
                      showWeekNumbers: _showWeekNumbers,
                      backgroundColor: Colors.blue[50],
                      borderColor: Colors.blue[200],
                      selectedColor: Colors.blue[600]!,
                      todayColor: Colors.orange[400]!,
                      textColor: Colors.blue[900]!,
                      onDateSelected: (date) {
                        setState(() => _selectedDate = date);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selected: ${date.toString().split(' ')[0]}',
                            ),
                          ),
                        );
                      },
                      onDateFocused: (date) {
                        setState(() => _focusedDate = date);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: ShadSpacing.lg),

            // Selected Date Display
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ShadSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Date',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(ShadSpacing.md),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(ShadRadius.md),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: ShadSpacing.sm),
                          Text(
                            _selectedDate.toString().split(' ')[0],
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
