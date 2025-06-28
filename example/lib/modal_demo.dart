import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class ModalDemo extends StatefulWidget {
  const ModalDemo({super.key});

  @override
  State<ModalDemo> createState() => _ModalDemoState();
}

class _ModalDemoState extends State<ModalDemo> {
  ShadModalVariant _variant = ShadModalVariant.default_;
  ShadModalSize _size = ShadModalSize.md;
  ShadModalPosition _position = ShadModalPosition.center;
  bool _dismissible = true;
  bool _showBackdrop = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modal Demo'),
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
                children: ShadModalVariant.values.map((variant) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      variant: ShadButtonVariant.outline,
                      onPressed: () => _showModal(context, variant: variant),
                      child: Text('Show ${variant.name} Modal'),
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
                children: ShadModalSize.values.map((size) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      variant: ShadButtonVariant.outline,
                      onPressed: () => _showModal(context, size: size),
                      child: Text('Show ${size.name} Modal'),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Positions
            _buildSection(
              'Positions',
              Column(
                children: ShadModalPosition.values.map((position) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      variant: ShadButtonVariant.outline,
                      onPressed: () => _showModal(context, position: position),
                      child: Text('Show ${position.name} Modal'),
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
                  // Simple modal
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      onPressed: () => _showSimpleModal(context),
                      child: const Text('Simple Modal'),
                    ),
                  ),

                  // Form modal
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      onPressed: () => _showFormModal(context),
                      child: const Text('Form Modal'),
                    ),
                  ),

                  // Confirmation modal
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      onPressed: () => _showConfirmationModal(context),
                      child: const Text('Confirmation Modal'),
                    ),
                  ),

                  // Full screen modal
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      onPressed: () => _showFullScreenModal(context),
                      child: const Text('Full Screen Modal'),
                    ),
                  ),

                  // Custom modal
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: ShadButton(
                      onPressed: () => _showCustomModal(context),
                      child: const Text('Custom Modal'),
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
                      DropdownButton<ShadModalVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadModalVariant.values.map((variant) {
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
                      DropdownButton<ShadModalSize>(
                        value: _size,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _size = value);
                          }
                        },
                        items: ShadModalSize.values.map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(size.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Position selector
                  Row(
                    children: [
                      const Text('Position: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadModalPosition>(
                        value: _position,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _position = value);
                          }
                        },
                        items: ShadModalPosition.values.map((position) {
                          return DropdownMenuItem(
                            value: position,
                            child: Text(position.name),
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
                        value: _dismissible,
                        onChanged: (value) =>
                            setState(() => _dismissible = value ?? false),
                      ),
                      const Text('Dismissible'),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _showBackdrop,
                        onChanged: (value) =>
                            setState(() => _showBackdrop = value ?? false),
                      ),
                      const Text('Show Backdrop'),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Preview
                  ShadButton(
                    onPressed: () => _showModal(
                      context,
                      variant: _variant,
                      size: _size,
                      position: _position,
                      dismissible: _dismissible,
                      showBackdrop: _showBackdrop,
                    ),
                    child: const Text('Show Preview Modal'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModal(
    BuildContext context, {
    ShadModalVariant? variant,
    ShadModalSize? size,
    ShadModalPosition? position,
    bool? dismissible,
    bool? showBackdrop,
  }) {
    ShadModalHelper.showModal(
      context,
      variant: variant ?? _variant,
      size: size ?? _size,
      position: position ?? _position,
      title: Text(
        '${variant?.name ?? _variant.name} Modal',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This is a ${size?.name ?? _size.name} modal positioned at ${position?.name ?? _position.name}.',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: ShadSpacing.md),
          const Text(
            'You can customize the content, actions, and styling to match your needs.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: ShadSpacing.lg),
          const ShadCard(
            child: Padding(
              padding: EdgeInsets.all(ShadSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sample Content',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: ShadSpacing.sm),
                  Text(
                    'This card demonstrates how you can include any widgets in the modal content.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        ShadButton(
          variant: ShadButtonVariant.outline,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Action confirmed!')));
          },
          child: const Text('Confirm'),
        ),
      ],
      dismissible: dismissible ?? _dismissible,
      showBackdrop: showBackdrop ?? _showBackdrop,
    );
  }

  void _showSimpleModal(BuildContext context) {
    ShadModalHelper.showModal(
      context,
      title: const Text('Simple Modal'),
      content: const Text('This is a simple modal with basic content.'),
      actions: [
        ShadButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  void _showFormModal(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    ShadModalHelper.showModal(
      context,
      size: ShadModalSize.lg,
      title: const Text('User Registration'),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShadInput(
              label: 'Name',
              hint: 'Enter your name',
              controller: nameController,
            ),
            const SizedBox(height: ShadSpacing.md),
            ShadInput(
              label: 'Email',
              hint: 'Enter your email',
              controller: emailController,
            ),
            const SizedBox(height: ShadSpacing.md),
            const Text(
              'This form demonstrates how you can include complex widgets like forms in modals.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      actions: [
        ShadButton(
          variant: ShadButtonVariant.outline,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(
          onPressed: () {
            // Manual validation
            if (nameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter your name')),
              );
              return;
            }
            if (emailController.text.isEmpty ||
                !emailController.text.contains('@')) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a valid email')),
              );
              return;
            }
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome, ${nameController.text}!')),
            );
          },
          child: const Text('Register'),
        ),
      ],
    );
  }

  void _showConfirmationModal(BuildContext context) {
    ShadModalHelper.showModal(
      context,
      variant: ShadModalVariant.destructive,
      title: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: ShadSpacing.sm),
          Text('Confirm Deletion'),
        ],
      ),
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to delete this item?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: ShadSpacing.sm),
          Text(
            'This action cannot be undone.',
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        ],
      ),
      actions: [
        ShadButton(
          variant: ShadButtonVariant.outline,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(
          variant: ShadButtonVariant.destructive,
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item deleted successfully'),
                backgroundColor: Colors.red,
              ),
            );
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  void _showFullScreenModal(BuildContext context) {
    ShadModalHelper.showModal(
      context,
      size: ShadModalSize.full,
      title: const Text('Full Screen Modal'),
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This is a full-screen modal that takes up the entire screen.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: ShadSpacing.lg),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fullscreen, size: 64, color: Colors.grey),
                  SizedBox(height: ShadSpacing.md),
                  Text(
                    'Full Screen Content',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: ShadSpacing.sm),
                  Text(
                    'Perfect for complex forms, detailed views, or immersive experiences.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        ShadButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  void _showCustomModal(BuildContext context) {
    ShadModalHelper.showModal(
      context,
      variant: ShadModalVariant.info,
      size: ShadModalSize.lg,
      backgroundColor: Colors.blue.shade50,
      borderColor: Colors.blue,
      borderRadius: BorderRadius.circular(20),
      title: const Row(
        children: [
          Icon(Icons.info, color: Colors.blue),
          SizedBox(width: ShadSpacing.sm),
          Text('Custom Styled Modal'),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This modal demonstrates custom styling with:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: ShadSpacing.md),
          const Text('• Custom background color'),
          const Text('• Custom border color'),
          const Text('• Custom border radius'),
          const Text('• Custom icon in title'),
          const SizedBox(height: ShadSpacing.lg),
          Container(
            padding: const EdgeInsets.all(ShadSpacing.md),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ShadRadius.md),
            ),
            child: const Text(
              'Custom styled content area',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      actions: [
        ShadButton(
          variant: ShadButtonVariant.outline,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Custom action completed!'),
                backgroundColor: Colors.blue,
              ),
            );
          },
          child: const Text('Custom Action'),
        ),
      ],
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
