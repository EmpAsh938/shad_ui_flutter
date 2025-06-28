import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class AvatarDemo extends StatefulWidget {
  const AvatarDemo({super.key});

  @override
  State<AvatarDemo> createState() => _AvatarDemoState();
}

class _AvatarDemoState extends State<AvatarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Avatar Component',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.lg),

            _buildSection('Default Avatar', [
              ShadAvatar(
                name: 'John Doe',
                onTap: () => _showSnackBar('Avatar tapped!'),
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Variants', [
              Row(
                children: [
                  ShadAvatar(
                    name: 'John Doe',
                    variant: ShadAvatarVariant.default_,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    name: 'Jane Smith',
                    variant: ShadAvatarVariant.outline,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    name: 'Bob Johnson',
                    variant: ShadAvatarVariant.filled,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    name: 'Alice Brown',
                    variant: ShadAvatarVariant.ghost,
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Sizes', [
              Row(
                children: [
                  ShadAvatar(name: 'John Doe', size: ShadAvatarSize.sm),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(name: 'Jane Smith', size: ShadAvatarSize.md),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(name: 'Bob Johnson', size: ShadAvatarSize.lg),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(name: 'Alice Brown', size: ShadAvatarSize.xl),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Shapes', [
              Row(
                children: [
                  ShadAvatar(name: 'John Doe', shape: ShadAvatarShape.circle),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(name: 'Jane Smith', shape: ShadAvatarShape.square),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    name: 'Bob Johnson',
                    shape: ShadAvatarShape.rounded,
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Images', [
              Row(
                children: [
                  ShadAvatar(
                    imageUrl:
                        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
                    name: 'John Doe',
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    imageUrl:
                        'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
                    name: 'Jane Smith',
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    imageUrl:
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                    name: 'Bob Johnson',
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Custom Content', [
              Row(
                children: [
                  ShadAvatar(
                    child: const Icon(Icons.person, color: Colors.white),
                    variant: ShadAvatarVariant.default_,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    child: const Icon(Icons.business, color: Colors.white),
                    variant: ShadAvatarVariant.outline,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    child: const Icon(Icons.school, color: Colors.white),
                    variant: ShadAvatarVariant.filled,
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Custom Styling', [
              Row(
                children: [
                  ShadAvatar(
                    name: 'John Doe',
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                    borderColor: Colors.purple.shade700,
                    borderWidth: 2,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    name: 'Jane Smith',
                    backgroundColor: Colors.blue.shade100,
                    textColor: Colors.blue.shade800,
                  ),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    name: 'Bob Johnson',
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Disabled', [
              Row(
                children: [
                  ShadAvatar(name: 'John Doe', disabled: true),
                  const SizedBox(width: ShadSpacing.md),
                  ShadAvatar(
                    name: 'Jane Smith',
                    disabled: true,
                    variant: ShadAvatarVariant.outline,
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Interactive Examples', [
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShadAvatar(
                          name: 'John Doe',
                          size: ShadAvatarSize.lg,
                          onTap: () => _showSnackBar('Profile tapped!'),
                        ),
                        const SizedBox(width: ShadSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Text('Software Developer'),
                            ],
                          ),
                        ),
                        ShadBadge(
                          text: 'Online',
                          showDot: true,
                          variant: ShadBadgeVariant.default_,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Team Members',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: ShadSpacing.md),
                    Row(
                      children: [
                        ShadAvatar(
                          name: 'Alice Brown',
                          size: ShadAvatarSize.sm,
                        ),
                        const SizedBox(width: ShadSpacing.xs),
                        ShadAvatar(
                          name: 'Bob Johnson',
                          size: ShadAvatarSize.sm,
                        ),
                        const SizedBox(width: ShadSpacing.xs),
                        ShadAvatar(
                          name: 'Carol Davis',
                          size: ShadAvatarSize.sm,
                        ),
                        const SizedBox(width: ShadSpacing.xs),
                        ShadAvatar(
                          name: 'David Wilson',
                          size: ShadAvatarSize.sm,
                        ),
                        const SizedBox(width: ShadSpacing.xs),
                        ShadAvatar(
                          child: const Text(
                            '+2',
                            style: TextStyle(fontSize: 10),
                          ),
                          size: ShadAvatarSize.sm,
                          variant: ShadAvatarVariant.outline,
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
