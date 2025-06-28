import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'package:shad_ui_flutter/src/tokens/tokens.dart';

class DividerDemo extends StatefulWidget {
  const DividerDemo({super.key});

  @override
  State<DividerDemo> createState() => _DividerDemoState();
}

class _DividerDemoState extends State<DividerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Divider',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.md),
            Text(
              'Horizontal and vertical separators with customizable styling.',
              style: TextStyle(
                fontSize: ShadTypography.fontSizeMd,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: ShadSpacing.xl),

            // Variants
            _buildSection('Variants', [
              Column(
                children: [
                  _buildDividerExample('Default', ShadDividerVariant.default_),
                  const SizedBox(height: ShadSpacing.md),
                  _buildDividerExample('Thin', ShadDividerVariant.thin),
                  const SizedBox(height: ShadSpacing.md),
                  _buildDividerExample('Thick', ShadDividerVariant.thick),
                  const SizedBox(height: ShadSpacing.md),
                  _buildDividerExample('Dashed', ShadDividerVariant.dashed),
                  const SizedBox(height: ShadSpacing.md),
                  _buildDividerExample('Dotted', ShadDividerVariant.dotted),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Sizes
            _buildSection('Sizes', [
              Column(
                children: [
                  _buildDividerExample(
                    'Small',
                    ShadDividerVariant.default_,
                    size: ShadDividerSize.sm,
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  _buildDividerExample(
                    'Medium',
                    ShadDividerVariant.default_,
                    size: ShadDividerSize.md,
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  _buildDividerExample(
                    'Large',
                    ShadDividerVariant.default_,
                    size: ShadDividerSize.lg,
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // With Labels
            _buildSection('With Labels', [
              Column(
                children: [
                  ShadDivider(showLabel: true, label: const Text('Section 1')),
                  const SizedBox(height: ShadSpacing.lg),
                  const Text('Content for section 1'),
                  const SizedBox(height: ShadSpacing.lg),
                  ShadDivider(showLabel: true, label: const Text('Section 2')),
                  const SizedBox(height: ShadSpacing.lg),
                  const Text('Content for section 2'),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Vertical Dividers
            _buildSection('Vertical Dividers', [
              Row(
                children: [
                  const Expanded(child: Text('Left content')),
                  const SizedBox(width: ShadSpacing.md),
                  ShadDivider(
                    orientation: ShadDividerOrientation.vertical,
                    height: 50,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  const Expanded(child: Text('Right content')),
                ],
              ),
              const SizedBox(height: ShadSpacing.lg),
              Row(
                children: [
                  const Expanded(child: Text('Left content')),
                  const SizedBox(width: ShadSpacing.md),
                  ShadDivider(
                    orientation: ShadDividerOrientation.vertical,
                    variant: ShadDividerVariant.dashed,
                    height: 50,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  const Expanded(child: Text('Right content')),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Custom Colors
            _buildSection('Custom Colors', [
              Column(
                children: [
                  ShadDivider(color: Colors.red),
                  const SizedBox(height: ShadSpacing.md),
                  ShadDivider(color: Colors.green),
                  const SizedBox(height: ShadSpacing.md),
                  ShadDivider(color: Colors.blue),
                  const SizedBox(height: ShadSpacing.md),
                  ShadDivider(color: Colors.purple),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Custom Width
            _buildSection('Custom Width', [
              Column(
                children: [
                  ShadDivider(width: 100),
                  const SizedBox(height: ShadSpacing.md),
                  ShadDivider(width: 200),
                  const SizedBox(height: ShadSpacing.md),
                  ShadDivider(width: 300),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Custom Margin
            _buildSection('Custom Margin', [
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(ShadSpacing.md),
                child: Column(
                  children: [
                    const Text('Content above'),
                    ShadDivider(
                      margin: const EdgeInsets.symmetric(
                        vertical: ShadSpacing.lg,
                      ),
                    ),
                    const Text('Content below'),
                  ],
                ),
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Mixed Examples
            _buildSection('Mixed Examples', [
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star),
                      const SizedBox(width: ShadSpacing.sm),
                      const Text('Featured'),
                      const SizedBox(width: ShadSpacing.md),
                      ShadDivider(
                        orientation: ShadDividerOrientation.vertical,
                        height: 20,
                        variant: ShadDividerVariant.dotted,
                      ),
                      const SizedBox(width: ShadSpacing.md),
                      const Text('Premium'),
                    ],
                  ),
                  const SizedBox(height: ShadSpacing.lg),
                  Row(
                    children: [
                      const Icon(Icons.info),
                      const SizedBox(width: ShadSpacing.sm),
                      const Text('Information'),
                      const SizedBox(width: ShadSpacing.md),
                      ShadDivider(
                        orientation: ShadDividerOrientation.vertical,
                        height: 20,
                        variant: ShadDividerVariant.dashed,
                      ),
                      const SizedBox(width: ShadSpacing.md),
                      const Text('Details'),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerExample(
    String title,
    ShadDividerVariant variant, {
    ShadDividerSize? size,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ShadTypography.fontSizeSm,
            fontWeight: ShadTypography.fontWeightMedium,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: ShadSpacing.xs),
        ShadDivider(variant: variant, size: size ?? ShadDividerSize.md),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ShadTypography.fontSizeXl,
            fontWeight: ShadTypography.fontWeightBold,
          ),
        ),
        const SizedBox(height: ShadSpacing.md),
        ...children,
      ],
    );
  }
}
