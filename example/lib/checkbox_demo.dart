import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class CheckboxDemo extends StatefulWidget {
  const CheckboxDemo({super.key});

  @override
  State<CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> {
  bool _checkbox1 = false;
  bool _checkbox2 = true;
  bool? _checkbox3;
  bool _checkbox4 = false;
  bool _checkbox5 = false;
  bool _checkbox6 = false;
  bool _checkbox7 = false;
  bool _checkbox8 = false;
  bool _checkbox9 = false;
  bool _checkbox10 = false;
  bool _checkbox11 = false;
  bool _checkbox12 = false;

  ShadCheckboxVariant _selectedVariant = ShadCheckboxVariant.default_;
  ShadCheckboxSize _selectedSize = ShadCheckboxSize.md;
  ShadCheckboxState _selectedState = ShadCheckboxState.normal;
  bool _isDisabled = false;
  bool _isLoading = false;
  bool _isTristate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShadCheckbox Demo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Controls Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Controls',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Variant Control
                    const Text(
                      'Variant:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ShadCheckboxVariant.values.map((variant) {
                        return ChoiceChip(
                          label: Text(variant.name),
                          selected: _selectedVariant == variant,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedVariant = variant);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Size Control
                    const Text(
                      'Size:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ShadCheckboxSize.values.map((size) {
                        return ChoiceChip(
                          label: Text(size.name),
                          selected: _selectedSize == size,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedSize = size);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // State Control
                    const Text(
                      'State:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ShadCheckboxState.values.map((state) {
                        return ChoiceChip(
                          label: Text(state.name),
                          selected: _selectedState == state,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedState = state);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Toggle Controls
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: const Text('Disabled'),
                            value: _isDisabled,
                            onChanged: (value) =>
                                setState(() => _isDisabled = value ?? false),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: const Text('Loading'),
                            value: _isLoading,
                            onChanged: (value) =>
                                setState(() => _isLoading = value ?? false),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ],
                    ),

                    CheckboxListTile(
                      title: const Text('Tristate'),
                      value: _isTristate,
                      onChanged: (value) =>
                          setState(() => _isTristate = value ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Basic Checkboxes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic Checkboxes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    ShadCheckbox(
                      value: _checkbox1,
                      onChanged: _isDisabled
                          ? null
                          : (value) =>
                                setState(() => _checkbox1 = value ?? false),
                      label: 'Basic checkbox',
                      variant: _selectedVariant,
                      size: _selectedSize,
                      state: _selectedState,
                      disabled: _isDisabled,
                      loading: _isLoading,
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox2,
                      onChanged: _isDisabled
                          ? null
                          : (value) =>
                                setState(() => _checkbox2 = value ?? false),
                      label: 'Checked checkbox',
                      description: 'This checkbox is checked by default',
                      variant: _selectedVariant,
                      size: _selectedSize,
                      state: _selectedState,
                      disabled: _isDisabled,
                      loading: _isLoading,
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox3,
                      tristate: _isTristate,
                      onChanged: _isDisabled
                          ? null
                          : (value) => setState(() => _checkbox3 = value),
                      label: 'Tristate checkbox',
                      description: 'Can be null, false, or true',
                      variant: _selectedVariant,
                      size: _selectedSize,
                      state: _selectedState,
                      disabled: _isDisabled,
                      loading: _isLoading,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Different Variants
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Different Variants',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    ShadCheckbox(
                      value: _checkbox4,
                      onChanged: (value) =>
                          setState(() => _checkbox4 = value ?? false),
                      label: 'Default variant',
                      variant: ShadCheckboxVariant.default_,
                      size: _selectedSize,
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox5,
                      onChanged: (value) =>
                          setState(() => _checkbox5 = value ?? false),
                      label: 'Outline variant',
                      variant: ShadCheckboxVariant.outline,
                      size: _selectedSize,
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox6,
                      onChanged: (value) =>
                          setState(() => _checkbox6 = value ?? false),
                      label: 'Filled variant',
                      variant: ShadCheckboxVariant.filled,
                      size: _selectedSize,
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox7,
                      onChanged: (value) =>
                          setState(() => _checkbox7 = value ?? false),
                      label: 'Ghost variant',
                      variant: ShadCheckboxVariant.ghost,
                      size: _selectedSize,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Different Sizes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Different Sizes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    ShadCheckbox(
                      value: _checkbox8,
                      onChanged: (value) =>
                          setState(() => _checkbox8 = value ?? false),
                      label: 'Small size',
                      variant: _selectedVariant,
                      size: ShadCheckboxSize.sm,
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox9,
                      onChanged: (value) =>
                          setState(() => _checkbox9 = value ?? false),
                      label: 'Medium size (default)',
                      variant: _selectedVariant,
                      size: ShadCheckboxSize.md,
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox10,
                      onChanged: (value) =>
                          setState(() => _checkbox10 = value ?? false),
                      label: 'Large size',
                      variant: _selectedVariant,
                      size: ShadCheckboxSize.lg,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Different States
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Different States',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    ShadCheckbox(
                      value: _checkbox11,
                      onChanged: (value) =>
                          setState(() => _checkbox11 = value ?? false),
                      label: 'Success state',
                      variant: _selectedVariant,
                      size: _selectedSize,
                      state: ShadCheckboxState.success,
                      successText: 'This checkbox is in success state',
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: _checkbox12,
                      onChanged: (value) =>
                          setState(() => _checkbox12 = value ?? false),
                      label: 'Error state',
                      variant: _selectedVariant,
                      size: _selectedSize,
                      state: ShadCheckboxState.error,
                      errorText: 'This checkbox has an error',
                    ),

                    const SizedBox(height: 12),

                    ShadCheckbox(
                      value: false,
                      onChanged: null,
                      label: 'Warning state',
                      variant: _selectedVariant,
                      size: _selectedSize,
                      state: ShadCheckboxState.warning,
                      warningText: 'This checkbox has a warning',
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
