import 'package:flutter/material.dart';
import '../tokens/tokens.dart';
import '../theme/shad_theme.dart';

/// A mobile-specific swipeable list item component that reveals action buttons
/// when swiped left or right.
class ShadSwipeableListItem extends StatefulWidget {
  /// Creates a swipeable list item widget.
  const ShadSwipeableListItem({
    super.key,
    required this.child,
    this.leadingActions = const [],
    this.trailingActions = const [],
    this.background,
    this.foreground,
    this.direction = DismissDirection.endToStart,
    this.resizeDuration = const Duration(milliseconds: 300),
    this.dismissThresholds = const {},
    this.movementDuration = const Duration(milliseconds: 200),
    this.crossAxisEndOffset = 0.0,
    this.behavior = HitTestBehavior.opaque,
    this.onDismissed,
    this.onResize,
    this.confirmDismiss,
    this.onUpdate,
  });

  /// The content of the list item.
  final Widget child;

  /// Actions to show when swiping from left to right (leading edge).
  final List<ShadSwipeAction> leadingActions;

  /// Actions to show when swiping from right to left (trailing edge).
  final List<ShadSwipeAction> trailingActions;

  /// Background widget shown behind the content.
  final Widget? background;

  /// Foreground widget shown in front of the content.
  final Widget? foreground;

  /// The direction in which the item can be dismissed.
  final DismissDirection direction;

  /// The duration of the resize animation.
  final Duration resizeDuration;

  /// The threshold for each direction that the item has to be dragged in order to be dismissed.
  final Map<DismissDirection, double> dismissThresholds;

  /// The duration of the movement animation.
  final Duration movementDuration;

  /// The offset from the end of the cross axis.
  final double crossAxisEndOffset;

  /// How to behave during hit tests.
  final HitTestBehavior behavior;

  /// Called when the item has been dismissed.
  final DismissDirectionCallback? onDismissed;

  /// Called when the item is being resized.
  final DismissDirectionCallback? onResize;

  /// Called to confirm whether the item should be dismissed.
  final ConfirmDismissCallback? confirmDismiss;

  /// Called when the item is being updated.
  final DismissDirectionCallback? onUpdate;

  @override
  State<ShadSwipeableListItem> createState() => _ShadSwipeableListItemState();
}

