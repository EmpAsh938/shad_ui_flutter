import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class AccordionDemo extends StatefulWidget {
  const AccordionDemo({super.key});

  @override
  State<AccordionDemo> createState() => _AccordionDemoState();
}

class _AccordionDemoState extends State<AccordionDemo> {
  ShadAccordionVariant _variant = ShadAccordionVariant.default_;
  ShadAccordionSize _size = ShadAccordionSize.md;
  ShadAccordionType _type = ShadAccordionType.single;
  bool _collapsible = true;
  bool _showChevron = true;
  String _selectedValue = '';
  List<String> _selectedValues = [];

  final List<ShadAccordionItem> _accordionItems = [
    ShadAccordionItem(
      value: 'item-1',
      title: 'What is Flutter?',
      icon: Icons.info,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flutter is an open-source UI software development kit created by Google.',
          ),
          const SizedBox(height: ShadSpacing.md),
          const Text(
            'Key features:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: ShadSpacing.sm),
          const Text('• Hot reload for fast development'),
          const Text('• Single codebase for multiple platforms'),
          const Text('• Rich set of customizable widgets'),
        ],
      ),
    ),
    ShadAccordionItem(
      value: 'item-2',
      title: 'Getting Started with Flutter',
      icon: Icons.rocket_launch,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('To get started with Flutter development:'),
          const SizedBox(height: ShadSpacing.md),
          const Text('1. Install Flutter SDK'),
          const Text('2. Set up your IDE'),
          const Text('3. Create a new Flutter project'),
          const Text('4. Run your first app'),
        ],
      ),
    ),
    ShadAccordionItem(
      value: 'item-3',
      title: 'Widgets in Flutter',
      icon: Icons.widgets,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Flutter uses a widget-based architecture.'),
          const SizedBox(height: ShadSpacing.md),
          const Text(
            'Types of widgets:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: ShadSpacing.sm),
          const Text('• StatelessWidget - for static content'),
          const Text('• StatefulWidget - for dynamic content'),
          const Text('• InheritedWidget - for data sharing'),
        ],
      ),
    ),
    ShadAccordionItem(
      value: 'item-4',
      title: 'Disabled Item',
      icon: Icons.block,
      isDisabled: true,
      content: const Text('This content is disabled and cannot be accessed.'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accordion Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Variants
            _buildSection(
              'Variants',
              Column(
                children: ShadAccordionVariant.values.map((variant) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          variant.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadAccordion(
                          items: _accordionItems.take(3).toList(),
                          variant: variant,
                          type: _type,
                          collapsible: _collapsible,
                          showChevron: _showChevron,
                          onValueChange: (value) {
                            setState(() => _selectedValue = value);
                          },
                          onValuesChange: (values) {
                            setState(() => _selectedValues = values);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Examples
            _buildSection(
              'Examples',
              Column(
                children: [
                  // Single type
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Single Type (Default)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadAccordion(
                          items: _accordionItems.take(3).toList(),
                          type: ShadAccordionType.single,
                          defaultValue: 'item-1',
                          onValueChange: (value) {
                            setState(() => _selectedValue = value);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Selected: $value')),
                            );
                          },
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        Text('Selected: $_selectedValue'),
                      ],
                    ),
                  ),

                  // Multiple type
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Multiple Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadAccordion(
                          items: _accordionItems.take(4).toList(),
                          type: ShadAccordionType.multiple,
                          defaultValues: ['item-1', 'item-3'],
                          onValuesChange: (values) {
                            setState(() => _selectedValues = values);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Selected: ${values.join(', ')}'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        Text('Selected: ${_selectedValues.join(', ')}'),
                      ],
                    ),
                  ),

                  // Custom styling
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Custom Styling',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadAccordion(
                          items: _accordionItems.take(3).toList(),
                          backgroundColor: Colors.blue.shade50,
                          borderColor: Colors.blue,
                          titleColor: Colors.blue.shade800,
                          contentColor: Colors.blue.shade700,
                          hoverColor: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                          onValueChange: (value) {
                            setState(() => _selectedValue = value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Controls
            _buildSection(
              'Controls',
              Column(
                children: [
                  // Type selector
                  Row(
                    children: [
                      const Text('Type: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadAccordionType>(
                        value: _type,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _type = value);
                          }
                        },
                        items: ShadAccordionType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Variant selector
                  Row(
                    children: [
                      const Text('Variant: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadAccordionVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadAccordionVariant.values.map((variant) {
                          return DropdownMenuItem(
                            value: variant,
                            child: Text(variant.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Feature toggles
                  Row(
                    children: [
                      Checkbox(
                        value: _collapsible,
                        onChanged: (value) =>
                            setState(() => _collapsible = value ?? false),
                      ),
                      const Text('Collapsible'),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _showChevron,
                        onChanged: (value) =>
                            setState(() => _showChevron = value ?? false),
                      ),
                      const Text('Show Chevron'),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Preview
                  const Text(
                    'Preview',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  ShadAccordion(
                    items: _accordionItems,
                    variant: _variant,
                    size: _size,
                    type: _type,
                    collapsible: _collapsible,
                    showChevron: _showChevron,
                    onValueChange: (value) {
                      setState(() => _selectedValue = value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected: $value')),
                      );
                    },
                    onValuesChange: (values) {
                      setState(() => _selectedValues = values);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${values.join(', ')}'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: ShadSpacing.md),
        content,
      ],
    );
  }
}
