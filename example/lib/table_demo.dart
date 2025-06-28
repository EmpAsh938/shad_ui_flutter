import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class TableDemo extends StatefulWidget {
  const TableDemo({super.key});

  @override
  State<TableDemo> createState() => _TableDemoState();
}

class _TableDemoState extends State<TableDemo> {
  ShadTableVariant _variant = ShadTableVariant.default_;
  ShadTableSize _size = ShadTableSize.md;
  bool _sortable = true;
  bool _filterable = true;
  bool _selectable = true;
  bool _paginated = true;
  bool _striped = false;
  bool _hoverable = true;

  final List<User> _users = [
    User(
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      role: 'Admin',
      status: 'Active',
      lastLogin: DateTime.now().subtract(const Duration(days: 2)),
    ),
    User(
      id: 2,
      name: 'Jane Smith',
      email: 'jane@example.com',
      role: 'User',
      status: 'Active',
      lastLogin: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    User(
      id: 3,
      name: 'Bob Johnson',
      email: 'bob@example.com',
      role: 'Moderator',
      status: 'Inactive',
      lastLogin: DateTime.now().subtract(const Duration(days: 10)),
    ),
    User(
      id: 4,
      name: 'Alice Brown',
      email: 'alice@example.com',
      role: 'User',
      status: 'Active',
      lastLogin: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    User(
      id: 5,
      name: 'Charlie Wilson',
      email: 'charlie@example.com',
      role: 'Admin',
      status: 'Active',
      lastLogin: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    User(
      id: 6,
      name: 'Diana Davis',
      email: 'diana@example.com',
      role: 'User',
      status: 'Inactive',
      lastLogin: DateTime.now().subtract(const Duration(days: 15)),
    ),
    User(
      id: 7,
      name: 'Eve Miller',
      email: 'eve@example.com',
      role: 'Moderator',
      status: 'Active',
      lastLogin: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    User(
      id: 8,
      name: 'Frank Garcia',
      email: 'frank@example.com',
      role: 'User',
      status: 'Active',
      lastLogin: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  late List<ShadTableColumn<User>> _columns;

  @override
  void initState() {
    super.initState();
    _initializeColumns();
  }

  void _initializeColumns() {
    _columns = [
      ShadTableColumn<User>(header: 'ID', getData: (user) => user.id, flex: 1),
      ShadTableColumn<User>(
        header: 'Name',
        getData: (user) => user.name,
        flex: 2,
      ),
      ShadTableColumn<User>(
        header: 'Email',
        getData: (user) => user.email,
        flex: 3,
      ),
      ShadTableColumn<User>(
        header: 'Role',
        getData: (user) => user.role,
        flex: 2,
        builder: (data, user) => _buildRoleBadge(user.role),
      ),
      ShadTableColumn<User>(
        header: 'Status',
        getData: (user) => user.status,
        flex: 2,
        builder: (data, user) => _buildStatusBadge(user.status),
      ),
      ShadTableColumn<User>(
        header: 'Last Login',
        getData: (user) => user.lastLogin,
        flex: 2,
        builder: (data, user) => _buildLastLogin(user.lastLogin),
      ),
    ];
  }

  Widget _buildRoleBadge(String role) {
    ShadBadgeVariant variant;
    switch (role.toLowerCase()) {
      case 'admin':
        variant = ShadBadgeVariant.destructive;
        break;
      case 'moderator':
        variant = ShadBadgeVariant.outline;
        break;
      default:
        variant = ShadBadgeVariant.secondary;
    }

    return ShadBadge(variant: variant, child: Text(role));
  }

  Widget _buildStatusBadge(String status) {
    final isActive = status.toLowerCase() == 'active';
    return ShadBadge(
      variant: isActive
          ? ShadBadgeVariant.default_
          : ShadBadgeVariant.secondary,
      child: Text(status),
    );
  }

  Widget _buildLastLogin(DateTime lastLogin) {
    final now = DateTime.now();
    final difference = now.difference(lastLogin);

    String text;
    if (difference.inMinutes < 60) {
      text = '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      text = '${difference.inHours}h ago';
    } else {
      text = '${difference.inDays}d ago';
    }

    return Text(
      text,
      style: TextStyle(
        color: difference.inDays > 7 ? Colors.orange : null,
        fontWeight: difference.inDays > 7 ? FontWeight.w500 : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Demo'),
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
                children: ShadTableVariant.values.map((variant) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          variant.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadTable<User>(
                          variant: variant,
                          columns: _columns,
                          data: _users.take(3).toList(),
                          sortable: true,
                          filterable: true,
                          selectable: true,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Sizes
            _buildSection(
              'Sizes',
              Column(
                children: ShadTableSize.values.map((size) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ShadSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          size.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: ShadSpacing.sm),
                        ShadTable<User>(
                          size: size,
                          columns: _columns,
                          data: _users.take(3).toList(),
                          sortable: true,
                          filterable: true,
                          selectable: true,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: ShadSpacing.xl),

            // Features
            _buildSection(
              'Features',
              Column(
                children: [
                  // Striped rows
                  const Text(
                    'Striped Rows',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  ShadTable<User>(
                    columns: _columns,
                    data: _users.take(5).toList(),
                    striped: true,
                    sortable: true,
                    filterable: true,
                    selectable: true,
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Pagination
                  const Text(
                    'Pagination',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  ShadTable<User>(
                    columns: _columns,
                    data: _users,
                    paginated: true,
                    itemsPerPage: 3,
                    sortable: true,
                    filterable: true,
                    selectable: true,
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
                  // Variant selector
                  Row(
                    children: [
                      const Text('Variant: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadTableVariant>(
                        value: _variant,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _variant = value);
                          }
                        },
                        items: ShadTableVariant.values.map((variant) {
                          return DropdownMenuItem(
                            value: variant,
                            child: Text(variant.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Size selector
                  Row(
                    children: [
                      const Text('Size: '),
                      const SizedBox(width: ShadSpacing.sm),
                      DropdownButton<ShadTableSize>(
                        value: _size,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _size = value);
                          }
                        },
                        items: ShadTableSize.values.map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(size.name),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  // Feature toggles
                  Row(
                    children: [
                      const Text('Features: '),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _sortable,
                        onChanged: (value) =>
                            setState(() => _sortable = value ?? false),
                      ),
                      const Text('Sortable'),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _filterable,
                        onChanged: (value) =>
                            setState(() => _filterable = value ?? false),
                      ),
                      const Text('Filterable'),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _selectable,
                        onChanged: (value) =>
                            setState(() => _selectable = value ?? false),
                      ),
                      const Text('Selectable'),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.md),

                  Row(
                    children: [
                      Checkbox(
                        value: _paginated,
                        onChanged: (value) =>
                            setState(() => _paginated = value ?? false),
                      ),
                      const Text('Paginated'),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _striped,
                        onChanged: (value) =>
                            setState(() => _striped = value ?? false),
                      ),
                      const Text('Striped'),
                      const SizedBox(width: ShadSpacing.sm),
                      Checkbox(
                        value: _hoverable,
                        onChanged: (value) =>
                            setState(() => _hoverable = value ?? false),
                      ),
                      const Text('Hoverable'),
                    ],
                  ),

                  const SizedBox(height: ShadSpacing.lg),

                  // Preview
                  const Text(
                    'Preview',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: ShadSpacing.sm),
                  ShadTable<User>(
                    variant: _variant,
                    size: _size,
                    columns: _columns,
                    data: _users,
                    sortable: _sortable,
                    filterable: _filterable,
                    selectable: _selectable,
                    paginated: _paginated,
                    itemsPerPage: 5,
                    striped: _striped,
                    hoverable: _hoverable,
                    onSelectionChanged: (selectedItems) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Selected ${selectedItems.length} items',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    onSort: (columnIndex, direction) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Sorted column $columnIndex: ${direction.name}',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    onFilter: (filterText) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Filtered: $filterText'),
                          duration: const Duration(seconds: 1),
                        ),
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

class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String status;
  final DateTime lastLogin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.lastLogin,
  });
}
