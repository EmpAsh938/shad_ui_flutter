import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class PullToRefreshDemo extends StatefulWidget {
  const PullToRefreshDemo({super.key});

  @override
  State<PullToRefreshDemo> createState() => _PullToRefreshDemoState();
}

class _PullToRefreshDemoState extends State<PullToRefreshDemo> {
  final List<String> _items = [];
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    for (int i = 0; i < 10; i++) {
      _items.add('Item ${_counter++}');
    }
  }

  Future<void> _onRefresh() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _items.clear();
      for (int i = 0; i < 10; i++) {
        _items.add('Refreshed Item ${_counter++}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pull to Refresh Demo')),
      body: ShadPullToRefresh(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(_items[index]),
              subtitle: Text(
                'Last updated: ${DateTime.now().toString().substring(11, 19)}',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
        ),
      ),
    );
  }
}

class CustomPullToRefreshDemo extends StatefulWidget {
  const CustomPullToRefreshDemo({super.key});

  @override
  State<CustomPullToRefreshDemo> createState() =>
      _CustomPullToRefreshDemoState();
}

class _CustomPullToRefreshDemoState extends State<CustomPullToRefreshDemo> {
  final List<Map<String, dynamic>> _posts = [];
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialPosts();
  }

  void _loadInitialPosts() {
    for (int i = 0; i < 5; i++) {
      _posts.add({
        'id': _counter++,
        'title': 'Post ${_counter}',
        'content':
            'This is the content of post ${_counter}. It contains some sample text to demonstrate the pull to refresh functionality.',
        'author': 'Author ${_counter}',
        'timestamp': DateTime.now().subtract(Duration(hours: _counter)),
      });
    }
  }

  Future<void> _onRefresh() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _posts.clear();
      for (int i = 0; i < 5; i++) {
        _posts.add({
          'id': _counter++,
          'title': 'Updated Post ${_counter}',
          'content':
              'This post was refreshed at ${DateTime.now().toString().substring(11, 19)}. The content has been updated.',
          'author': 'Author ${_counter}',
          'timestamp': DateTime.now(),
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Pull to Refresh Demo')),
      body: ShadCustomPullToRefresh(
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            final post = _posts[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text(
                            post['author'].toString().split(' ').last,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'By ${post['author']} • ${_formatTimestamp(post['timestamp'])}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(post['content'], style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.thumb_up, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${(post['id'] * 7) % 100}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.comment, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${(post['id'] * 3) % 20}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.share, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${(post['id'] * 2) % 10}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