class _ShadSwipeableListItemState extends State<ShadSwipeableListItem>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _dragExtent = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.movementDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent += details.delta.dx;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;
    final shouldDismiss = _dragExtent.abs() > 100 || velocity.abs() > 500;

    if (shouldDismiss) {
      _handleDismiss();
    } else {
      _resetPosition();
    }
  }

  void _handleDismiss() async {
    final direction = _dragExtent > 0
        ? DismissDirection.startToEnd
        : DismissDirection.endToStart;

    if (widget.confirmDismiss != null) {
      final shouldDismiss = await widget.confirmDismiss!(direction);
      if (shouldDismiss != true) {
        _resetPosition();
        return;
      }
    }

    widget.onDismissed?.call(direction);
  }

  void _resetPosition() {
    _animationController.animateTo(0.0);
    setState(() {
      _dragExtent = 0.0;
    });
  }

  void _onActionPressed(ShadSwipeAction action) {
    action.onPressed?.call();
    _resetPosition();
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    return theme.cardColor;
  }

  Color _getActionBackgroundColor(ShadThemeData theme, ShadSwipeAction action) {
    return action.backgroundColor ??
        (action.isDestructive ? theme.errorColor : theme.primaryColor);
  }

  Color _getActionForegroundColor(ShadThemeData theme, ShadSwipeAction action) {
    return action.textColor ?? Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final offset = _dragExtent * 0.3; // Damping factor

          return Transform.translate(
            offset: Offset(offset, 0),
            child: Stack(
              children: [
                // Background actions
                if (_dragExtent > 0 && widget.leadingActions.isNotEmpty)
                  _buildLeadingActions(theme),
                if (_dragExtent < 0 && widget.trailingActions.isNotEmpty)
                  _buildTrailingActions(theme),

                // Main content
                Container(
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(theme),
                    borderRadius: BorderRadius.circular(ShadRadius.md),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: widget.child,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeadingActions(ShadThemeData theme) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Row(
        children: widget.leadingActions.map((action) {
          return Container(
            margin: const EdgeInsets.only(right: ShadSpacing.xs),
            child: _buildActionButton(action, theme),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTrailingActions(ShadThemeData theme) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Row(
        children: widget.trailingActions.map((action) {
          return Container(
            margin: const EdgeInsets.only(left: ShadSpacing.xs),
            child: _buildActionButton(action, theme),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButton(ShadSwipeAction action, ShadThemeData theme) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: _getActionBackgroundColor(theme, action),
        borderRadius: BorderRadius.circular(ShadRadius.md),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onActionPressed(action),
          borderRadius: BorderRadius.circular(ShadRadius.md),
          child: Container(
            padding: const EdgeInsets.all(ShadSpacing.sm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  action.icon,
                  color: _getActionForegroundColor(theme, action),
                  size: 24,
                ),
                const SizedBox(height: ShadSpacing.xs),
                Text(
                  action.title,
                  style: TextStyle(
                    color: _getActionForegroundColor(theme, action),
                    fontSize: ShadTypography.fontSizeSm,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Represents an action that can be performed by swiping.
class ShadSwipeAction {
  /// Creates a swipe action.
  const ShadSwipeAction({
    required this.title,
    this.icon,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isDestructive = false,
  });

  /// The title of the action.
  final String title;

  /// The icon for the action.
  final IconData? icon;

  /// Callback when the action is pressed.
  final VoidCallback? onPressed;

  /// Background color of the action button.
  final Color? backgroundColor;

  /// Text color of the action button.
  final Color? textColor;

  /// Whether this is a destructive action.
  final bool isDestructive;
}

/// A simple swipeable list item with predefined actions.
class ShadSimpleSwipeableItem extends StatelessWidget {
  /// Creates a simple swipeable item.
  const ShadSimpleSwipeableItem({
    super.key,
    required this.child,
    this.onDelete,
    this.onEdit,
    this.onArchive,
    this.deleteText = 'Delete',
    this.editText = 'Edit',
    this.archiveText = 'Archive',
    this.showDelete = true,
    this.showEdit = true,
    this.showArchive = false,
  });

  /// The content of the list item.
  final Widget child;

  /// Callback when delete action is pressed.
  final VoidCallback? onDelete;

  /// Callback when edit action is pressed.
  final VoidCallback? onEdit;

  /// Callback when archive action is pressed.
  final VoidCallback? onArchive;

  /// Text for the delete action.
  final String deleteText;

  /// Text for the edit action.
  final String editText;

  /// Text for the archive action.
  final String archiveText;

  /// Whether to show the delete action.
  final bool showDelete;

  /// Whether to show the edit action.
  final bool showEdit;

  /// Whether to show the archive action.
  final bool showArchive;

  @override
  Widget build(BuildContext context) {
    final trailingActions = <ShadSwipeAction>[];

    if (showEdit && onEdit != null) {
      trailingActions.add(
        ShadSwipeAction(
          title: editText,
          icon: Icons.edit,
          onPressed: onEdit,
          backgroundColor: Colors.blue,
        ),
      );
    }

    if (showArchive && onArchive != null) {
      trailingActions.add(
        ShadSwipeAction(
          title: archiveText,
          icon: Icons.archive,
          onPressed: onArchive,
          backgroundColor: Colors.orange,
        ),
      );
    }

    if (showDelete && onDelete != null) {
      trailingActions.add(
        ShadSwipeAction(
          title: deleteText,
          icon: Icons.delete,
          onPressed: onDelete,
          backgroundColor: Colors.red,
          isDestructive: true,
        ),
      );
    }

    return ShadSwipeableListItem(
      trailingActions: trailingActions,
      child: child,
    );
  }
}
