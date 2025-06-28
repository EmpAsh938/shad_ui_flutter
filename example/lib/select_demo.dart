import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'package:shad_ui_flutter/src/components/select.dart';

class SelectDemo extends StatefulWidget {
  const SelectDemo({super.key});

  @override
  State<SelectDemo> createState() => _SelectDemoState();
}

class _SelectDemoState extends State<SelectDemo> {
  ShadSelectVariant variant = ShadSelectVariant.default_;
  ShadSelectSize size = ShadSelectSize.md;
  ShadSelectState state = ShadSelectState.normal;
  bool searchable = false;
  bool clearable = true;
  bool disabled = false;
  bool loading = false;
  bool multiple = false;
  bool showSelectedCount = false;

  String? selectedValue;
  List<String> selectedValues = [];

  final List<ShadSelectOption<String>> options = [
    const ShadSelectOption(
      value: 'option1',
      label: 'Option 1',
      description: 'This is the first option',
      icon: Icon(Icons.star),
    ),
    const ShadSelectOption(
      value: 'option2',
      label: 'Option 2',
      description: 'This is the second option',
      icon: Icon(Icons.favorite),
    ),
    const ShadSelectOption(
      value: 'option3',
      label: 'Option 3',
      description: 'This is the third option',
      icon: Icon(Icons.share),
    ),
    const ShadSelectOption(
      value: 'option4',
      label: 'Disabled Option',
      description: 'This option is disabled',
      icon: Icon(Icons.block),
      disabled: true,
    ),
    const ShadSelectOption(
      value: 'option5',
      label: 'Option 5',
      description: 'This is the fifth option',
      icon: Icon(Icons.check),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Select Controls
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Controls',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    DropdownButton<ShadSelectVariant>(
                      value: variant,
                      onChanged: (v) => setState(() => variant = v!),
                      items: ShadSelectVariant.values
                          .map(
                            (v) =>
                                DropdownMenuItem(value: v, child: Text(v.name)),
                          )
                          .toList(),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<ShadSelectSize>(
                      value: size,
                      onChanged: (s) => setState(() => size = s!),
                      items: ShadSelectSize.values
                          .map(
                            (s) =>
                                DropdownMenuItem(value: s, child: Text(s.name)),
                          )
                          .toList(),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<ShadSelectState>(
                      value: state,
                      onChanged: (s) => setState(() => state = s!),
                      items: ShadSelectState.values
                          .map(
                            (s) =>
                                DropdownMenuItem(value: s, child: Text(s.name)),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  children: [
                    Checkbox(
                      value: searchable,
                      onChanged: (v) => setState(() => searchable = v!),
                    ),
                    const Text('Searchable'),
                    Checkbox(
                      value: clearable,
                      onChanged: (v) => setState(() => clearable = v!),
                    ),
                    const Text('Clearable'),
                    Checkbox(
                      value: disabled,
                      onChanged: (v) => setState(() => disabled = v!),
                    ),
                    const Text('Disabled'),
                    Checkbox(
                      value: loading,
                      onChanged: (v) => setState(() => loading = v!),
                    ),
                    const Text('Loading'),
                    Checkbox(
                      value: multiple,
                      onChanged: (v) => setState(() => multiple = v!),
                    ),
                    const Text('Multiple'),
                    Checkbox(
                      value: showSelectedCount,
                      onChanged: (v) => setState(() => showSelectedCount = v!),
                    ),
                    const Text('Show Count'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Basic Select
        Text('Basic Select', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          value: selectedValue,
          selectedValues: multiple ? selectedValues : null,
          label: 'Choose an option',
          placeholder: 'Select an option...',
          multiple: multiple,
          searchable: searchable,
          clearable: clearable,
          disabled: disabled,
          loading: loading,
          variant: variant,
          size: size,
          state: state,
          errorText: state == ShadSelectState.error
              ? 'Please select an option'
              : null,
          successText: state == ShadSelectState.success
              ? 'Great choice!'
              : null,
          warningText: state == ShadSelectState.warning
              ? 'Consider other options'
              : null,
          onChanged: multiple
              ? null
              : (value) => setState(() => selectedValue = value),
          onMultiChanged: multiple
              ? (values) => setState(() => selectedValues = values)
              : null,
          showSelectedCount: showSelectedCount,
        ),
        const SizedBox(height: 16),
        if (multiple)
          Text('Selected: ${selectedValues.join(', ')}')
        else
          Text('Selected: $selectedValue'),
        const SizedBox(height: 24),

        // Single Select Examples
        Text(
          'Single Select Examples',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Default Select',
          placeholder: 'Choose an option',
          variant: ShadSelectVariant.default_,
          size: size,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Outline Select',
          placeholder: 'Choose an option',
          variant: ShadSelectVariant.outline,
          size: size,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Filled Select',
          placeholder: 'Choose an option',
          variant: ShadSelectVariant.filled,
          size: size,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Ghost Select',
          placeholder: 'Choose an option',
          variant: ShadSelectVariant.ghost,
          size: size,
        ),
        const SizedBox(height: 24),

        // Multi Select Examples
        Text(
          'Multi Select Examples',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          selectedValues: [],
          label: 'Multi Select',
          placeholder: 'Choose multiple options',
          multiple: true,
          searchable: true,
          variant: variant,
          size: size,
          onMultiChanged: (values) {
            // Handle multi-select changes
          },
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          selectedValues: [],
          label: 'Multi Select with Max Items',
          placeholder: 'Choose up to 3 options',
          multiple: true,
          maxSelectedItems: 3,
          showSelectedCount: true,
          variant: variant,
          size: size,
          onMultiChanged: (values) {
            // Handle multi-select changes
          },
        ),
        const SizedBox(height: 24),

        // Size Comparison
        Text('Size Comparison', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Small Select',
          placeholder: 'Small size',
          size: ShadSelectSize.sm,
          variant: variant,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Medium Select',
          placeholder: 'Medium size',
          size: ShadSelectSize.md,
          variant: variant,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Large Select',
          placeholder: 'Large size',
          size: ShadSelectSize.lg,
          variant: variant,
        ),
        const SizedBox(height: 24),

        // State Examples
        Text('State Examples', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Success State',
          placeholder: 'Success select',
          state: ShadSelectState.success,
          successText: 'This is a success state',
          variant: variant,
          size: size,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Error State',
          placeholder: 'Error select',
          state: ShadSelectState.error,
          errorText: 'This field is required',
          variant: variant,
          size: size,
        ),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'Warning State',
          placeholder: 'Warning select',
          state: ShadSelectState.warning,
          warningText: 'Please check your selection',
          variant: variant,
          size: size,
        ),
        const SizedBox(height: 24),

        // Custom Options
        Text('Custom Options', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadSelect<String>(
          options: options,
          label: 'With Icons',
          placeholder: 'Select with icons',
          variant: variant,
          size: size,
          optionBuilder: (option) => ListTile(
            leading: option.icon ?? const Icon(Icons.radio_button_unchecked),
            title: Text(option.label),
            subtitle: option.description != null
                ? Text(option.description!)
                : null,
            trailing: option.disabled
                ? const Icon(Icons.block, color: Colors.grey)
                : null,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
