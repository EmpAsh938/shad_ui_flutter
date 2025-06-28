import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class CommandDemo extends StatefulWidget {
  const CommandDemo({super.key});

  @override
  State<CommandDemo> createState() => _CommandDemoState();
}

class _CommandDemoState extends State<CommandDemo> {
  ShadCommandVariant _variant = ShadCommandVariant.default_;
  ShadCommandSize _size = ShadCommandSize.md;
  bool _showSearch = true;
  bool _showEmptyState = true;
  String _selectedItem = '';

  final List<ShadCommandItem> _items = [
    ShadCommandItem(
      id: 'new-file',
      title: 'New File',
      subtitle: 'Create a new file',
      icon: Icons.file_copy,
      keywords: ['create', 'file', 'new'],
      onSelect: () => print('New File selected'),
    ),
    ShadCommandItem(
      id: 'open-file',
      title: 'Open File',
      subtitle: 'Open an existing file',
      icon: Icons.folder_open,
      keywords: ['open', 'file', 'existing'],
      onSelect: () => print('Open File selected'),
    ),
    ShadCommandItem(
      id: 'save',
      title: 'Save',
      subtitle: 'Save current file',
      icon: Icons.save,
      keywords: ['save', 'file', 'current'],
      onSelect: () => print('Save selected'),
    ),
    ShadCommandItem(
      id: 'save-as',
      title: 'Save As',
      subtitle: 'Save file with new name',
      icon: Icons.save_as,
      keywords: ['save', 'as', 'new name'],
      onSelect: () => print('Save As selected'),
    ),
    ShadCommandItem(
      id: 'undo',
      title: 'Undo',
      subtitle: 'Undo last action',
      icon: Icons.undo,
      keywords: ['undo', 'action', 'last'],
      onSelect: () => print('Undo selected'),
    ),
    ShadCommandItem(
      id: 'redo',
      title: 'Redo',
      subtitle: 'Redo last undone action',
      icon: Icons.redo,
      keywords: ['redo', 'action', 'undone'],
      onSelect: () => print('Redo selected'),
    ),
    ShadCommandItem(
      id: 'cut',
      title: 'Cut',
      subtitle: 'Cut selected text',
      icon: Icons.content_cut,
      keywords: ['cut', 'text', 'selected'],
      onSelect: () => print('Cut selected'),
    ),
    ShadCommandItem(
      id: 'copy',
      title: 'Copy',
      subtitle: 'Copy selected text',
      icon: Icons.content_copy,
      keywords: ['copy', 'text', 'selected'],
      onSelect: () => print('Copy selected'),
    ),
    ShadCommandItem(
      id: 'paste',
      title: 'Paste',
      subtitle: 'Paste from clipboard',
      icon: Icons.content_paste,
      keywords: ['paste', 'clipboard'],
      onSelect: () => print('Paste selected'),
    ),
    ShadCommandItem(
      id: 'find',
      title: 'Find',
      subtitle: 'Find text in document',
      icon: Icons.search,
      keywords: ['find', 'text', 'search'],
      onSelect: () => print('Find selected'),
    ),
    ShadCommandItem(
      id: 'replace',
      title: 'Replace',
      subtitle: 'Find and replace text',
      icon: Icons.find_replace,
      keywords: ['replace', 'find', 'text'],
      onSelect: () => print('Replace selected'),
    ),
    ShadCommandItem(
      id: 'settings',
      title: 'Settings',
      subtitle: 'Open application settings',
      icon: Icons.settings,
      keywords: ['settings', 'preferences', 'config'],
      onSelect: () => print('Settings selected'),
    ),
    ShadCommandItem(
      id: 'help',
      title: 'Help',
      subtitle: 'Open help documentation',
      icon: Icons.help,
      keywords: ['help', 'documentation', 'guide'],
      onSelect: () => print('Help selected'),
    ),
    ShadCommandItem(
      id: 'about',
      title: 'About',
      subtitle: 'About this application',
      icon: Icons.info,
      keywords: ['about', 'info', 'version'],
      onSelect: () => print('About selected'),
    ),
  ];

