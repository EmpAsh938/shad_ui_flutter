import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class ToastDemo extends StatefulWidget {
  const ToastDemo({super.key});

  @override
  State<ToastDemo> createState() => _ToastDemoState();
}

class _ToastDemoState extends State<ToastDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Toast Variants',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Default variant
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Default Toast',
                  description: 'This is a default toast message',
                  variant: ShadToastVariant.default_,
                );
              },
              child: const Text('Show Default Toast'),
            ),
            const SizedBox(height: 12),

            // Success variant
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Success!',
                  description: 'Operation completed successfully',
                  variant: ShadToastVariant.success,
                );
              },
              child: const Text('Show Success Toast'),
            ),
            const SizedBox(height: 12),

            // Error variant
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Error!',
                  description: 'Something went wrong',
                  variant: ShadToastVariant.destructive,
                );
              },
              child: const Text('Show Error Toast'),
            ),
            const SizedBox(height: 12),

            // Warning variant
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Warning!',
                  description: 'Please check your input',
                  variant: ShadToastVariant.warning,
                );
              },
              child: const Text('Show Warning Toast'),
            ),
            const SizedBox(height: 12),

            // Info variant
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Info',
                  description: 'Here is some information',
                  variant: ShadToastVariant.info,
                );
              },
              child: const Text('Show Info Toast'),
            ),
            const SizedBox(height: 32),

            const Text(
              'Toast Sizes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Small size
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Small Toast',
                  description: 'This is a small toast',
                  size: ShadToastSize.sm,
                );
              },
              child: const Text('Show Small Toast'),
            ),
            const SizedBox(height: 12),

            // Medium size
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Medium Toast',
                  description: 'This is a medium toast',
                  size: ShadToastSize.md,
                );
              },
              child: const Text('Show Medium Toast'),
            ),
            const SizedBox(height: 12),

            // Large size
            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Large Toast',
                  description: 'This is a large toast with more content',
                  size: ShadToastSize.lg,
                );
              },
              child: const Text('Show Large Toast'),
            ),
            const SizedBox(height: 32),

            const Text(
              'Toast Positions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Top positions
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    onPressed: () {
                      ShadToastManager.show(
                        context,
                        title: 'Top Left',
                        description: 'Positioned at top left',
                        position: ShadToastPosition.topLeft,
                      );
                    },
                    child: const Text('Top Left'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadButton(
                    onPressed: () {
                      ShadToastManager.show(
                        context,
                        title: 'Top Center',
                        description: 'Positioned at top center',
                        position: ShadToastPosition.topCenter,
                      );
                    },
                    child: const Text('Top Center'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadButton(
                    onPressed: () {
                      ShadToastManager.show(
                        context,
                        title: 'Top Right',
                        description: 'Positioned at top right',
                        position: ShadToastPosition.topRight,
                      );
                    },
                    child: const Text('Top Right'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Bottom positions
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    onPressed: () {
                      ShadToastManager.show(
                        context,
                        title: 'Bottom Left',
                        description: 'Positioned at bottom left',
                        position: ShadToastPosition.bottomLeft,
                      );
                    },
                    child: const Text('Bottom Left'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadButton(
                    onPressed: () {
                      ShadToastManager.show(
                        context,
                        title: 'Bottom Center',
                        description: 'Positioned at bottom center',
                        position: ShadToastPosition.bottomCenter,
                      );
                    },
                    child: const Text('Bottom Center'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadButton(
                    onPressed: () {
                      ShadToastManager.show(
                        context,
                        title: 'Bottom Right',
                        description: 'Positioned at bottom right',
                        position: ShadToastPosition.bottomRight,
                      );
                    },
                    child: const Text('Bottom Right'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              'Toast with Actions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Toast with Actions',
                  description: 'This toast has action buttons',
                  actions: [
                    ShadButton(
                      onPressed: () {
                        // Handle action
                      },
                      size: ShadButtonSize.sm,
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Undo'),
                    ),
                    ShadButton(
                      onPressed: () {
                        // Handle action
                      },
                      size: ShadButtonSize.sm,
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Dismiss'),
                    ),
                  ],
                );
              },
              child: const Text('Show Toast with Actions'),
            ),
            const SizedBox(height: 32),

            const Text(
              'Toast with Custom Icon',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Custom Icon Toast',
                  description: 'This toast has a custom icon',
                  icon: const Icon(Icons.star, color: Colors.amber),
                );
              },
              child: const Text('Show Toast with Custom Icon'),
            ),
            const SizedBox(height: 32),

            const Text(
              'Non-dismissible Toast',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ShadButton(
              onPressed: () {
                ShadToastManager.show(
                  context,
                  title: 'Non-dismissible',
                  description: 'This toast cannot be dismissed',
                  dismissible: false,
                  duration: const Duration(seconds: 10),
                );
              },
              child: const Text('Show Non-dismissible Toast'),
            ),
          ],
        ),
      ),
    );
  }
}
