import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'package:shad_ui_flutter/src/components/textarea.dart';

class TextareaDemo extends StatefulWidget {
  const TextareaDemo({super.key});

  @override
  State<TextareaDemo> createState() => _TextareaDemoState();
}

class _TextareaDemoState extends State<TextareaDemo> {
  ShadTextareaVariant variant = ShadTextareaVariant.default_;
  ShadTextareaSize size = ShadTextareaSize.md;
  ShadTextareaState state = ShadTextareaState.normal;
  bool showCounter = false;
  bool enabled = true;
  bool readOnly = false;
  bool fullWidth = false;
  int maxLines = 5;
  int? maxLength = 100;
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Textarea Controls',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DropdownButton<ShadTextareaVariant>(
                      value: variant,
                      onChanged: (v) => setState(() => variant = v!),
                      items: ShadTextareaVariant.values
                          .map(
                            (v) =>
                                DropdownMenuItem(value: v, child: Text(v.name)),
                          )
                          .toList(),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<ShadTextareaSize>(
                      value: size,
                      onChanged: (s) => setState(() => size = s!),
                      items: ShadTextareaSize.values
                          .map(
                            (s) =>
                                DropdownMenuItem(value: s, child: Text(s.name)),
                          )
                          .toList(),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<ShadTextareaState>(
                      value: state,
                      onChanged: (s) => setState(() => state = s!),
                      items: ShadTextareaState.values
                          .map(
                            (s) =>
                                DropdownMenuItem(value: s, child: Text(s.name)),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: showCounter,
                      onChanged: (v) => setState(() => showCounter = v!),
                    ),
                    const Text('Show Counter'),
                    const SizedBox(width: 16),
                    Checkbox(
                      value: enabled,
                      onChanged: (v) => setState(() => enabled = v!),
                    ),
                    const Text('Enabled'),
                    const SizedBox(width: 16),
                    Checkbox(
                      value: readOnly,
                      onChanged: (v) => setState(() => readOnly = v!),
                    ),
                    const Text('Read Only'),
                    const SizedBox(width: 16),
                    Checkbox(
                      value: fullWidth,
                      onChanged: (v) => setState(() => fullWidth = v!),
                    ),
                    const Text('Full Width'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'ShadTextarea Demo',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ShadTextarea(
          label: 'Description',
          hint: 'Enter a detailed description...',
          prefixIcon: const Icon(Icons.description),
          suffixIcon: const Icon(Icons.info_outline),
          maxLength: maxLength,
          maxLines: maxLines,
          showCounter: showCounter,
          enabled: enabled,
          readOnly: readOnly,
          fullWidth: fullWidth,
          variant: variant,
          size: size,
          state: state,
          successText: 'Looks good!',
          errorText: 'Please enter a value',
          warningText: 'Be descriptive',
          onChanged: (val) => setState(() => value = val),
        ),
        const SizedBox(height: 16),
        Text('Current Value: $value'),
      ],
    );
  }
}
