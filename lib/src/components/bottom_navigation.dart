import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tokens/tokens.dart';
import '../theme/shad_theme.dart';

/// A mobile-specific bottom navigation component with customizable tabs,
/// animations, and modern design.
class ShadBottomNavigation extends StatefulWidget {
  /// Creates a bottom navigation widget.
  const ShadBottomNavigation({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.type = ShadBottomNavigationType.fixed,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.iconSize = 24.0,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = false,
    this.enableFeedback = true,
    this.landscapeLayout = ShadBottomNavigationLandscapeLayout.centered,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  /// The items to display in the bottom navigation.
  final List<ShadBottomNavigationItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// Callback when an item is tapped.
  final ValueChanged<int> onTap;

  /// The type of bottom navigation.
  final ShadBottomNavigationType type;

  /// Background color of the bottom navigation.
  final Color? backgroundColor;

  /// Color of the selected item.
  final Color? selectedItemColor;

  /// Color of the unselected items.
  final Color? unselectedItemColor;

  /// Elevation of the bottom navigation.
  final double elevation;

  /// Font size of the selected item label.
  final double selectedFontSize;

  /// Font size of the unselected item labels.
  final double unselectedFontSize;

  /// Text style for the selected item label.
  final TextStyle? selectedLabelStyle;

  /// Text style for the unselected item labels.
  final TextStyle? unselectedLabelStyle;

  /// Size of the icons.
  final double iconSize;

  /// Whether to show labels for selected items.
  final bool showSelectedLabels;

  /// Whether to show labels for unselected items.
  final bool showUnselectedLabels;

  /// Whether to enable haptic feedback.
  final bool enableFeedback;

  /// Layout for landscape orientation.
  final ShadBottomNavigationLandscapeLayout landscapeLayout;

  /// Duration of the animation.
  final Duration animationDuration;

  /// Curve of the animation.
  final Curve animationCurve;

  @override
  State<ShadBottomNavigation> createState() => _ShadBottomNavigationState();
}

class _ShadBottomNavigationState extends State<ShadBottomNavigation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    return widget.backgroundColor ?? theme.cardColor;
  }

  Color _getSelectedColor(ShadThemeData theme) {
    return widget.selectedItemColor ?? theme.primaryColor;
  }

  Color _getUnselectedColor(ShadThemeData theme) {
    return widget.unselectedItemColor ??
        ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 500 : 400,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(theme),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: widget.elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 60.0,
          padding: const EdgeInsets.symmetric(horizontal: ShadSpacing.sm),
          child: Row(
            children: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.currentIndex;

              return Expanded(
                child: _buildNavigationItem(
                  item: item,
                  index: index,
                  isSelected: isSelected,
                  theme: theme,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required ShadBottomNavigationItem item,
    required int index,
    required bool isSelected,
    required ShadThemeData theme,
  }) {
    final selectedColor = _getSelectedColor(theme);
    final unselectedColor = _getUnselectedColor(theme);
    final currentColor = isSelected ? selectedColor : unselectedColor;

    return GestureDetector(
      onTap: () {
        if (widget.enableFeedback) {
          HapticFeedback.lightImpact();
        }
        widget.onTap(index);
      },
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        padding: const EdgeInsets.symmetric(vertical: ShadSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(ShadRadius.md),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            AnimatedContainer(
              duration: widget.animationDuration,
              curve: widget.animationCurve,
              child: Icon(
                isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
                color: currentColor,
                size: widget.iconSize,
              ),
            ),

            // Label
            if ((isSelected && widget.showSelectedLabels) ||
                (!isSelected && widget.showUnselectedLabels)) ...[
              const SizedBox(height: ShadSpacing.xs),
              AnimatedDefaultTextStyle(
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                style:
                    (isSelected
                        ? widget.selectedLabelStyle
                        : widget.unselectedLabelStyle) ??
                    TextStyle(
                      color: currentColor,
                      fontSize: isSelected
                          ? widget.selectedFontSize
                          : widget.unselectedFontSize,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                child: Text(item.label, textAlign: TextAlign.center),
              ),
            ],

            // Badge
            if (item.badge != null) ...[
              const SizedBox(height: ShadSpacing.xs),
              item.badge!,
            ],
          ],
        ),
      ),
    );
  }
}

/// An item in the bottom navigation.
class ShadBottomNavigationItem {
  /// Creates a bottom navigation item.
  const ShadBottomNavigationItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
    this.onTap,
  });

  /// The icon to display.
  final IconData icon;

  /// The label to display.
  final String label;

  /// The icon to display when selected.
  final IconData? selectedIcon;

  /// Optional badge to display.
  final Widget? badge;

  /// Callback when the item is tapped.
  final VoidCallback? onTap;
}

/// Type of bottom navigation.
enum ShadBottomNavigationType {
  /// Fixed type with labels always visible.
  fixed,

  /// Shifting type with animated labels.
  shifting,
}

/// Layout for landscape orientation.
enum ShadBottomNavigationLandscapeLayout {
  /// Centered layout.
  centered,

  /// Spread layout.
  spread,
}

/// A bottom navigation bar with a modern design.
class ShadBottomNavigationBar extends StatelessWidget {
  /// Creates a bottom navigation bar.
  const ShadBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
    this.type = ShadBottomNavigationType.fixed,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = false,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.iconSize = 24.0,
    this.enableFeedback = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  /// The items to display.
  final List<ShadBottomNavigationItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// Callback when an item is tapped.
  final ValueChanged<int> onTap;

  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// Color of the selected item.
  final Color? selectedItemColor;

  /// Color of the unselected items.
  final Color? unselectedItemColor;

  /// Elevation of the navigation bar.
  final double elevation;

  /// The type of bottom navigation.
  final ShadBottomNavigationType type;

  /// Whether to show labels for selected items.
  final bool showSelectedLabels;

  /// Whether to show labels for unselected items.
  final bool showUnselectedLabels;

  /// Font size of the selected item label.
  final double selectedFontSize;

  /// Font size of the unselected item labels.
  final double unselectedFontSize;

  /// Size of the icons.
  final double iconSize;

  /// Whether to enable haptic feedback.
  final bool enableFeedback;

  /// Duration of the animation.
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return ShadBottomNavigation(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      type: type,
      backgroundColor: backgroundColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      elevation: elevation,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      iconSize: iconSize,
      enableFeedback: enableFeedback,
      animationDuration: animationDuration,
    );
  }
}
