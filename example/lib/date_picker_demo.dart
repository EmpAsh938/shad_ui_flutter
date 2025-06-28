import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'package:shad_ui_flutter/src/tokens/tokens.dart';

class DatePickerDemo extends StatefulWidget {
  const DatePickerDemo({super.key});

  @override
  State<DatePickerDemo> createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;
  DateTime? _selectedDate3;
  DateTime? _selectedDate4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date Picker Component',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.lg),

            _buildSection('Default Date Picker', [
              ShadDatePicker(
                selectedDate: _selectedDate1,
                onChanged: (date) => setState(() => _selectedDate1 = date),
                label: 'Select Date',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Variants', [
              ShadDatePicker(
                selectedDate: _selectedDate2,
                onChanged: (date) => setState(() => _selectedDate2 = date),
                variant: ShadDatePickerVariant.outline,
                label: 'Outline Variant',
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadDatePicker(
                selectedDate: _selectedDate3,
                onChanged: (date) => setState(() => _selectedDate3 = date),
                variant: ShadDatePickerVariant.filled,
                label: 'Filled Variant',
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadDatePicker(
                selectedDate: _selectedDate4,
                onChanged: (date) => setState(() => _selectedDate4 = date),
                variant: ShadDatePickerVariant.ghost,
                label: 'Ghost Variant',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Sizes', [
              ShadDatePicker(
                selectedDate: _selectedDate1,
                onChanged: (date) => setState(() => _selectedDate1 = date),
                size: ShadDatePickerSize.sm,
                label: 'Small',
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadDatePicker(
                selectedDate: _selectedDate2,
                onChanged: (date) => setState(() => _selectedDate2 = date),
                size: ShadDatePickerSize.md,
                label: 'Medium',
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadDatePicker(
                selectedDate: _selectedDate3,
                onChanged: (date) => setState(() => _selectedDate3 = date),
                size: ShadDatePickerSize.lg,
                label: 'Large',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Custom Formatting', [
              ShadDatePicker(
                selectedDate: _selectedDate1,
                onChanged: (date) => setState(() => _selectedDate1 = date),
                dateToString: (date) =>
                    '${date.day}/${date.month}/${date.year}',
                label: 'Custom Format',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Date Range', [
              ShadDatePicker(
                selectedDate: _selectedDate2,
                onChanged: (date) => setState(() => _selectedDate2 = date),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                label: 'Date Range (2020-2030)',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Icons', [
              ShadDatePicker(
                selectedDate: _selectedDate3,
                onChanged: (date) => setState(() => _selectedDate3 = date),
                prefixIcon: const Icon(Icons.event),
                label: 'With Prefix Icon',
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadDatePicker(
                selectedDate: _selectedDate4,
                onChanged: (date) => setState(() => _selectedDate4 = date),
                suffixIcon: const Icon(Icons.schedule),
                label: 'With Suffix Icon',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Disabled', [
              ShadDatePicker(
                selectedDate: DateTime.now(),
                onChanged: null,
                disabled: true,
                label: 'Disabled Date Picker',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: ShadTypography.fontSizeLg,
            fontWeight: ShadTypography.fontWeightBold,
          ),
        ),
        const SizedBox(height: ShadSpacing.md),
        ...children,
      ],
    );
  }
}
