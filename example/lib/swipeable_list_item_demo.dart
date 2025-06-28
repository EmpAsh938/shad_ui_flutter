import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class SwipeableListItemDemo extends StatefulWidget {
  const SwipeableListItemDemo({super.key});

  @override
  State<SwipeableListItemDemo> createState() => _SwipeableListItemDemoState();
}

class _SwipeableListItemDemoState extends State<SwipeableListItemDemo> {
  final List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    _items.clear();
    for (int i = 1; i <= 10; i++) {
      _items.add({
        'id': i,
        'title': 'Item $i',
        'subtitle': 'This is item number $i with some description',
        'color': Colors.primaries[i % Colors.primaries.length],
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Deleted item ${index + 1}')));
  }

  void _editItem(int index) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Edit item ${index + 1}')));
  }

  void _archiveItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Archived item ${index + 1}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipeable List Item Demo'),
        actions: [
          ShadButton(
            onPressed: () {
              setState(() {
                _loadItems();
              });
            },
            variant: ShadButtonVariant.outline,
            size: ShadButtonSize.sm,
            child: const Text('Reset'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Swipe left on items to reveal actions',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: ShadSimpleSwipeableItem(
                    onEdit: () => _editItem(index),
                    onDelete: () => _deleteItem(index),
                    onArchive: () => _archiveItem(index),
                    showEdit: true,
                    showDelete: true,
                    showArchive: true,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: item['color'].withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              Icons.star,
                              color: item['color'],
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  item['subtitle'],
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSwipeableDemo extends StatefulWidget {
  const CustomSwipeableDemo({super.key});

  @override
  State<CustomSwipeableDemo> createState() => _CustomSwipeableDemoState();
}

class _CustomSwipeableDemoState extends State<CustomSwipeableDemo> {
  final List<Map<String, dynamic>> _emails = [];

  @override
  void initState() {
    super.initState();
    _loadEmails();
  }

  void _loadEmails() {
    _emails.clear();
    for (int i = 1; i <= 8; i++) {
      _emails.add({
        'id': i,
        'from': 'sender$i@example.com',
        'subject': 'Email subject $i',
        'preview': 'This is a preview of email $i with some content...',
        'time': '${i}h ago',
        'isRead': i % 3 == 0,
        'isImportant': i % 4 == 0,
      });
    }
  }

  void _markAsRead(int index) {
    setState(() {
      _emails[index]['isRead'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Marked as read: ${_emails[index]['subject']}')),
    );
  }

  void _markAsImportant(int index) {
    setState(() {
      _emails[index]['isImportant'] = !_emails[index]['isImportant'];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${_emails[index]['isImportant'] ? 'Marked' : 'Unmarked'} as important: ${_emails[index]['subject']}',
        ),
      ),
    );
  }

  void _deleteEmail(int index) {
    setState(() {
      _emails.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted: ${_emails[index]['subject']}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Swipeable Demo'),
        actions: [
          ShadButton(
            onPressed: () {
              setState(() {
                _loadEmails();
              });
            },
            variant: ShadButtonVariant.outline,
            size: ShadButtonSize.sm,
            child: const Text('Reset'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Swipe left or right for different actions',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _emails.length,
              itemBuilder: (context, index) {
                final email = _emails[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: ShadSwipeableListItem(
                    leadingActions: [
                      ShadSwipeAction(
                        title: 'Read',
                        icon: Icons.mark_email_read,
                        onPressed: () => _markAsRead(index),
                        backgroundColor: Colors.blue,
                      ),
                    ],
                    trailingActions: [
                      ShadSwipeAction(
                        title: 'Important',
                        icon: email['isImportant']
                            ? Icons.star
                            : Icons.star_border,
                        onPressed: () => _markAsImportant(index),
                        backgroundColor: Colors.orange,
                      ),
                      ShadSwipeAction(
                        title: 'Delete',
                        icon: Icons.delete,
                        onPressed: () => _deleteEmail(index),
                        backgroundColor: Colors.red,
                        isDestructive: true,
                      ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: email['isRead']
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primaryContainer
                                  .withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: email['isImportant']
                              ? Colors.orange
                              : Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.2),
                          width: email['isImportant'] ? 2.0 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (email['isImportant'])
                            Icon(Icons.star, color: Colors.orange, size: 16),
                          if (!email['isRead'])
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  email['from'],
                                  style: TextStyle(
                                    fontWeight: email['isRead']
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  email['subject'],
                                  style: TextStyle(
                                    fontWeight: email['isRead']
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  email['preview'],
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            email['time'],
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
