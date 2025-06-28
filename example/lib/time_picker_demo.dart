import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class TimePickerDemo extends StatefulWidget {
  const TimePickerDemo({super.key});

  @override
  State<TimePickerDemo> createState() => _TimePickerDemoState();
}

class _TimePickerDemoState extends State<TimePickerDemo> {
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTime2;
  TimeOfDay? _selectedTime3;
  TimeOfDay? _selectedTime4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TimePicker Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TimePicker Variants',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Default variant
            const Text(
              'Default Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              value: _selectedTime,
              onChanged: (time) => setState(() => _selectedTime = time),
              label: 'Select Time',
              placeholder: 'Choose a time',
              helperText: 'This is a helper text',
            ),
            const SizedBox(height: 24),

            // Outline variant
            const Text(
              'Outline Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              value: _selectedTime2,
              onChanged: (time) => setState(() => _selectedTime2 = time),
              variant: ShadTimePickerVariant.outline,
              label: 'Select Time',
              placeholder: 'Choose a time',
            ),
            const SizedBox(height: 24),

            // Filled variant
            const Text(
              'Filled Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              value: _selectedTime3,
              onChanged: (time) => setState(() => _selectedTime3 = time),
              variant: ShadTimePickerVariant.filled,
              label: 'Select Time',
              placeholder: 'Choose a time',
            ),
            const SizedBox(height: 24),

            // Ghost variant
            const Text(
              'Ghost Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              value: _selectedTime4,
              onChanged: (time) => setState(() => _selectedTime4 = time),
              variant: ShadTimePickerVariant.ghost,
              label: 'Select Time',
              placeholder: 'Choose a time',
            ),
            const SizedBox(height: 32),

            const Text(
              'TimePicker Sizes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Small size
            const Text(
              'Small Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              size: ShadTimePickerSize.sm,
              label: 'Small TimePicker',
              placeholder: 'Small',
            ),
            const SizedBox(height: 16),

            // Medium size
            const Text(
              'Medium Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              size: ShadTimePickerSize.md,
              label: 'Medium TimePicker',
              placeholder: 'Medium',
            ),
            const SizedBox(height: 16),

            // Large size
            const Text(
              'Large Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              size: ShadTimePickerSize.lg,
              label: 'Large TimePicker',
              placeholder: 'Large',
            ),
            const SizedBox(height: 32),

            const Text(
              'TimePicker States',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // With error
            const Text(
              'With Error',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ShadTimePicker(
              label: 'TimePicker with Error',
              placeholder: 'This has an error',
              errorText: 'Please select a valid time',
            ),
            const SizedBox(height: 16),

            // Disabled
            const Text(
              'Disabled',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ShadTimePicker(
              label: 'Disabled TimePicker',
              placeholder: 'This is disabled',
              disabled: true,
            ),
            const SizedBox(height: 16),

            // Required
            const Text(
              'Required',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ShadTimePicker(
              label: 'Required TimePicker',
              placeholder: 'This is required',
              required: true,
            ),
            const SizedBox(height: 32),

            const Text(
              'TimePicker with Icons',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // With prefix icon
            const Text(
              'With Prefix Icon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              label: 'TimePicker with Icon',
              placeholder: 'With prefix icon',
              prefixIcon: const Icon(Icons.schedule),
            ),
            const SizedBox(height: 16),

            // With suffix icon
            const Text(
              'With Custom Suffix Icon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadTimePicker(
              label: 'TimePicker with Custom Icon',
              placeholder: 'With custom suffix icon',
              suffixIcon: const Icon(Icons.timer),
            ),
          ],
        ),
      ),
    );
  }
}
