import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import './lib/button_demo.dart';
import './lib/select_demo.dart';
import './lib/textarea_demo.dart';
import './lib/checkbox_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shad UI Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
  ];

  final List<String> _demoNames = ['Button', 'Select', 'Textarea', 'Checkbox'];

  @override
  Widget build(BuildContext context) {
    return ShadTheme(
      data: _isDarkMode
          ? ShadThemeData.dark(baseColor: _selectedBaseColor)
          : ShadThemeData.light(baseColor: _selectedBaseColor),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Component Selector
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      'Component: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
              SizedBox(child: _demos[_selectedIndex]),
            ],
          ),
        ),
      ),
    );
  }
}
