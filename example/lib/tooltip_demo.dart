import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class TooltipDemo extends StatefulWidget {
  const TooltipDemo({super.key});

  @override
  State<TooltipDemo> createState() => _TooltipDemoState();
}

class _TooltipDemoState extends State<TooltipDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tooltip Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tooltip Variants',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Default variant
            ShadTooltip(
              message: 'This is a default tooltip',
              child: const ShadButton(
                onPressed: null,
                child: Text('Default Tooltip'),
              ),
            ),
            const SizedBox(height: 12),

            // Success variant
            ShadTooltip(
              message: 'Operation completed successfully!',
              variant: ShadTooltipVariant.success,
              child: const ShadButton(
                onPressed: null,
                child: Text('Success Tooltip'),
              ),
            ),
            const SizedBox(height: 12),

            // Error variant
            ShadTooltip(
              message: 'Something went wrong!',
              variant: ShadTooltipVariant.destructive,
              child: const ShadButton(
                onPressed: null,
                child: Text('Error Tooltip'),
              ),
            ),
            const SizedBox(height: 12),

            // Warning variant
            ShadTooltip(
              message: 'Please check your input!',
              variant: ShadTooltipVariant.warning,
              child: const ShadButton(
                onPressed: null,
                child: Text('Warning Tooltip'),
              ),
            ),
            const SizedBox(height: 12),

            // Info variant
            ShadTooltip(
              message: 'Here is some helpful information',
              variant: ShadTooltipVariant.info,
              child: const ShadButton(
                onPressed: null,
                child: Text('Info Tooltip'),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Tooltip Sizes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Small size
            ShadTooltip(
              message: 'Small tooltip with less text',
              size: ShadTooltipSize.sm,
              child: const ShadButton(
                onPressed: null,
                size: ShadButtonSize.sm,
                child: Text('Small Tooltip'),
              ),
            ),
            const SizedBox(height: 12),

            // Medium size
            ShadTooltip(
              message: 'Medium tooltip with standard text',
              size: ShadTooltipSize.md,
              child: const ShadButton(
                onPressed: null,
                child: Text('Medium Tooltip'),
              ),
            ),
            const SizedBox(height: 12),

            // Large size
            ShadTooltip(
              message:
                  'Large tooltip with more detailed information and longer text content',
              size: ShadTooltipSize.lg,
              child: const ShadButton(
                onPressed: null,
                size: ShadButtonSize.lg,
                child: Text('Large Tooltip'),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Tooltip Positions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Top positions
            Row(
              children: [
                Expanded(
                  child: ShadTooltip(
                    message: 'Top Left',
                    position: ShadTooltipPosition.topLeft,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Top Left'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadTooltip(
                    message: 'Top Center',
                    position: ShadTooltipPosition.top,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Top'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadTooltip(
                    message: 'Top Right',
                    position: ShadTooltipPosition.topRight,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Top Right'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Middle positions
            Row(
              children: [
                Expanded(
                  child: ShadTooltip(
                    message: 'Left',
                    position: ShadTooltipPosition.left,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Left'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: const Text('Hover around'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadTooltip(
                    message: 'Right',
                    position: ShadTooltipPosition.right,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Right'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Bottom positions
            Row(
              children: [
                Expanded(
                  child: ShadTooltip(
                    message: 'Bottom Left',
                    position: ShadTooltipPosition.bottomLeft,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Bottom Left'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadTooltip(
                    message: 'Bottom Center',
                    position: ShadTooltipPosition.bottom,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Bottom'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ShadTooltip(
                    message: 'Bottom Right',
                    position: ShadTooltipPosition.bottomRight,
                    child: const ShadButton(
                      onPressed: null,
                      child: Text('Bottom Right'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              'Tooltip with Custom Duration',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ShadTooltip(
              message: 'This tooltip shows for 5 seconds',
              showDuration: const Duration(seconds: 5),
              child: const ShadButton(
                onPressed: null,
                child: Text('Long Duration Tooltip'),
              ),
            ),
            const SizedBox(height: 12),

            ShadTooltip(
              message: 'This tooltip hides quickly',
              showDuration: const Duration(milliseconds: 500),
              hideDuration: const Duration(milliseconds: 100),
              child: const ShadButton(
                onPressed: null,
                child: Text('Quick Tooltip'),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Tooltip without Arrow',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ShadTooltip(
              message: 'This tooltip has no arrow',
              showArrow: false,
              child: const ShadButton(
                onPressed: null,
                child: Text('No Arrow Tooltip'),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Tooltip on Different Elements',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Icon with tooltip
            ShadTooltip(
              message: 'Click to refresh',
              child: const Icon(Icons.refresh, size: 32, color: Colors.blue),
            ),
            const SizedBox(height: 12),

            // Text with tooltip
            ShadTooltip(
              message: 'This is a helpful hint',
              child: const Text(
                'Hover over this text',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Card with tooltip
            ShadTooltip(
              message: 'This card contains important information',
              child: const ShadCard(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Card with Tooltip'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
