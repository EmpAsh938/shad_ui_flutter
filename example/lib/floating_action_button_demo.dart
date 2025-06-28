import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class FloatingActionButtonDemo extends StatefulWidget {
  const FloatingActionButtonDemo({super.key});

  @override
  State<FloatingActionButtonDemo> createState() =>
      _FloatingActionButtonDemoState();
}

class _FloatingActionButtonDemoState extends State<FloatingActionButtonDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Counter incremented!')));
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Counter decremented!')));
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Counter reset!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Floating Action Button Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Counter Display
            Center(
              child: Column(
                children: [
                  Text(
                    'Counter: $_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Use the FABs below to interact',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Basic FAB Variants
            Text(
              'Basic FAB Variants',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  variant: ShadFABVariant.secondary,
                  child: const Icon(Icons.add),
                ),
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  variant: ShadFABVariant.surface,
                  child: const Icon(Icons.add),
                ),
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  variant: ShadFABVariant.outline,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // FAB Sizes
            Text('FAB Sizes', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  size: ShadFABSize.small,
                  child: const Icon(Icons.add, size: 16),
                ),
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  size: ShadFABSize.normal,
                  child: const Icon(Icons.add, size: 20),
                ),
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  size: ShadFABSize.large,
                  child: const Icon(Icons.add, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // FAB with Labels
            Text(
              'FAB with Labels',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ShadFloatingActionButton(
                  onPressed: _incrementCounter,
                  label: 'Add',
                  child: const Icon(Icons.add),
                ),
                ShadFloatingActionButton(
                  onPressed: _decrementCounter,
                  variant: ShadFABVariant.secondary,
                  label: 'Remove',
                  child: const Icon(Icons.remove),
                ),
                ShadFloatingActionButton(
                  onPressed: _resetCounter,
                  variant: ShadFABVariant.surface,
                  label: 'Reset',
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Speed Dial Demo
            Text(
              'Speed Dial',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Center(
              child: ShadSpeedDial(
                children: [
                  ShadSpeedDialChild(
                    icon: Icons.add,
                    label: 'Add',
                    onPressed: _incrementCounter,
                  ),
                  ShadSpeedDialChild(
                    icon: Icons.remove,
                    label: 'Remove',
                    onPressed: _decrementCounter,
                  ),
                  ShadSpeedDialChild(
                    icon: Icons.refresh,
                    label: 'Reset',
                    onPressed: _resetCounter,
                  ),
                ],
                icon: Icons.menu,
                activeIcon: Icons.close,
              ),
            ),
            const SizedBox(height: 32),

            // Extended FAB
            Text(
              'Extended FAB',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Center(
              child: ShadFloatingActionButton(
                onPressed: _incrementCounter,
                isExtended: true,
                label: 'Add Item',
                child: const Icon(Icons.add),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ShadFloatingActionButton(
                onPressed: _decrementCounter,
                variant: ShadFABVariant.secondary,
                isExtended: true,
                label: 'Remove Item',
                child: const Icon(Icons.remove),
              ),
            ),
            const SizedBox(height: 32),

            // Custom FAB Examples
            Text(
              'Custom FAB Examples',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ShadFloatingActionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share action!')),
                    );
                  },
                  variant: ShadFABVariant.outline,
                  child: const Icon(Icons.share),
                ),
                ShadFloatingActionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Favorite action!')),
                    );
                  },
                  variant: ShadFABVariant.secondary,
                  child: const Icon(Icons.favorite),
                ),
                ShadFloatingActionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings action!')),
                    );
                  },
                  variant: ShadFABVariant.surface,
                  child: const Icon(Icons.settings),
                ),
                ShadFloatingActionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Camera action!')),
                    );
                  },
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
            const SizedBox(height: 100), // Bottom padding for FABs
          ],
        ),
      ),
    );
  }
}
