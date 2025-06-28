import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'package:shad_ui_flutter/src/tokens/tokens.dart';

class SliderDemo extends StatefulWidget {
  const SliderDemo({super.key});

  @override
  State<SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _value1 = 0.5;
  double _value2 = 0.2;
  double _value3 = 0.8;
  double _value4 = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Slider Component',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.lg),

            _buildSection('Default Slider', [
              ShadSlider(
                value: _value1,
                onChanged: (v) => setState(() => _value1 = v),
                label: _value1.toStringAsFixed(2),
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Variants', [
              ShadSlider(
                value: _value2,
                onChanged: (v) => setState(() => _value2 = v),
                variant: ShadSliderVariant.outline,
                label: _value2.toStringAsFixed(2),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadSlider(
                value: _value3,
                onChanged: (v) => setState(() => _value3 = v),
                variant: ShadSliderVariant.filled,
                label: _value3.toStringAsFixed(2),
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadSlider(
                value: _value4,
                onChanged: (v) => setState(() => _value4 = v),
                variant: ShadSliderVariant.ghost,
                label: _value4.toStringAsFixed(2),
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Sizes', [
              ShadSlider(
                value: _value1,
                onChanged: (v) => setState(() => _value1 = v),
                size: ShadSliderSize.sm,
                label: 'Small',
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadSlider(
                value: _value2,
                onChanged: (v) => setState(() => _value2 = v),
                size: ShadSliderSize.md,
                label: 'Medium',
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadSlider(
                value: _value3,
                onChanged: (v) => setState(() => _value3 = v),
                size: ShadSliderSize.lg,
                label: 'Large',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Disabled', [
              ShadSlider(
                value: 0.5,
                onChanged: null,
                disabled: true,
                label: 'Disabled',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('Custom Colors', [
              ShadSlider(
                value: _value1,
                onChanged: (v) => setState(() => _value1 = v),
                activeColor: Colors.purple,
                inactiveColor: Colors.purple.shade100,
                thumbColor: Colors.purple.shade700,
                label: 'Custom',
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            _buildSection('With Divisions', [
              ShadSlider(
                value: _value2,
                onChanged: (v) => setState(() => _value2 = v),
                divisions: 5,
                min: 0,
                max: 100,
                label: _value2.toStringAsFixed(0),
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
