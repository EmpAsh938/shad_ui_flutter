<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Shad UI Flutter

A comprehensive Flutter UI component library inspired by [shadcn/ui](https://ui.shadcn.com/), built with modern design principles and Flutter best practices. Features 36 production-ready components including 6 mobile-specific components.

[![pub package](https://img.shields.io/pub/v/shad_ui_flutter.svg)](https://pub.dev/packages/shad_ui_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- **36 Components** - Complete set of UI components for Flutter apps
- **Mobile-First** - 6 mobile-specific components (Bottom Sheet, Pull to Refresh, Swipeable List Items, FAB, Bottom Navigation, Search Bar)
- **Design System** - Consistent theming with custom design tokens
- **Accessibility** - WCAG compliant with proper semantics
- **Animations** - Smooth transitions and micro-interactions
- **Responsive** - Works across all screen sizes
- **Type-Safe** - Full Flutter type safety
- **Customizable** - Extensive theming and styling options

## 🚀 Quick Start

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  shad_ui_flutter: ^1.0.0
```

### Basic Usage

```dart
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadTheme(
      data: ShadThemeData.light(),
      child: MaterialApp(
        title: 'Shad UI Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shad UI Flutter')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ShadButton(
              onPressed: () => print('Button pressed!'),
              child: Text('Primary Button'),
            ),
            SizedBox(height: 16),
            ShadCard(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('This is a card component'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 📱 Mobile Components

### Bottom Sheet

```dart
ShadBottomSheet.show(
  context: context,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Slide-up content'),
  ),
);
```

### Pull to Refresh

```dart
ShadPullToRefresh(
  onRefresh: () async {
    // Refresh your data here
    await Future.delayed(Duration(seconds: 2));
  },
  child: ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) => ListTile(
      title: Text('Item $index'),
    ),
  ),
)
```

### Swipeable List Item

```dart
ShadSimpleSwipeableItem(
  onDelete: () => print('Delete item'),
  onEdit: () => print('Edit item'),
  child: ListTile(
    title: Text('Swipeable Item'),
    subtitle: Text('Swipe left for actions'),
  ),
)
```

### Floating Action Button

```dart
ShadFloatingActionButton(
  onPressed: () => print('FAB pressed'),
  child: Icon(Icons.add),
  variant: ShadFABVariant.primary,
  size: ShadFABSize.normal,
)
```

### Bottom Navigation

```dart
ShadBottomNavigation(
  currentIndex: _currentIndex,
  onTap: (index) => setState(() => _currentIndex = index),
  items: [
    ShadBottomNavigationItem(
      icon: Icons.home,
      label: 'Home',
    ),
    ShadBottomNavigationItem(
      icon: Icons.search,
      label: 'Search',
    ),
  ],
)
```

### Search Bar

```dart
ShadSearchBar(
  onChanged: (value) => print('Search: $value'),
  hintText: 'Search...',
  variant: ShadSearchBarVariant.filled,
)
```

## 🎨 Theming

Customize the appearance with the `ShadTheme`:

```dart
ShadTheme(
  data: ShadThemeData(
    primaryColor: Colors.blue,
    secondaryColor: Colors.green,
    brightness: Brightness.light,
    // ... more customization options
  ),
  child: MaterialApp(
    // Your app
  ),
)
```

## 📚 Available Components

### Core Components (30)

- **Button** - Interactive buttons with variants and states
- **Input** - Text input fields with validation
- **Select** - Dropdown selection components
- **Checkbox** - Selection controls
- **Radio** - Single selection controls
- **Switch** - Toggle controls
- **Slider** - Range selection
- **DatePicker** - Date selection
- **TimePicker** - Time selection
- **Card** - Content containers
- **Badge** - Status indicators
- **Avatar** - User profile images
- **Alert** - Notification messages
- **Toast** - Temporary notifications
- **Dialog** - Modal dialogs
- **Tooltip** - Hover information
- **Progress** - Loading indicators
- **FileUpload** - File upload with drag & drop
- **Divider** - Visual separators
- **Skeleton** - Loading placeholders
- **Tabs** - Tabbed navigation
- **Table** - Data tables
- **Modal** - Full-screen overlays
- **Breadcrumb** - Navigation breadcrumbs
- **Pagination** - Page navigation
- **Menu** - Dropdown menus
- **Accordion** - Collapsible sections
- **Calendar** - Date calendar
- **Command** - Command palette
- **Textarea** - Multi-line text input

### Mobile Components (6)

- **Bottom Sheet** - Slide-up panels
- **Pull to Refresh** - Swipe to refresh
- **Swipeable List Item** - Swipe actions
- **Floating Action Button** - Mobile action button
- **Bottom Navigation** - Mobile navigation
- **Search Bar** - Mobile search input

## 🔧 Customization

Each component supports extensive customization:

```dart
ShadButton(
  variant: ShadButtonVariant.outline,  // primary, secondary, outline, ghost, link
  size: ShadButtonSize.lg,             // sm, md, lg
  disabled: false,
  loading: false,
  fullWidth: true,
  onPressed: () {},
  child: Text('Custom Button'),
)
```

## 📖 Documentation

- [Component Documentation](https://pub.dev/documentation/shad_ui_flutter)
- [API Reference](https://pub.dev/documentation/shad_ui_flutter/latest/)
- [Examples](https://github.com/your-username/shad_ui_flutter/tree/main/example)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by [shadcn/ui](https://ui.shadcn.com/)
- Built with Flutter and Dart
- Icons from [Material Design Icons](https://material.io/icons/)

## 📞 Support

- 📧 Email: support@shadui.dev
- 🐛 Issues: [GitHub Issues](https://github.com/your-username/shad_ui_flutter/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/your-username/shad_ui_flutter/discussions)
- 📖 Documentation: [pub.dev](https://pub.dev/packages/shad_ui_flutter)
