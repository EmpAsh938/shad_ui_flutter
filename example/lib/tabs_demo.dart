import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class TabsDemo extends StatefulWidget {
  const TabsDemo({super.key});

  @override
  State<TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TabsDemo> {
  ShadTabsVariant _variant = ShadTabsVariant.default_;
  ShadTabsSize _size = ShadTabsSize.md;
  ShadTabsOrientation _orientation = ShadTabsOrientation.horizontal;

  final List<ShadTab> _tabs = [
    const ShadTab(
      label: 'Overview',
      icon: Icons.dashboard,
      content: _TabContent(
        title: 'Overview',
        content:
            'This is the overview tab content. Here you can see a summary of all important information.',
        icon: Icons.dashboard,
      ),
    ),
    const ShadTab(
      label: 'Analytics',
      icon: Icons.analytics,
      badge: ShadBadge(variant: ShadBadgeVariant.secondary, child: Text('New')),
      content: _TabContent(
        title: 'Analytics',
        content:
            'Analytics tab shows detailed metrics and performance data. Track your progress and insights here.',
        icon: Icons.analytics,
      ),
    ),
    const ShadTab(
      label: 'Reports',
      icon: Icons.assessment,
      content: _TabContent(
        title: 'Reports',
        content:
            'Generate and view detailed reports. Export data and create custom visualizations.',
        icon: Icons.assessment,
      ),
    ),
    const ShadTab(
      label: 'Settings',
      icon: Icons.settings,
      content: _TabContent(
        title: 'Settings',
        content:
            'Configure your preferences and manage account settings. Customize your experience.',
        icon: Icons.settings,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Demo'),
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
                children: ShadTabsVariant.values.map((variant) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          variant.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        SizedBox(
                          height: 300,
                          child: ShadTabs(variant: variant, tabs: _tabs),
                        ),
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
                children: ShadTabsSize.values.map((size) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          size.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        SizedBox(
                          height: 300,
                          child: ShadTabs(size: size, tabs: _tabs),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Orientations
            _buildSection(
              'Orientations',
              Column(
                children: [
                  // Horizontal
                  const Text(
                    'Horizontal',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  SizedBox(
                    height: 300,
                    child: ShadTabs(
                      orientation: ShadTabsOrientation.horizontal,
                      tabs: _tabs,
                    ),
                  ),
                  const SizedBox(height: ShadSpacing.lg),

                  // Vertical
                  const Text(
                    'Vertical',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  SizedBox(
                    height: 400,
                    child: ShadTabs(
                      orientation: ShadTabsOrientation.vertical,
                      tabs: _tabs,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Customization
            _buildSection(
              'Customization',
              Column(
                children: [
                  // Custom colors
                  const Text(
                    'Custom Colors',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  SizedBox(
                    height: 300,
                    child: ShadTabs(
                      activeColor: Colors.purple,
                      inactiveColor: Colors.grey,
                      indicatorColor: Colors.purple,
                      tabs: _tabs,
                    ),
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Non-animated
                  const Text(
                    'Non-animated',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  SizedBox(
                    height: 300,
                    child: const ShadTabs(
                      animated: false,
                      tabs: [
                        ShadTab(
                          label: 'Tab 1',
                          content: _TabContent(
                            title: 'Tab 1',
                            content: 'This tab has no animations.',
                            icon: Icons.info,
                          ),
                        ),
                        ShadTab(
                          label: 'Tab 2',
                          content: _TabContent(
                            title: 'Tab 2',
                            content: 'Instant switching between tabs.',
                            icon: Icons.info,
                          ),
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
                      DropdownButton<ShadTabsVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadTabsVariant.values.map((variant) {
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
                      DropdownButton<ShadTabsSize>(
                        value: _size,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _size = value);
                          }
                        },
                        items: ShadTabsSize.values.map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(size.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Orientation selector
                  Row(
                    children: [
                      const Text('Orientation: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadTabsOrientation>(
                        value: _orientation,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _orientation = value);
                          }
                        },
                        items: ShadTabsOrientation.values.map((orientation) {
                          return DropdownMenuItem(
                            value: orientation,
                            child: Text(orientation.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Preview
                  const Text(
                    'Preview',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  SizedBox(
                    height: _orientation == ShadTabsOrientation.vertical
                        ? 400
                        : 300,
                    child: ShadTabs(
                      variant: _variant,
                      size: _size,
                      orientation: _orientation,
                      tabs: _tabs,
                      onTabChanged: (index) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Switched to tab ${index + 1}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
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

class _TabContent extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _TabContent({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ShadSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: ShadTheme.of(context).primaryColor),
              const SizedBox(width: ShadSpacing.sm),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: ShadSpacing.md),
          Text(content, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: ShadSpacing.lg),
          const ShadCard(
            child: Padding(
              padding: EdgeInsets.all(ShadSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sample Content',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: ShadSpacing.sm),
                  Text(
                    'This is a sample card within the tab content. You can include any widgets here.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
