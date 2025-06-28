import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'button_demo.dart';
import 'select_demo.dart';
import 'textarea_demo.dart';
import 'checkbox_demo.dart';
import 'card_demo.dart';
import 'badge_demo.dart';
import 'slider_demo.dart';
import 'date_picker_demo.dart';
import 'avatar_demo.dart';
import 'alert_demo.dart';
import 'time_picker_demo.dart';
import 'toast_demo.dart';
import 'dialog_demo.dart';
import 'tooltip_demo.dart';
import 'progress_demo.dart';
import 'file_upload_demo.dart';
import 'divider_demo.dart';
import 'skeleton_demo.dart';
import 'tabs_demo.dart';
import 'table_demo.dart';
import 'modal_demo.dart';
import 'breadcrumb_demo.dart';
import 'pagination_demo.dart';
import 'menu_demo.dart';
import 'accordion_demo.dart';
import 'calendar_demo.dart';
import 'command_demo.dart';
import 'bottom_sheet_demo.dart';
import 'pull_to_refresh_demo.dart';
import 'swipeable_list_item_demo.dart';
import 'floating_action_button_demo.dart';
import 'bottom_navigation_demo.dart';
import 'search_bar_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadTheme(
      data: ShadThemeData.light(),
      child: MaterialApp(
        title: 'Shad UI Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
        routes: {
          '/accordion': (context) => const AccordionDemo(),
          '/calendar': (context) => const CalendarDemo(),
          '/command': (context) => const CommandDemo(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  ShadBaseColor _selectedBaseColor = ShadBaseColor.slate;
  bool _isDarkMode = false;

  final List<Widget> _demos = [
    const ButtonDemo(),
    const SelectDemo(),
    const TextareaDemo(),
    const CheckboxDemo(),
    const CardDemo(),
    const BadgeDemo(),
    const SliderDemo(),
    const DatePickerDemo(),
    const AvatarDemo(),
    const AlertDemo(),
    const TimePickerDemo(),
    const ToastDemo(),
    const DialogDemo(),
    const TooltipDemo(),
    const ProgressDemo(),
    const FileUploadDemo(),
    const DividerDemo(),
    const SkeletonDemo(),
    const TabsDemo(),
    const TableDemo(),
    const ModalDemo(),
    const BreadcrumbDemo(),
    const PaginationDemo(),
    const MenuDemo(),
    const AccordionDemo(),
    const CalendarDemo(),
    const CommandDemo(),
    const BottomSheetDemo(),
    const PullToRefreshDemo(),
    const SwipeableListItemDemo(),
    const FloatingActionButtonDemo(),
    const BottomNavigationDemo(),
    const SearchBarDemo(),
  ];

  final List<String> _demoNames = [
    'Button',
    'Select',
    'Textarea',
    'Checkbox',
    'Card',
    'Badge',
    'Slider',
    'DatePicker',
    'Avatar',
    'Alert',
    'TimePicker',
    'Toast',
    'Dialog',
    'Tooltip',
    'Progress',
    'FileUpload',
    'Divider',
    'Skeleton',
    'Tabs',
    'Table',
    'Modal',
    'Breadcrumb',
    'Pagination',
    'Menu',
    'Accordion',
    'Calendar',
    'Command',
    'Bottom Sheet',
    'Pull to Refresh',
    'Swipeable List Item',
    'Floating Action Button',
    'Bottom Navigation',
    'Search Bar',
  ];

  @override
  Widget build(BuildContext context) {
    return ShadTheme(
      data: _isDarkMode ? ShadThemeData.dark() : ShadThemeData.light(),
      baseColor: _selectedBaseColor,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shad UI Flutter'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // Base Color Selector
            DropdownButton<ShadBaseColor>(
              value: _selectedBaseColor,
              onChanged: (ShadBaseColor? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedBaseColor = newValue;
                  });
                }
              },
              items: ShadBaseColor.values.map<DropdownMenuItem<ShadBaseColor>>((
                ShadBaseColor color,
              ) {
                return DropdownMenuItem<ShadBaseColor>(
                  value: color,
                  child: Text(color.name),
                );
              }).toList(),
            ),
            const SizedBox(width: 16),
            // Theme Toggle
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Component Selector
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Component: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_demoNames.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(_demoNames[index]),
                              selected: _selectedIndex == index,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                }
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Demo Content
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(child: _demos[_selectedIndex]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
