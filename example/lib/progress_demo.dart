import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class ProgressDemo extends StatefulWidget {
  const ProgressDemo({super.key});

  @override
  State<ProgressDemo> createState() => _ProgressDemoState();
}

class _ProgressDemoState extends State<ProgressDemo>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animationController.addListener(() {
      setState(() {
        _progressValue = _animationController.value * 100;
      });
    });

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress Variants',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Default variant
            const Text(
              'Default Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              label: 'Default Progress',
              showValue: true,
            ),
            const SizedBox(height: 24),

            // Success variant
            const Text(
              'Success Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              variant: ShadProgressVariant.success,
              label: 'Success Progress',
              showValue: true,
            ),
            const SizedBox(height: 24),

            // Error variant
            const Text(
              'Error Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              variant: ShadProgressVariant.destructive,
              label: 'Error Progress',
              showValue: true,
            ),
            const SizedBox(height: 24),

            // Warning variant
            const Text(
              'Warning Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              variant: ShadProgressVariant.warning,
              label: 'Warning Progress',
              showValue: true,
            ),
            const SizedBox(height: 24),

            // Info variant
            const Text(
              'Info Variant',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              variant: ShadProgressVariant.info,
              label: 'Info Progress',
              showValue: true,
            ),
            const SizedBox(height: 32),

            const Text(
              'Progress Sizes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Small size
            const Text(
              'Small Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              size: ShadProgressSize.sm,
              label: 'Small Progress',
              showValue: true,
            ),
            const SizedBox(height: 16),

            // Medium size
            const Text(
              'Medium Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              size: ShadProgressSize.md,
              label: 'Medium Progress',
              showValue: true,
            ),
            const SizedBox(height: 16),

            // Large size
            const Text(
              'Large Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              size: ShadProgressSize.lg,
              label: 'Large Progress',
              showValue: true,
            ),
            const SizedBox(height: 32),

            const Text(
              'Progress Types',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Linear progress
            const Text(
              'Linear Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              type: ShadProgressType.linear,
              label: 'Linear Progress',
              showValue: true,
            ),
            const SizedBox(height: 24),

            // Circular progress
            const Text(
              'Circular Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              type: ShadProgressType.circular,
              label: 'Circular Progress',
              showValue: true,
            ),
            const SizedBox(height: 32),

            const Text(
              'Progress States',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Without label
            const Text(
              'Without Label',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(value: _progressValue, showValue: true),
            const SizedBox(height: 16),

            // Without value
            const Text(
              'Without Value Display',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue,
              label: 'Progress without value',
            ),
            const SizedBox(height: 16),

            // Custom max value
            const Text(
              'Custom Max Value (200)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ShadProgress(
              value: _progressValue * 2,
              maxValue: 200,
              label: 'Custom Max Progress',
              showValue: true,
            ),
            const SizedBox(height: 32),

            const Text(
              'Static Progress Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 25% progress
            const Text(
              '25% Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ShadProgress(
              value: 25,
              label: 'Quarter Complete',
              showValue: true,
            ),
            const SizedBox(height: 16),

            // 50% progress
            const Text(
              '50% Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ShadProgress(
              value: 50,
              label: 'Halfway There',
              showValue: true,
            ),
            const SizedBox(height: 16),

            // 75% progress
            const Text(
              '75% Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ShadProgress(
              value: 75,
              label: 'Almost Done',
              showValue: true,
            ),
            const SizedBox(height: 16),

            // 100% progress
            const Text(
              '100% Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ShadProgress(
              value: 100,
              label: 'Complete!',
              showValue: true,
              variant: ShadProgressVariant.success,
            ),
            const SizedBox(height: 32),

            const Text(
              'Circular Progress Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '25%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const ShadProgress(
                        value: 25,
                        type: ShadProgressType.circular,
                        showValue: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '50%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const ShadProgress(
                        value: 50,
                        type: ShadProgressType.circular,
                        showValue: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '75%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const ShadProgress(
                        value: 75,
                        type: ShadProgressType.circular,
                        showValue: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '100%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const ShadProgress(
                        value: 100,
                        type: ShadProgressType.circular,
                        showValue: true,
                        variant: ShadProgressVariant.success,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              'Progress with Different Variants',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const ShadProgress(
              value: 30,
              variant: ShadProgressVariant.default_,
              label: 'Default Variant',
              showValue: true,
            ),
            const SizedBox(height: 16),

            const ShadProgress(
              value: 60,
              variant: ShadProgressVariant.success,
              label: 'Success Variant',
              showValue: true,
            ),
            const SizedBox(height: 16),

            const ShadProgress(
              value: 45,
              variant: ShadProgressVariant.warning,
              label: 'Warning Variant',
              showValue: true,
            ),
            const SizedBox(height: 16),

            const ShadProgress(
              value: 80,
              variant: ShadProgressVariant.destructive,
              label: 'Error Variant',
              showValue: true,
            ),
            const SizedBox(height: 16),

            const ShadProgress(
              value: 70,
              variant: ShadProgressVariant.info,
              label: 'Info Variant',
              showValue: true,
            ),
          ],
        ),
      ),
    );
  }
}
