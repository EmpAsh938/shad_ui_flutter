import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'package:shad_ui_flutter/src/tokens/tokens.dart';

class CardDemo extends StatefulWidget {
  const CardDemo({super.key});

  @override
  State<CardDemo> createState() => _CardDemoState();
}

class _CardDemoState extends State<CardDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Card Component',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.lg),

            // Variants
            _buildSection('Variants', [
              ShadCard(
                variant: ShadCardVariant.default_,
                child: const Text('Default Card'),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                variant: ShadCardVariant.outline,
                child: const Text('Outline Card'),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                variant: ShadCardVariant.filled,
                child: const Text('Filled Card'),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                variant: ShadCardVariant.ghost,
                child: const Text('Ghost Card'),
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Sizes
            _buildSection('Sizes', [
              ShadCard(size: ShadCardSize.sm, child: const Text('Small Card')),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(size: ShadCardSize.md, child: const Text('Medium Card')),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(size: ShadCardSize.lg, child: const Text('Large Card')),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Interactive Cards
            _buildSection('Interactive Cards', [
              ShadCard(
                interactive: true,
                onTap: () => _showSnackBar('Card tapped!'),
                child: const Text('Clickable Card'),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                interactive: true,
                onLongPress: () => _showSnackBar('Card long pressed!'),
                child: const Text('Long Press Card'),
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Cards with Header and Footer
            _buildSection('Cards with Header and Footer', [
              ShadCard(
                header: Container(
                  padding: const EdgeInsets.all(ShadSpacing.md),
                  child: const Row(
                    children: [
                      Icon(Icons.info),
                      SizedBox(width: ShadSpacing.sm),
                      Text(
                        'Card Header',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                child: const Text(
                  'This card has a header with an icon and title.',
                ),
                footer: Container(
                  padding: const EdgeInsets.all(ShadSpacing.md),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('Footer content')],
                  ),
                ),
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Disabled Cards
            _buildSection('Disabled Cards', [
              ShadCard(disabled: true, child: const Text('Disabled Card')),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                disabled: true,
                interactive: true,
                onTap: () => _showSnackBar('This should not work'),
                child: const Text('Disabled Interactive Card'),
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Custom Styling
            _buildSection('Custom Styling', [
              ShadCard(
                backgroundColor: Colors.blue.shade50,
                borderColor: Colors.blue.shade200,
                borderWidth: 2,
                borderRadius: BorderRadius.circular(ShadRadius.lg),
                shadows: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                child: const Text('Custom Styled Card'),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.pink.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: const Text(
                  'Gradient Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),

            const SizedBox(height: ShadSpacing.xl),

            // Complex Content
            _buildSection('Complex Content', [
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: const Icon(Icons.person, color: Colors.blue),
                        ),
                        const SizedBox(width: ShadSpacing.md),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Software Developer'),
                            ],
                          ),
                        ),
                        ShadBadge(
                          text: 'Active',
                          variant: ShadBadgeVariant.default_,
                        ),
                      ],
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    const Text(
                      'This is a more complex card with multiple elements including an avatar, user information, and a badge.',
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            const Text('4.5'),
                          ],
                        ),
                        ShadButton(
                          onPressed: () => _showSnackBar('View Profile'),
                          child: const Text('View Profile'),
                        ),
                      ],
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
