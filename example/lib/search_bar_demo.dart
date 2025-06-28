import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class SearchBarDemo extends StatefulWidget {
  const SearchBarDemo({super.key});

  @override
  State<SearchBarDemo> createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _suggestionQuery = '';

  final List<String> _suggestions = [
    'Flutter',
    'Dart',
    'Mobile Development',
    'UI Design',
    'Material Design',
    'Cupertino',
    'Widgets',
    'State Management',
    'Navigation',
    'Animations',
  ];

  List<String> get _filteredSuggestions {
    if (_suggestionQuery.isEmpty) return _suggestions;
    return _suggestions
        .where(
          (suggestion) =>
              suggestion.toLowerCase().contains(_suggestionQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Bar Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Search Bar
            Text(
              'Basic Search Bar',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ShadSearchBar(
              hintText: 'Search for anything...',
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_searchQuery.isNotEmpty)
              Text(
                'Search query: "$_searchQuery"',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 32),

            // Search Bar Variants
            Text(
              'Search Bar Variants',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                ShadSearchBar(
                  hintText: 'Filled variant',
                  variant: ShadSearchBarVariant.filled,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                ShadSearchBar(
                  hintText: 'Outlined variant',
                  variant: ShadSearchBarVariant.outlined,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                ShadSearchBar(
                  hintText: 'Elevated variant',
                  variant: ShadSearchBarVariant.elevated,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Search Bar with Suggestions
            Text(
              'Search Bar with Suggestions',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ShadSearchBarWithSuggestions(
              hintText: 'Search with suggestions...',
              suggestions: _filteredSuggestions,
              onSearch: (value) {
                setState(() {
                  _suggestionQuery = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Searching for: $value')),
                );
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _suggestionQuery = suggestion;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: $suggestion')),
                );
              },
            ),
            const SizedBox(height: 32),

            // Custom Search Bar
            Text(
              'Custom Search Bar',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ShadSearchBar(
              hintText: 'Custom search with actions...',
              leading: const Icon(Icons.search),
              trailing: IconButton(
                icon: const Icon(Icons.mic),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mic icon pressed')),
                  );
                },
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 32),

            // Search Bar with Filters
            Text(
              'Search Bar with Filters',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ShadSearchBar(
              hintText: 'Search with filters...',
              onChanged: (value) {},
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Filter selected: $value')),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'all', child: Text('All')),
                  const PopupMenuItem(value: 'recent', child: Text('Recent')),
                  const PopupMenuItem(
                    value: 'favorites',
                    child: Text('Favorites'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Search Results Example
            Text(
              'Search Results Example',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (_searchQuery.isNotEmpty) ...[
              Text(
                'Results for "$_searchQuery":',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ShadCard(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Colors.primaries[index % Colors.primaries.length],
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text('Result ${index + 1} for "$_searchQuery"'),
                        subtitle: Text(
                          'This is a search result for "$_searchQuery"',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selected result ${index + 1}'),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ] else ...[
              Text(
                'Enter a search query to see results',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 32),

            // Search Bar Sizes
            Text(
              'Search Bar Sizes',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                ShadSearchBar(
                  hintText: 'Small search bar',
                  size: ShadSearchBarSize.small,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                ShadSearchBar(
                  hintText: 'Medium search bar',
                  size: ShadSearchBarSize.normal,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                ShadSearchBar(
                  hintText: 'Large search bar',
                  size: ShadSearchBarSize.large,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
