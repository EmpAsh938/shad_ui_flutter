import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class PaginationDemo extends StatefulWidget {
  const PaginationDemo({super.key});

  @override
  State<PaginationDemo> createState() => _PaginationDemoState();
}

class _PaginationDemoState extends State<PaginationDemo> {
  int _currentPage = 1;
  final int _totalPages = 20;
  final int _totalItems = 200;
  final int _itemsPerPage = 10;
  ShadPaginationSize _size = ShadPaginationSize.md;
  bool _showFirstLast = true;
  bool _showPrevNext = true;
  bool _showPageNumbers = true;
  bool _showItemsInfo = true;
  ShadPaginationVariant _variant = ShadPaginationVariant.default_;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Demo'),
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
                children: ShadPaginationVariant.values.map((variant) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          variant.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadPagination(
                          currentPage: _currentPage,
                          totalPages: _totalPages,
                          totalItems: _totalItems,
                          itemsPerPage: _itemsPerPage,
                          variant: variant,
                          onPageChanged: (page) {
                            setState(() => _currentPage = page);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Examples
            _buildSection(
              'Examples',
              Column(
                children: [
                  // With items info
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'With Items Info',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadPagination(
                          currentPage: _currentPage,
                          totalPages: _totalPages,
                          totalItems: _totalItems,
                          itemsPerPage: _itemsPerPage,
                          showItemsInfo: true,
                          onPageChanged: (page) {
                            setState(() => _currentPage = page);
                          },
                        ),
                      ],
                    ),
                  ),

                  // Custom styling
                  Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Custom Styling',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadPagination(
                          currentPage: _currentPage,
                          totalPages: _totalPages,
                          totalItems: _totalItems,
                          itemsPerPage: _itemsPerPage,
                          showItemsInfo: true,
                          backgroundColor: Colors.blue.shade50,
                          borderColor: Colors.blue,
                          textColor: Colors.blue.shade800,
                          activeTextColor: Colors.white,
                          activeBackgroundColor: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(20),
                          onPageChanged: (page) {
                            setState(() => _currentPage = page);
                          },
                        ),
                      ],
                    ),
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
                  // Current page slider
                  Row(
                    children: [
                      const Text('Current Page: '),
                      const SizedBox(width: ShadSpacing.sm),
                      Expanded(
                        child: Slider(
                          value: _currentPage.toDouble(),
                          min: 1,
                          max: _totalPages.toDouble(),
                          divisions: _totalPages - 1,
                          label: _currentPage.toString(),
                          onChanged: (value) {
                            setState(() => _currentPage = value.round());
                          },
                        ),
                      ),
                      Text(_currentPage.toString()),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Variant selector
                  Row(
                    children: [
                      const Text('Variant: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadPaginationVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadPaginationVariant.values.map((variant) {
                          return DropdownMenuItem(
                            value: variant,
                            child: Text(variant.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Preview
                  const Text(
                    'Preview',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  ShadPagination(
                    currentPage: _currentPage,
                    totalPages: _totalPages,
                    totalItems: _totalItems,
                    itemsPerPage: _itemsPerPage,
                    variant: _variant,
                    size: _size,
                    showFirstLast: _showFirstLast,
                    showPrevNext: _showPrevNext,
                    showPageNumbers: _showPageNumbers,
                    showItemsInfo: _showItemsInfo,
                    onPageChanged: (page) {
                      setState(() => _currentPage = page);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Navigated to page $page')),
                      );
                    },
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
}
