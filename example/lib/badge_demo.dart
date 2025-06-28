import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class BadgeDemo extends StatefulWidget {
  const BadgeDemo({super.key});

  @override
  State<BadgeDemo> createState() => _BadgeDemoState();
}

class _BadgeDemoState extends State<BadgeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Badge Component',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.lg),

            // Variants
            _buildSection('Variants', [
              Row(
                children: [
                  ShadBadge(text: 'Default'),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Secondary',
                    variant: ShadBadgeVariant.secondary,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Destructive',
                    variant: ShadBadgeVariant.destructive,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(text: 'Outline', variant: ShadBadgeVariant.outline),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(text: 'Ghost', variant: ShadBadgeVariant.ghost),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Sizes
            _buildSection('Sizes', [
              Row(
                children: [
                  ShadBadge(text: 'Small', size: ShadBadgeSize.sm),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(text: 'Medium', size: ShadBadgeSize.md),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(text: 'Large', size: ShadBadgeSize.lg),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Shapes
            _buildSection('Shapes', [
              Row(
                children: [
                  ShadBadge(text: 'Rounded', shape: ShadBadgeShape.rounded),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(text: 'Pill', shape: ShadBadgeShape.pill),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(text: 'Square', shape: ShadBadgeShape.square),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Badges with Icons
            _buildSection('Badges with Icons', [
              Row(
                children: [
                  ShadBadge(
                    text: 'Success',
                    icon: const Icon(Icons.check, size: 12),
                    variant: ShadBadgeVariant.default_,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Warning',
                    icon: const Icon(Icons.warning, size: 12),
                    variant: ShadBadgeVariant.secondary,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Error',
                    icon: const Icon(Icons.error, size: 12),
                    variant: ShadBadgeVariant.destructive,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Info',
                    icon: const Icon(Icons.info, size: 12),
                    variant: ShadBadgeVariant.outline,
                  ),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Badges with Dots
            _buildSection('Badges with Dots', [
              Row(
                children: [
                  ShadBadge(
                    text: 'Online',
                    showDot: true,
                    variant: ShadBadgeVariant.default_,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Away',
                    showDot: true,
                    dotColor: Colors.orange,
                    variant: ShadBadgeVariant.secondary,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Offline',
                    showDot: true,
                    dotColor: Colors.grey,
                    variant: ShadBadgeVariant.outline,
                  ),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Disabled Badges
            _buildSection('Disabled Badges', [
              Row(
                children: [
                  ShadBadge(text: 'Disabled', disabled: true),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Disabled',
                    disabled: true,
                    variant: ShadBadgeVariant.outline,
                  ),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Custom Styling
            _buildSection('Custom Styling', [
              Row(
                children: [
                  ShadBadge(
                    text: 'Custom',
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                    borderColor: Colors.purple.shade700,
                    borderWidth: 2,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    text: 'Gradient',
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    borderRadius: BorderRadius.circular(ShadRadius.full),
                  ),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Badge with Child
            _buildSection('Badge with Child', [
              Row(
                children: [
                  ShadBadge(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 4),
                        const Text('Premium'),
                      ],
                    ),
                    variant: ShadBadgeVariant.default_,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadBadge(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.trending_up, size: 12),
                        const SizedBox(width: 4),
                        const Text('Trending'),
                      ],
                    ),
                    variant: ShadBadgeVariant.secondary,
                  ),
                ],
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Usage Examples
            _buildSection('Usage Examples', [
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Notifications',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        ShadBadge(
                          text: '3',
                          variant: ShadBadgeVariant.destructive,
                        ),
                      ],
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    const Text('You have 3 unread notifications'),
                  ],
                ),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        ShadBadge(
                          text: 'Active',
                          showDot: true,
                          variant: ShadBadgeVariant.default_,
                        ),
                      ],
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    const Text('Your account is currently active'),
                  ],
                ),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Tags',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Wrap(
                          spacing: ShadSpacing.xs,
                          children: [
                            ShadBadge(
                              text: 'Flutter',
                              variant: ShadBadgeVariant.outline,
                            ),
                            ShadBadge(
                              text: 'Dart',
                              variant: ShadBadgeVariant.outline,
                            ),
                            ShadBadge(
                              text: 'UI',
                              variant: ShadBadgeVariant.outline,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    const Text('Project tags for categorization'),
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
}
