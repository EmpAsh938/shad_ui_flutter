import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class DialogDemo extends StatefulWidget {
  const DialogDemo({super.key});

  @override
  State<DialogDemo> createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dialog Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dialog Variants',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Default variant
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Default Dialog',
                  description: 'This is a default dialog with some content.',
                  content: const Text('This is the dialog content area.'),
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Cancel'),
                    ),
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Confirm'),
                    ),
                  ],
                );
              },
              child: const Text('Show Default Dialog'),
            ),
            const SizedBox(height: 12),

            // Success variant
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Success!',
                  description: 'Operation completed successfully.',
                  variant: ShadDialogVariant.success,
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
              child: const Text('Show Success Dialog'),
            ),
            const SizedBox(height: 12),

            // Error variant
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Error!',
                  description: 'Something went wrong. Please try again.',
                  variant: ShadDialogVariant.destructive,
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Cancel'),
                    ),
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.destructive,
                      child: const Text('Proceed'),
                    ),
                  ],
                );
              },
              child: const Text('Show Error Dialog'),
            ),
            const SizedBox(height: 12),

            // Warning variant
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Warning!',
                  description: 'Are you sure you want to proceed?',
                  variant: ShadDialogVariant.warning,
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Cancel'),
                    ),
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.destructive,
                      child: const Text('Proceed'),
                    ),
                  ],
                );
              },
              child: const Text('Show Warning Dialog'),
            ),
            const SizedBox(height: 12),

            // Info variant
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Information',
                  description: 'Here is some important information.',
                  variant: ShadDialogVariant.info,
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Got it'),
                    ),
                  ],
                );
              },
              child: const Text('Show Info Dialog'),
            ),
            const SizedBox(height: 32),

            const Text(
              'Dialog Sizes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Small size
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Small Dialog',
                  description: 'This is a small dialog.',
                  size: ShadDialogSize.sm,
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      size: ShadButtonSize.sm,
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
              child: const Text('Show Small Dialog'),
            ),
            const SizedBox(height: 12),

            // Medium size
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Medium Dialog',
                  description: 'This is a medium dialog with more content.',
                  size: ShadDialogSize.md,
                  content: const Text(
                    'This dialog has additional content in the body.',
                  ),
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Cancel'),
                    ),
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Confirm'),
                    ),
                  ],
                );
              },
              child: const Text('Show Medium Dialog'),
            ),
            const SizedBox(height: 12),

            // Large size
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Large Dialog',
                  description: 'This is a large dialog with extensive content.',
                  size: ShadDialogSize.lg,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'This is a large dialog with more space for content.',
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'You can include multiple paragraphs, forms, or other widgets here.',
                      ),
                      const SizedBox(height: 16),
                      const ShadInput(
                        hint: 'Enter some text',
                        label: 'Input Field',
                      ),
                    ],
                  ),
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Cancel'),
                    ),
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Save'),
                    ),
                  ],
                );
              },
              child: const Text('Show Large Dialog'),
            ),
            const SizedBox(height: 12),

            // Extra large size
            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Extra Large Dialog',
                  description:
                      'This is an extra large dialog for complex content.',
                  size: ShadDialogSize.xl,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'This dialog provides maximum space for complex content.',
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Perfect for forms, data tables, or detailed information.',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: const ShadInput(
                              hint: 'First Name',
                              label: 'First Name',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: const ShadInput(
                              hint: 'Last Name',
                              label: 'Last Name',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const ShadInput(hint: 'Email', label: 'Email'),
                      const SizedBox(height: 16),
                      const ShadTextarea(
                        hint: 'Additional notes...',
                        label: 'Notes',
                      ),
                    ],
                  ),
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Cancel'),
                    ),
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Submit'),
                    ),
                  ],
                );
              },
              child: const Text('Show Extra Large Dialog'),
            ),
            const SizedBox(height: 32),

            const Text(
              'Dialog with Custom Icon',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Custom Icon Dialog',
                  description: 'This dialog has a custom icon.',
                  icon: const Icon(Icons.star, color: Colors.amber),
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
              child: const Text('Show Dialog with Custom Icon'),
            ),
            const SizedBox(height: 32),

            const Text(
              'Non-dismissible Dialog',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ShadButton(
              onPressed: () {
                ShadDialogManager.show(
                  context,
                  title: 'Non-dismissible Dialog',
                  description:
                      'This dialog cannot be dismissed by tapping outside.',
                  dismissible: false,
                  actions: [
                    ShadButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('I Understand'),
                    ),
                  ],
                );
              },
              child: const Text('Show Non-dismissible Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
