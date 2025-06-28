import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class BreadcrumbDemo extends StatefulWidget {
  const BreadcrumbDemo({super.key});

  @override
  State<BreadcrumbDemo> createState() => _BreadcrumbDemoState();
}

class _BreadcrumbDemoState extends State<BreadcrumbDemo> {
  ShadBreadcrumbVariant _variant = ShadBreadcrumbVariant.default_;
  ShadBreadcrumbSize _size = ShadBreadcrumbSize.md;
  ShadBreadcrumbSeparator _separator = ShadBreadcrumbSeparator.slash;
  bool _showHomeIcon = false;
  bool _collapsible = false;
  int _maxVisibleItems = 5;

  final List<ShadBreadcrumbItem> _sampleItems = [
    const ShadBreadcrumbItem(label: 'Home', icon: Icons.home),
    const ShadBreadcrumbItem(label: 'Products', icon: Icons.inventory),
    const ShadBreadcrumbItem(label: 'Electronics', icon: Icons.devices),
    const ShadBreadcrumbItem(label: 'Smartphones', icon: Icons.phone_android),
    const ShadBreadcrumbItem(label: 'iPhone', icon: Icons.phone_iphone),
    const ShadBreadcrumbItem(
      label: 'iPhone 15 Pro',
      icon: Icons.phone_iphone,
      isActive: true,
    ),
  ];

  final List<ShadBreadcrumbItem> _longItems = [
    const ShadBreadcrumbItem(label: 'Home', icon: Icons.home),
    const ShadBreadcrumbItem(label: 'Products', icon: Icons.inventory),
    const ShadBreadcrumbItem(label: 'Electronics', icon: Icons.devices),
    const ShadBreadcrumbItem(label: 'Computers', icon: Icons.computer),
    const ShadBreadcrumbItem(label: 'Laptops', icon: Icons.laptop),
    const ShadBreadcrumbItem(label: 'Gaming', icon: Icons.games),
    const ShadBreadcrumbItem(label: 'ASUS', icon: Icons.computer),
    const ShadBreadcrumbItem(label: 'ROG', icon: Icons.games),
    const ShadBreadcrumbItem(label: 'ROG Strix', icon: Icons.laptop),
    const ShadBreadcrumbItem(
      label: 'ROG Strix G15',
      icon: Icons.laptop,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breadcrumb Demo'),
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
                children: ShadBreadcrumbVariant.values.map((variant) {
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
                        ShadBreadcrumb(items: _sampleItems, variant: variant),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Sizes
            _buildSection(
              'Sizes',
              Column(
                children: ShadBreadcrumbSize.values.map((size) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          size.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadBreadcrumb(items: _sampleItems, size: size),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Separators
            _buildSection(
              'Separators',
              Column(
                children: ShadBreadcrumbSeparator.values.map((separator) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          separator.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadBreadcrumb(
                          items: _sampleItems,
                          separator: separator,
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
                  // With home icon
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'With Home Icon',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadBreadcrumb(items: _sampleItems, showHomeIcon: true),
                      ],
                    ),
                  ),

                  // Collapsible
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Collapsible (Long Path)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadBreadcrumb(
                          items: _longItems,
                          collapsible: true,
                          maxVisibleItems: 3,
                        ),
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
                        ShadBreadcrumb(
                          items: _sampleItems,
                          backgroundColor: Colors.blue.shade50,
                          borderColor: Colors.blue,
                          textColor: Colors.blue.shade800,
                          activeTextColor: Colors.blue.shade900,
                          separatorColor: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                  ),

                  // Interactive
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Interactive (Click to navigate)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadBreadcrumb(
                          items: [
                            ShadBreadcrumbItem(
                              label: 'Home',
                              icon: Icons.home,
                              onTap: () => _showSnackBar('Navigated to Home'),
                            ),
                            ShadBreadcrumbItem(
                              label: 'Products',
                              icon: Icons.inventory,
                              onTap: () =>
                                  _showSnackBar('Navigated to Products'),
                            ),
                            ShadBreadcrumbItem(
                              label: 'Electronics',
                              icon: Icons.devices,
                              onTap: () =>
                                  _showSnackBar('Navigated to Electronics'),
                            ),
                            ShadBreadcrumbItem(
                              label: 'Current Page',
                              icon: Icons.location_on,
                              isActive: true,
                            ),
                          ],
                          variant: ShadBreadcrumbVariant.subtle,
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
                  // Variant selector
                  Row(
                    children: [
                      const Text('Variant: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadBreadcrumbVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadBreadcrumbVariant.values.map((variant) {
                          return DropdownMenuItem(
                            value: variant,
                            child: Text(variant.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Size selector
                  Row(
                    children: [
                      const Text('Size: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadBreadcrumbSize>(
                        value: _size,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _size = value);
                          }
                        },
                        items: ShadBreadcrumbSize.values.map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(size.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Separator selector
                  Row(
                    children: [
                      const Text('Separator: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadBreadcrumbSeparator>(
                        value: _separator,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _separator = value);
                          }
                        },
                        items: ShadBreadcrumbSeparator.values.map((separator) {
                          return DropdownMenuItem(
                            value: separator,
                            child: Text(separator.name),
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
                        value: _showHomeIcon,
                        onChanged: (value) =>
                            setState(() => _showHomeIcon = value ?? false),
                      ),
                      const Text('Show Home Icon'),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _collapsible,
                        onChanged: (value) =>
                            setState(() => _collapsible = value ?? false),
                      ),
                      const Text('Collapsible'),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Max visible items slider
                  Row(
                    children: [
                      const Text('Max Visible Items: '),
                      const SizedBox(width: ShadSpacing.sm),
                      Expanded(
                        child: Slider(
                          value: _maxVisibleItems.toDouble(),
                          min: 2,
                          max: 10,
                          divisions: 8,
                          label: _maxVisibleItems.toString(),
                          onChanged: (value) {
                            setState(() => _maxVisibleItems = value.round());
                          },
                        ),
                      ),
                      Text(_maxVisibleItems.toString()),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Preview
                  const Text(
                    'Preview',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  ShadBreadcrumb(
                    items: _collapsible ? _longItems : _sampleItems,
                    variant: _variant,
                    size: _size,
                    separator: _separator,
                    showHomeIcon: _showHomeIcon,
                    collapsible: _collapsible,
                    maxVisibleItems: _maxVisibleItems,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
