library shad_ui_flutter;

/// A comprehensive Flutter UI component library inspired by shadcn/ui.
///
/// This library provides 36 production-ready components including 6 mobile-specific
/// components with modern design principles and Flutter best practices.
///
/// ## Features
///
/// - **36 Components** - Complete set of UI components for Flutter apps
/// - **Mobile-First** - 6 mobile-specific components
/// - **Design System** - Consistent theming with custom design tokens
/// - **Accessibility** - WCAG compliant with proper semantics
/// - **Animations** - Smooth transitions and micro-interactions
/// - **Responsive** - Works across all screen sizes
/// - **Type-Safe** - Full Flutter type safety
/// - **Customizable** - Extensive theming and styling options
///
/// ## Quick Start
///
/// ```dart
/// import 'package:shad_ui_flutter/shad_ui_flutter.dart';
///
/// void main() {
///   runApp(MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return ShadTheme(
///       data: ShadThemeData.light(),
///       child: MaterialApp(
///         title: 'Shad UI Demo',
///         home: MyHomePage(),
///       ),
///     );
///   }
/// }
/// ```

export 'src/theme/shad_theme.dart';
export 'src/tokens/tokens.dart';

export 'src/components/button.dart';
export 'src/components/input.dart';
export 'src/components/textarea.dart';
export 'src/components/select.dart';
export 'src/components/checkbox.dart';
export 'src/components/radio.dart';
export 'src/components/switch.dart';
export 'src/components/slider.dart';
export 'src/components/date_picker.dart';
export 'src/components/card.dart';
export 'src/components/badge.dart';
export 'src/components/avatar.dart';
export 'src/components/alert.dart';
export 'src/components/time_picker.dart';
export 'src/components/toast.dart';
export 'src/components/dialog.dart';
export 'src/components/tooltip.dart';
export 'src/components/progress.dart';
export 'src/components/file_upload.dart';
export 'src/components/divider.dart';
export 'src/components/skeleton.dart';
export 'src/components/tabs.dart';
export 'src/components/table.dart';
export 'src/components/modal.dart';
export 'src/components/breadcrumb.dart';
export 'src/components/pagination.dart';
export 'src/components/menu.dart';
export 'src/components/accordion.dart';
export 'src/components/calendar.dart';
export 'src/components/command.dart';

// Mobile-specific components
export 'src/components/bottom_sheet.dart';
export 'src/components/pull_to_refresh.dart';
export 'src/components/swipeable_list_item.dart';
export 'src/components/floating_action_button.dart';
export 'src/components/bottom_navigation.dart';
export 'src/components/search_bar.dart';
