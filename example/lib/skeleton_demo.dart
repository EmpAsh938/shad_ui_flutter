import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class SkeletonDemo extends StatefulWidget {
  const SkeletonDemo({super.key});

  @override
  State<SkeletonDemo> createState() => _SkeletonDemoState();
}

class _SkeletonDemoState extends State<SkeletonDemo> {
  ShadSkeletonVariant _variant = ShadSkeletonVariant.default_;
  ShadSkeletonSize _size = ShadSkeletonSize.md;
  ShadSkeletonType _type = ShadSkeletonType.text;
  bool _animated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeleton Demo'),
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
                children: ShadSkeletonVariant.values.map((variant) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            variant.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: ShadSkeleton(
                            variant: variant,
                            type: ShadSkeletonType.text,
                            animated: _animated,
                          ),
                        ),
                      ],
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
                children: ShadSkeletonSize.values.map((size) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            size.name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: ShadSkeleton(
                            size: size,
                            type: ShadSkeletonType.text,
                            animated: _animated,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Types
            _buildSection(
              'Types',
              Column(
                children: [
                  // Text
                  _buildTypeExample('Text', ShadSkeletonType.text),
                  const SizedBox(height: ShadSpacing.lg),

                  // Title
                  _buildTypeExample('Title', ShadSkeletonType.title),
                  const SizedBox(height: ShadSpacing.lg),

                  // Avatar
                  _buildTypeExample('Avatar', ShadSkeletonType.avatar),
                  const SizedBox(height: ShadSpacing.lg),

                  // Button
                  _buildTypeExample('Button', ShadSkeletonType.button),
                  const SizedBox(height: ShadSpacing.lg),

                  // Card
                  _buildTypeExample('Card', ShadSkeletonType.card),
                  const SizedBox(height: ShadSpacing.lg),

                  // List
                  _buildTypeExample('List', ShadSkeletonType.list),
                ],
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Customization
            _buildSection(
              'Customization',
              Column(
                children: [
                  // Custom colors
                  const Text(
                    'Custom Colors',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: ShadSkeleton(
                          type: ShadSkeletonType.text,
                          color: Colors.blue.withValues(alpha: 0.3),
                          animated: _animated,
                        ),
                      ),
                      const SizedBox(width: ShadSpacing.md),
                      Expanded(
                        child: ShadSkeleton(
                          type: ShadSkeletonType.text,
                          color: Colors.green.withValues(alpha: 0.3),
                          animated: _animated,
                        ),
                      ),
                      const SizedBox(width: ShadSpacing.md),
                      Expanded(
                        child: ShadSkeleton(
                          type: ShadSkeletonType.text,
                          color: Colors.purple.withValues(alpha: 0.3),
                          animated: _animated,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Custom dimensions
                  const Text(
                    'Custom Dimensions',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadSkeleton(
                    type: ShadSkeletonType.text,
                    width: 200,
                    height: 30,
                    animated: _animated,
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Non-animated
                  const Text(
                    'Non-animated',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  const ShadSkeleton(
                    type: ShadSkeletonType.text,
                    animated: false,
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
                      DropdownButton<ShadSkeletonVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadSkeletonVariant.values.map((variant) {
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
                      DropdownButton<ShadSkeletonSize>(
                        value: _size,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _size = value);
                          }
                        },
                        items: ShadSkeletonSize.values.map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(size.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Type selector
                  Row(
                    children: [
                      const Text('Type: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadSkeletonType>(
                        value: _type,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _type = value);
                          }
                        },
                        items: ShadSkeletonType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Animation toggle
                  Row(
                    children: [
                      const Text('Animated: '),
                      const SizedBox(width: ShadSpacing.sm),
                      Switch(
                        value: _animated,
                        onChanged: (value) {
                          setState(() => _animated = value);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Preview
                  const Text(
                    'Preview',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadSkeleton(
                    variant: _variant,
                    size: _size,
                    type: _type,
                    animated: _animated,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildTypeExample(String title, ShadSkeletonType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: ShadSpacing.sm),
        ShadSkeleton(type: type, animated: _animated),
      ],
    );
  }
}