  final List<ShadCommandGroup> _groups = [
    ShadCommandGroup(
      title: 'File',
      items: [
        ShadCommandItem(
          id: 'new-file',
          title: 'New File',
          subtitle: 'Create a new file',
          icon: Icons.file_copy,
          keywords: ['create', 'file', 'new'],
          onSelect: () => print('New File selected'),
        ),
        ShadCommandItem(
          id: 'open-file',
          title: 'Open File',
          subtitle: 'Open an existing file',
          icon: Icons.folder_open,
          keywords: ['open', 'file', 'existing'],
          onSelect: () => print('Open File selected'),
        ),
        ShadCommandItem(
          id: 'save',
          title: 'Save',
          subtitle: 'Save current file',
          icon: Icons.save,
          keywords: ['save', 'file', 'current'],
          onSelect: () => print('Save selected'),
        ),
        ShadCommandItem(
          id: 'save-as',
          title: 'Save As',
          subtitle: 'Save file with new name',
          icon: Icons.save_as,
          keywords: ['save', 'as', 'new name'],
          onSelect: () => print('Save As selected'),
        ),
      ],
    ),
    ShadCommandGroup(
      title: 'Edit',
      items: [
        ShadCommandItem(
          id: 'undo',
          title: 'Undo',
          subtitle: 'Undo last action',
          icon: Icons.undo,
          keywords: ['undo', 'action', 'last'],
          onSelect: () => print('Undo selected'),
        ),
        ShadCommandItem(
          id: 'redo',
          title: 'Redo',
          subtitle: 'Redo last undone action',
          icon: Icons.redo,
          keywords: ['redo', 'action', 'undone'],
          onSelect: () => print('Redo selected'),
        ),
        ShadCommandItem(
          id: 'cut',
          title: 'Cut',
          subtitle: 'Cut selected text',
          icon: Icons.content_cut,
          keywords: ['cut', 'text', 'selected'],
          onSelect: () => print('Cut selected'),
        ),
        ShadCommandItem(
          id: 'copy',
          title: 'Copy',
          subtitle: 'Copy selected text',
          icon: Icons.content_copy,
          keywords: ['copy', 'text', 'selected'],
          onSelect: () => print('Copy selected'),
        ),
        ShadCommandItem(
          id: 'paste',
          title: 'Paste',
          subtitle: 'Paste from clipboard',
          icon: Icons.content_paste,
          keywords: ['paste', 'clipboard'],
          onSelect: () => print('Paste selected'),
        ),
      ],
    ),
    ShadCommandGroup(
      title: 'Search',
      items: [
        ShadCommandItem(
          id: 'find',
          title: 'Find',
          subtitle: 'Find text in document',
          icon: Icons.search,
          keywords: ['find', 'text', 'search'],
          onSelect: () => print('Find selected'),
        ),
        ShadCommandItem(
          id: 'replace',
          title: 'Replace',
          subtitle: 'Find and replace text',
          icon: Icons.find_replace,
          keywords: ['replace', 'find', 'text'],
          onSelect: () => print('Replace selected'),
        ),
      ],
    ),
    ShadCommandGroup(
      title: 'Help',
      items: [
        ShadCommandItem(
          id: 'settings',
          title: 'Settings',
          subtitle: 'Open application settings',
          icon: Icons.settings,
          keywords: ['settings', 'preferences', 'config'],
          onSelect: () => print('Settings selected'),
        ),
        ShadCommandItem(
          id: 'help',
          title: 'Help',
          subtitle: 'Open help documentation',
          icon: Icons.help,
          keywords: ['help', 'documentation', 'guide'],
          onSelect: () => print('Help selected'),
        ),
        ShadCommandItem(
          id: 'about',
          title: 'About',
          subtitle: 'About this application',
          icon: Icons.info,
          keywords: ['about', 'info', 'version'],
          onSelect: () => print('About selected'),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Command Demo'),
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
                      children: ShadCommandVariant.values.map((variant) {
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
                      children: ShadCommandSize.values.map((size) {
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

                    // Options
                    Text(
                      'Options:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    CheckboxListTile(
                      title: const Text('Show Search'),
                      value: _showSearch,
                      onChanged: (value) {
                        setState(() => _showSearch = value ?? true);
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Show Empty State'),
                      value: _showEmptyState,
                      onChanged: (value) {
                        setState(() => _showEmptyState = value ?? true);
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

            // Simple Command
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ShadSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simple Command',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Text(
                      'A basic command palette with search functionality.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    SizedBox(
                      height: 400,
                      child: ShadCommand(
                        items: _items,
                        variant: _variant,
                        size: _size,
                        showSearch: _showSearch,
                        showEmptyState: _showEmptyState,
                        onItemSelected: (item) {
                          setState(() => _selectedItem = item.title);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: ${item.title}')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: ShadSpacing.lg),

            // Grouped Command
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ShadSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grouped Command',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Text(
                      'Command palette with grouped items for better organization.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    SizedBox(
                      height: 400,
                      child: ShadCommand(
                        groups: _groups,
                        variant: _variant,
                        size: _size,
                        showSearch: _showSearch,
                        showEmptyState: _showEmptyState,
                        onItemSelected: (item) {
                          setState(() => _selectedItem = item.title);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: ${item.title}')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: ShadSpacing.lg),

            // Custom Command
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ShadSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Command',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: ShadSpacing.sm),
                    Text(
                      'Command palette with custom styling and colors.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    SizedBox(
                      height: 400,
                      child: ShadCommand(
                        items: [
                          ShadCommandItem(
                            id: 'custom-1',
                            title: 'Custom Item 1',
                            subtitle: 'With custom styling',
                            icon: Icons.star,
                            color: Colors.orange,
                            onSelect: () => print('Custom 1 selected'),
                          ),
                          ShadCommandItem(
                            id: 'custom-2',
                            title: 'Custom Item 2',
                            subtitle: 'With custom styling',
                            icon: Icons.favorite,
                            color: Colors.red,
                            onSelect: () => print('Custom 2 selected'),
                          ),
                          ShadCommandItem(
                            id: 'custom-3',
                            title: 'Disabled Item',
                            subtitle: 'This item is disabled',
                            icon: Icons.block,
                            isDisabled: true,
                            onSelect: () => print('This should not be called'),
                          ),
                        ],
                        variant: ShadCommandVariant.outline,
                        size: _size,
                        showSearch: _showSearch,
                        showEmptyState: _showEmptyState,
                        backgroundColor: Colors.grey[50],
                        borderColor: Colors.blue[200],
                        selectedColor: Colors.blue[600]!,
                        onItemSelected: (item) {
                          setState(() => _selectedItem = item.title);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: ${item.title}')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: ShadSpacing.lg),

            // Selected Item Display
            if (_selectedItem.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(ShadSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Selected',
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
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: ShadSpacing.sm),
                            Text(
                              _selectedItem,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
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
          ],
        ),
      ),
    );
  }
}
