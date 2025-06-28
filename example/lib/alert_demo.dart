import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class AlertDemo extends StatefulWidget {
  const AlertDemo({super.key});

  @override
  State<AlertDemo> createState() => _AlertDemoState();
}

class _AlertDemoState extends State<AlertDemo> {
  bool _showAlert1 = true;
  bool _showAlert2 = true;
  bool _showAlert3 = true;
  bool _showAlert4 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Alert Component',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.lg),

            _buildSection('Default Alert', [
              ShadAlert(
                title: 'Default Alert',
                description: 'This is a default alert message.',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Variants', [
              ShadAlert(
                title: 'Success Alert',
                description: 'Your action was completed successfully!',
                variant: ShadAlertVariant.success,
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'Warning Alert',
                description: 'Please review your input before proceeding.',
                variant: ShadAlertVariant.warning,
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'Error Alert',
                description: 'Something went wrong. Please try again.',
                variant: ShadAlertVariant.destructive,
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'Info Alert',
                description: 'Here is some useful information for you.',
                variant: ShadAlertVariant.info,
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Sizes', [
              ShadAlert(
                title: 'Small Alert',
                description: 'This is a small alert message.',
                size: ShadAlertSize.sm,
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'Medium Alert',
                description: 'This is a medium alert message.',
                size: ShadAlertSize.md,
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'Large Alert',
                description: 'This is a large alert message.',
                size: ShadAlertSize.lg,
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Custom Icons', [
              ShadAlert(
                title: 'Custom Icon Alert',
                description: 'This alert has a custom icon.',
                icon: const Icon(Icons.star),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'Notification Alert',
                description: 'You have a new notification.',
                icon: const Icon(Icons.notifications),
                variant: ShadAlertVariant.info,
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Actions', [
              ShadAlert(
                title: 'Action Required',
                description: 'Please confirm your action.',
                action: ShadButton(
                  onPressed: () => _showSnackBar('Action confirmed!'),
                  child: const Text('Confirm'),
                ),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'Multiple Actions',
                description: 'Choose an action to proceed.',
                action: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShadButton(
                      onPressed: () => _showSnackBar('Primary action!'),
                      child: const Text('Primary'),
                    ),
                    const SizedBox(width: ShadSpacing.sm),
                    ShadButton(
                      onPressed: () => _showSnackBar('Secondary action!'),
                      variant: ShadButtonVariant.outline,
                      child: const Text('Secondary'),
                    ),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Dismissible Alerts', [
              if (_showAlert1)
                ShadAlert(
                  title: 'Dismissible Alert',
                  description:
                      'You can dismiss this alert by clicking the X button.',
                  dismissible: true,
                  onDismiss: () => setState(() => _showAlert1 = false),
                ),
              const SizedBox(height: ShadSpacing.md),
              if (_showAlert2)
                ShadAlert(
                  title: 'Dismissible Success',
                  description: 'This success alert can be dismissed.',
                  variant: ShadAlertVariant.success,
                  dismissible: true,
                  onDismiss: () => setState(() => _showAlert2 = false),
                ),
              const SizedBox(height: ShadSpacing.md),
              if (_showAlert3)
                ShadAlert(
                  title: 'Dismissible Warning',
                  description: 'This warning alert can be dismissed.',
                  variant: ShadAlertVariant.warning,
                  dismissible: true,
                  onDismiss: () => setState(() => _showAlert3 = false),
                ),
              const SizedBox(height: ShadSpacing.md),
              if (_showAlert4)
                ShadAlert(
                  title: 'Dismissible Error',
                  description: 'This error alert can be dismissed.',
                  variant: ShadAlertVariant.destructive,
                  dismissible: true,
                  onDismiss: () => setState(() => _showAlert4 = false),
                ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Title Only', [
              ShadAlert(title: 'This is an alert with only a title.'),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Description Only', [
              ShadAlert(
                description: 'This is an alert with only a description.',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Complex Examples', [
              ShadAlert(
                title: 'System Maintenance',
                description:
                    'Scheduled maintenance will occur on Sunday at 2:00 AM. The system will be unavailable for approximately 2 hours.',
                variant: ShadAlertVariant.warning,
                icon: const Icon(Icons.build),
                action: ShadButton(
                  onPressed: () => _showSnackBar('Maintenance details opened!'),
                  variant: ShadButtonVariant.outline,
                  child: const Text('View Details'),
                ),
                dismissible: true,
                onDismiss: () => _showSnackBar('Alert dismissed'),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadAlert(
                title: 'New Feature Available',
                description:
                    'We\'ve added new collaboration features to improve your workflow.',
                variant: ShadAlertVariant.success,
                icon: const Icon(Icons.new_releases),
                action: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShadButton(
                      onPressed: () => _showSnackBar('Feature tour started!'),
                      child: const Text('Take Tour'),
                    ),
                    const SizedBox(width: ShadSpacing.sm),
                    ShadButton(
                      onPressed: () => _showSnackBar('Feature dismissed'),
                      variant: ShadButtonVariant.ghost,
                      child: const Text('Dismiss'),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: ShadTypography.fontSizeLg,
            fontWeight: ShadTypography.fontWeightBold,
          ),
        ),
        const SizedBox(height: ShadSpacing.md),
        ...children,
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
