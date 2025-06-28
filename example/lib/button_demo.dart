import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class ButtonDemo extends StatefulWidget {
  const ButtonDemo({super.key});

  @override
  State<ButtonDemo> createState() => _ButtonDemoState();
}

class _ButtonDemoState extends State<ButtonDemo> {
  ShadButtonSize buttonSize = ShadButtonSize.md;
  ShadButtonShape buttonShape = ShadButtonShape.rounded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Button Controls
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Button Controls',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<ShadButtonSize>(
                      value: buttonSize,
                      onChanged: (value) {
                        if (value != null) setState(() => buttonSize = value);
                      },
                      items: ShadButtonSize.values.map((size) {
                        return DropdownMenuItem(
                          value: size,
                          child: Text(size.name),
                        );
                      }).toList(),
                    ),
                    DropdownButton<ShadButtonShape>(
                      value: buttonShape,
                      onChanged: (value) {
                        if (value != null) setState(() => buttonShape = value);
                      },
                      items: ShadButtonShape.values.map((shape) {
                        return DropdownMenuItem(
                          value: shape,
                          child: Text(shape.name),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Basic Variants
        Text('Basic Variants', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Primary'),
          variant: ShadButtonVariant.primary,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Secondary'),
          variant: ShadButtonVariant.secondary,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Destructive'),
          variant: ShadButtonVariant.destructive,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Outline'),
          variant: ShadButtonVariant.outline,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Ghost'),
          variant: ShadButtonVariant.ghost,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Link'),
          variant: ShadButtonVariant.link,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 24),

        // Icon Buttons
        Text('Icon Buttons', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadButton(
              onPressed: () {},
              icon: const Icon(Icons.star),
              variant: ShadButtonVariant.icon,
              size: buttonSize,
              shape: buttonShape,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
              variant: ShadButtonVariant.icon,
              size: buttonSize,
              shape: buttonShape,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
              variant: ShadButtonVariant.icon,
              size: buttonSize,
              shape: buttonShape,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Icon Positioning
        Text('Icon Positioning', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Left Icon'),
          icon: const Icon(Icons.arrow_back),
          iconPosition: ShadIconPosition.left,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Right Icon'),
          icon: const Icon(Icons.arrow_forward),
          iconPosition: ShadIconPosition.right,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Top Icon'),
          icon: const Icon(Icons.keyboard_arrow_up),
          iconPosition: ShadIconPosition.top,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Bottom Icon'),
          icon: const Icon(Icons.keyboard_arrow_down),
          iconPosition: ShadIconPosition.bottom,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 24),

        // Loading States
        Text('Loading States', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadButton(
              onPressed: () {},
              child: const Text('Spinner'),
              loading: true,
              loadingType: ShadLoadingType.spinner,
              size: buttonSize,
              shape: buttonShape,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              child: const Text('Dots'),
              loading: true,
              loadingType: ShadLoadingType.dots,
              size: buttonSize,
              shape: buttonShape,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              child: const Text('Skeleton'),
              loading: true,
              loadingType: ShadLoadingType.skeleton,
              size: buttonSize,
              shape: buttonShape,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Disabled States
        Text('Disabled States', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: null,
          child: const Text('Disabled'),
          disabled: true,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: null,
          child: const Text('Disabled Outline'),
          variant: ShadButtonVariant.outline,
          disabled: true,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 24),

        // Custom Styling
        Text('Custom Styling', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Gradient'),
          gradient: const LinearGradient(colors: [Colors.purple, Colors.blue]),
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('With Shadow'),
          shadows: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Custom Colors'),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Faded'),
          opacity: 0.6,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 24),

        // Full Width
        Text('Full Width', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ShadButton(
          onPressed: () {},
          child: const Text('Full Width Button'),
          fullWidth: true,
          size: buttonSize,
          shape: buttonShape,
        ),
        const SizedBox(height: 24),

        // Size Comparison
        Text('Size Comparison', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadButton(
              onPressed: () {},
              child: const Text('Small'),
              size: ShadButtonSize.sm,
              shape: buttonShape,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              child: const Text('Medium'),
              size: ShadButtonSize.md,
              shape: buttonShape,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              child: const Text('Large'),
              size: ShadButtonSize.lg,
              shape: buttonShape,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Shape Comparison
        Text('Shape Comparison', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadButton(
              onPressed: () {},
              child: const Text('Rounded'),
              shape: ShadButtonShape.rounded,
              size: buttonSize,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              child: const Text('Pill'),
              shape: ShadButtonShape.pill,
              size: buttonSize,
            ),
            const SizedBox(width: 16),
            ShadButton(
              onPressed: () {},
              child: const Text('Square'),
              shape: ShadButtonShape.square,
              size: buttonSize,
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
