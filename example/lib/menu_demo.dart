import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class MenuDemo extends StatefulWidget {
  const MenuDemo({super.key});

  @override
  State<MenuDemo> createState() => _MenuDemoState();
}

class _MenuDemoState extends State<MenuDemo> {
  ShadMenuVariant _variant = ShadMenuVariant.default_;
  ShadMenuSize _size = ShadMenuSize.md;
  ShadMenuTrigger _triggerType = ShadMenuTrigger.click;
  bool _showArrow = true;

  final List<ShadMenuItem> _menuItems = [
    const ShadMenuItem(
      label: 'New File',
      icon: Icons.add,
      shortcut: 'Ctrl+N',
      onTap: _handleNewFile,
    ),
    const ShadMenuItem(
      label: 'Open File',
      icon: Icons.folder_open,
      shortcut: 'Ctrl+O',
      onTap: _handleOpenFile,
    ),
    const ShadMenuItem(
      label: 'Save',
      icon: Icons.save,
      shortcut: 'Ctrl+S',
      onTap: _handleSave,
    ),
    const ShadMenuItem(label: '', isSeparator: true),
    const ShadMenuItem(
      label: 'Edit',
      icon: Icons.edit,
      subItems: [
        ShadMenuItem(label: 'Cut', shortcut: 'Ctrl+X'),
        ShadMenuItem(label: 'Copy', shortcut: 'Ctrl+C'),
        ShadMenuItem(label: 'Paste', shortcut: 'Ctrl+V'),
      ],
    ),
    const ShadMenuItem(
      label: 'View',
      icon: Icons.visibility,
      subItems: [
        ShadMenuItem(label: 'Zoom In', shortcut: 'Ctrl++'),
        ShadMenuItem(label: 'Zoom Out', shortcut: 'Ctrl+-'),
        ShadMenuItem(label: 'Reset Zoom', shortcut: 'Ctrl+0'),
      ],
    ),
    const ShadMenuItem(label: '', isSeparator: true),
    const ShadMenuItem(
      label: 'Settings',
      icon: Icons.settings,
      onTap: _handleSettings,
    ),
    const ShadMenuItem(label: 'Help', icon: Icons.help, onTap: _handleHelp),
    const ShadMenuItem(
      label: 'Disabled Item',
      icon: Icons.block,
      isDisabled: true,
    ),
  ];

  static void _handleNewFile() {
    // Implementation would go here
  }

  static void _handleOpenFile() {
    // Implementation would go here
  }

  static void _handleSave() {
    // Implementation would go here
  }

  static void _handleSettings() {
    // Implementation would go here
  }

  static void _handleHelp() {
    // Implementation would go here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Demo'),
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
                children: ShadMenuVariant.values.map((variant) {
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
                        ShadMenu(
                          trigger: ShadButton(
                            variant: ShadButtonVariant.outline,
                            onPressed: () {},
                            child: Text('${variant.name} Menu'),
                          ),
                          items: _menuItems,
                          variant: variant,
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
                children: ShadMenuSize.values.map((size) {
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
                        ShadMenu(
                          trigger: ShadButton(
                            variant: ShadButtonVariant.outline,
                            onPressed: () {},
                            child: Text('${size.name} Menu'),
                          ),
                          items: _menuItems,
                          size: size,
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
                  // Click trigger
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Click Trigger',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadMenu(
                          trigger: ShadButton(
                            onPressed: () {},
                            child: const Text('Click to Open'),
                          ),
                          items: _menuItems,
                          triggerType: ShadMenuTrigger.click,
                        ),
                      ],
                    ),
                  ),

                  // Hover trigger
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hover Trigger',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadMenu(
                          trigger: ShadButton(
                            variant: ShadButtonVariant.ghost,
                            onPressed: () {},
                            child: const Text('Hover to Open'),
                          ),
                          items: _menuItems,
                          triggerType: ShadMenuTrigger.hover,
                        ),
                      ],
                    ),
                  ),

                  // Custom trigger
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Custom Trigger',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadMenu(
                          trigger: Container(
                            padding: const EdgeInsets.all(ShadSpacing.md),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(
                                ShadRadius.md,
                              ),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.menu, color: Colors.blue),
                                SizedBox(width: ShadSpacing.sm),
                                Text(
                                  'Custom Trigger',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                          items: _menuItems,
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
                        ShadMenu(
                          trigger: ShadButton(
                            variant: ShadButtonVariant.outline,
                            onPressed: () {},
                            child: const Text('Styled Menu'),
                          ),
                          items: _menuItems,
                          backgroundColor: Colors.purple.shade50,
                          borderColor: Colors.purple,
                          textColor: Colors.purple.shade800,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                  ),

                  // Simple menu
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Simple Menu',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadMenu(
                          trigger: ShadButton(
                            variant: ShadButtonVariant.ghost,
                            onPressed: () {},
                            child: const Text('Simple'),
                          ),
                          items: const [
                            ShadMenuItem(
                              label: 'Option 1',
                              onTap: _handleNewFile,
                            ),
                            ShadMenuItem(
                              label: 'Option 2',
                              onTap: _handleOpenFile,
                            ),
                            ShadMenuItem(label: 'Option 3', onTap: _handleSave),
                          ],
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
                      DropdownButton<ShadMenuVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadMenuVariant.values.map((variant) {
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
                      DropdownButton<ShadMenuSize>(
                        value: _size,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _size = value);
                          }
                        },
                        items: ShadMenuSize.values.map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(size.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Trigger type selector
                  Row(
                    children: [
                      const Text('Trigger: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadMenuTrigger>(
                        value: _triggerType,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _triggerType = value);
                          }
                        },
                        items: ShadMenuTrigger.values.map((trigger) {
                          return DropdownMenuItem(
                            value: trigger,
                            child: Text(trigger.name),
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
                        value: _showArrow,
                        onChanged: (value) =>
                            setState(() => _showArrow = value ?? false),
                      ),
                      const Text('Show Arrow'),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Preview
                  const Text(
                    'Preview',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  ShadMenu(
                    trigger: ShadButton(
                      variant: ShadButtonVariant.outline,
                      onPressed: () {},
                      child: const Text('Preview Menu'),
                    ),
                    items: _menuItems,
                    variant: _variant,
                    size: _size,
                    triggerType: _triggerType,
                    showArrow: _showArrow,
                    onOpen: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Menu opened')),
                      );
                    },
                    onClose: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Menu closed')),
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
