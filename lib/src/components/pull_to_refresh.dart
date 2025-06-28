import 'package:flutter/material.dart';
import '../tokens/tokens.dart';
import '../theme/shad_theme.dart';

/// A mobile-specific pull-to-refresh component with customizable indicators
/// and smooth animations.
class ShadPullToRefresh extends StatefulWidget {
  /// Creates a pull-to-refresh widget.
  const ShadPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.0,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.displacement = 40.0,
    this.onRefreshStart,
    this.onRefreshEnd,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the user has pulled down far enough to show the refresh indicator.
  final Future<void> Function() onRefresh;

  /// The color of the refresh indicator.
  final Color? color;

  /// The background color of the refresh indicator.
  final Color? backgroundColor;

  /// The width of the progress indicator's stroke.
  final double strokeWidth;

  /// A check that specifies whether a ScrollNotification should be handled by this widget.
  final ScrollNotificationPredicate notificationPredicate;

  /// The semantic label used by screen readers to announce the refresh action.
  final String? semanticsLabel;

  /// The semantic value used by screen readers to announce the refresh progress.
  final String? semanticsValue;

  /// The displacement of the refresh indicator from the top of the scrollable.
  final double displacement;

  /// Called when the refresh starts.
  final VoidCallback? onRefreshStart;

  /// Called when the refresh ends.
  final VoidCallback? onRefreshEnd;

  @override
  State<ShadPullToRefresh> createState() => _ShadPullToRefreshState();
}

class _ShadPullToRefreshState extends State<ShadPullToRefresh>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
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

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    widget.onRefreshStart?.call();

    try {
      await widget.onRefresh();
    } finally {
      setState(() {
        _isRefreshing = false;
      });
      widget.onRefreshEnd?.call();
    }
  }

  Color _getRefreshColor(ShadThemeData theme) {
    return widget.color ?? theme.primaryColor;
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    return widget.backgroundColor ?? theme.cardColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: _getRefreshColor(theme),
      backgroundColor: _getBackgroundColor(theme),
      strokeWidth: widget.strokeWidth,
      notificationPredicate: widget.notificationPredicate,
      semanticsLabel: widget.semanticsLabel,
      semanticsValue: widget.semanticsValue,
      displacement: widget.displacement,
      child: widget.child,
    );
  }
}

/// A custom pull-to-refresh indicator with modern design.
class ShadRefreshIndicator extends StatelessWidget {
  /// Creates a custom refresh indicator.
  const ShadRefreshIndicator({
    super.key,
    required this.isRefreshing,
    required this.progress,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.0,
    this.size = 40.0,
  });

  /// Whether the refresh is currently in progress.
  final bool isRefreshing;

  /// The current progress (0.0 to 1.0).
  final double progress;

  /// The color of the indicator.
  final Color? color;

  /// The background color of the indicator.
  final Color? backgroundColor;

  /// The stroke width of the indicator.
  final double strokeWidth;

  /// The size of the indicator.
  final double size;

  Color _getIndicatorColor(ShadThemeData theme) {
    return color ?? theme.primaryColor;
  }

  Color _getIndicatorBackgroundColor(ShadThemeData theme) {
    return backgroundColor ?? theme.cardColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final indicatorColor = _getIndicatorColor(theme);
    final bgColor = _getIndicatorBackgroundColor(theme);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isRefreshing)
            CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
            )
          else
            CustomPaint(
              size: Size(size, size),
              painter: _ShadRefreshPainter(
                progress: progress,
                color: indicatorColor,
                strokeWidth: strokeWidth,
              ),
            ),
        ],
      ),
    );
  }
}

/// Custom painter for the refresh indicator.
class _ShadRefreshPainter extends CustomPainter {
  const _ShadRefreshPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final startAngle = -90 * (3.14159 / 180); // Start from top
    final sweepAngle = progress * 270 * (3.14159 / 180); // Max 270 degrees

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _ShadRefreshPainter &&
        (oldDelegate.progress != progress ||
            oldDelegate.color != color ||
            oldDelegate.strokeWidth != strokeWidth);
  }
}

/// A pull-to-refresh widget with custom indicator.
class ShadCustomPullToRefresh extends StatefulWidget {
  /// Creates a custom pull-to-refresh widget.
  const ShadCustomPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.0,
    this.size = 40.0,
    this.onRefreshStart,
    this.onRefreshEnd,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the user has pulled down far enough to show the refresh indicator.
  final Future<void> Function() onRefresh;

  /// The color of the refresh indicator.
  final Color? color;

  /// The background color of the refresh indicator.
  final Color? backgroundColor;

  /// The stroke width of the indicator.
  final double strokeWidth;

  /// The size of the indicator.
  final double size;

  /// Called when the refresh starts.
  final VoidCallback? onRefreshStart;

  /// Called when the refresh ends.
  final VoidCallback? onRefreshEnd;

  @override
  State<ShadCustomPullToRefresh> createState() =>
      _ShadCustomPullToRefreshState();
}

class _ShadCustomPullToRefreshState extends State<ShadCustomPullToRefresh> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    widget.onRefreshStart?.call();

    try {
      await widget.onRefresh();
    } finally {
      setState(() {
        _isRefreshing = false;
      });
      widget.onRefreshEnd?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadPullToRefresh(
      onRefresh: _handleRefresh,
      color: widget.color,
      backgroundColor: widget.backgroundColor,
      strokeWidth: widget.strokeWidth,
      child: widget.child,
    );
  }
}
