import 'package:flutter/material.dart';
import '../tokens/tokens.dart';
import '../theme/shad_theme.dart';

/// A mobile-specific bottom sheet component that slides up from the bottom
/// with customizable content, animations, and styling.
class ShadBottomSheet extends StatelessWidget {
  /// Creates a bottom sheet widget.
  const ShadBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showDragHandle = true,
    this.dragHandleColor,
    this.backgroundColor,
    this.elevation = 8.0,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.constraints,
    this.isScrollControlled = false,
    this.enableDrag = true,
    this.isDismissible = true,
    this.useSafeArea = true,
    this.onDismissed,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  /// The content to display in the bottom sheet.
  final Widget child;

  /// Optional title displayed at the top of the bottom sheet.
  final String? title;

  /// Optional subtitle displayed below the title.
  final String? subtitle;

  /// Whether to show the drag handle at the top of the bottom sheet.
  final bool showDragHandle;

  /// Color of the drag handle.
  final Color? dragHandleColor;

  /// Background color of the bottom sheet.
  final Color? backgroundColor;

  /// Elevation of the bottom sheet.
  final double elevation;

  /// Shape of the bottom sheet.
  final ShapeBorder? shape;

  /// Clip behavior for the bottom sheet.
  final Clip clipBehavior;

  /// Constraints for the bottom sheet.
  final BoxConstraints? constraints;

  /// Whether the bottom sheet should be scroll controlled.
  final bool isScrollControlled;

  /// Whether the bottom sheet can be dragged.
  final bool enableDrag;

  /// Whether the bottom sheet can be dismissed by tapping outside.
  final bool isDismissible;

  /// Whether to use safe area for the bottom sheet.
  final bool useSafeArea;

  /// Callback when the bottom sheet is dismissed.
  final VoidCallback? onDismissed;

  /// Duration of the animation.
  final Duration animationDuration;

  /// Curve of the animation.
  final Curve animationCurve;

  /// Shows the bottom sheet as a modal.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? subtitle,
    bool showDragHandle = true,
    Color? dragHandleColor,
    Color? backgroundColor,
    double elevation = 8.0,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.antiAlias,
    BoxConstraints? constraints,
    bool isScrollControlled = false,
    bool enableDrag = true,
    bool isDismissible = true,
    bool useSafeArea = true,
    VoidCallback? onDismissed,
    Duration animationDuration = const Duration(milliseconds: 300),
    Curve animationCurve = Curves.easeInOut,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      useSafeArea: useSafeArea,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape:
          shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(ShadRadius.lg),
            ),
          ),
      clipBehavior: clipBehavior,
      constraints: constraints,
      builder: (context) => ShadBottomSheet(
        child: child,
        title: title,
        subtitle: subtitle,
        showDragHandle: showDragHandle,
        dragHandleColor: dragHandleColor,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        isScrollControlled: isScrollControlled,
        enableDrag: enableDrag,
        isDismissible: isDismissible,
        useSafeArea: useSafeArea,
        onDismissed: onDismissed,
        animationDuration: animationDuration,
        animationCurve: animationCurve,
      ),
    );
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    return backgroundColor ?? theme.cardColor;
  }

  Color _getDragHandleColor(ShadThemeData theme) {
    return dragHandleColor ??
        ShadBaseColors.getColor(
          theme.baseColor,
          theme.brightness == Brightness.light ? 300 : 600,
        );
  }

  Color _getTitleColor(ShadThemeData theme) {
    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 900 : 50,
    );
  }

  Color _getSubtitleColor(ShadThemeData theme) {
    return ShadBaseColors.getColor(
      theme.baseColor,
      theme.brightness == Brightness.light ? 600 : 400,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(theme),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(ShadRadius.lg),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDragHandle) _buildDragHandle(theme),
          if (title != null || subtitle != null) _buildHeader(theme),
          Flexible(child: child),
        ],
      ),
    );
  }

  Widget _buildDragHandle(ShadThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(top: ShadSpacing.sm),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: _getDragHandleColor(theme),
          borderRadius: BorderRadius.circular(ShadRadius.full),
        ),
      ),
    );
  }

  Widget _buildHeader(ShadThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(ShadSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                fontSize: ShadTypography.fontSizeLg,
                fontWeight: FontWeight.w600,
                color: _getTitleColor(theme),
              ),
            ),
          if (subtitle != null) ...[
            const SizedBox(height: ShadSpacing.xs),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: ShadTypography.fontSizeMd,
                color: _getSubtitleColor(theme),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A specialized bottom sheet for action menus.
class ShadActionSheet extends StatelessWidget {
  /// Creates an action sheet widget.
  const ShadActionSheet({
    super.key,
    required this.actions,
    this.title,
    this.cancelAction,
    this.backgroundColor,
    this.actionTextColor,
    this.cancelTextColor,
    this.destructiveActionColor,
  });

  /// List of actions to display.
  final List<ShadActionSheetAction> actions;

  /// Optional title for the action sheet.
  final String? title;

  /// Optional cancel action.
  final ShadActionSheetAction? cancelAction;

  /// Background color of the action sheet.
  final Color? backgroundColor;

  /// Text color for actions.
  final Color? actionTextColor;

  /// Text color for cancel action.
  final Color? cancelTextColor;

  /// Color for destructive actions.
  final Color? destructiveActionColor;

  /// Shows the action sheet as a modal.
  static Future<T?> show<T>({
    required BuildContext context,
    required List<ShadActionSheetAction> actions,
    String? title,
    ShadActionSheetAction? cancelAction,
    Color? backgroundColor,
    Color? actionTextColor,
    Color? cancelTextColor,
    Color? destructiveActionColor,
  }) {
    return ShadBottomSheet.show<T>(
      context: context,
      child: ShadActionSheet(
        actions: actions,
        title: title,
        cancelAction: cancelAction,
        backgroundColor: backgroundColor,
        actionTextColor: actionTextColor,
        cancelTextColor: cancelTextColor,
        destructiveActionColor: destructiveActionColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) _buildTitle(colorScheme),
        ...actions.map((action) => _buildAction(context, action, colorScheme)),
        if (cancelAction != null) ...[
          const SizedBox(height: ShadSpacing.xs),
          _buildCancelAction(context, cancelAction!, colorScheme),
        ],
        SizedBox(
          height: MediaQuery.of(context).padding.bottom + ShadSpacing.sm,
        ),
      ],
    );
  }

  Widget _buildTitle(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(ShadSpacing.md),
      child: Text(
        title!,
        style: TextStyle(
          fontSize: ShadTypography.fontSizeMd,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAction(
    BuildContext context,
    ShadActionSheetAction action,
    ColorScheme colorScheme,
  ) {
    final isDestructive = action.isDestructive;
    final textColor = isDestructive
        ? (destructiveActionColor ?? colorScheme.error)
        : (actionTextColor ?? colorScheme.primary);

    return InkWell(
      onTap: () {
        Navigator.of(context).pop(action.value);
        action.onPressed?.call();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: ShadSpacing.md,
          horizontal: ShadSpacing.lg,
        ),
        child: Text(
          action.title,
          style: TextStyle(
            fontSize: ShadTypography.fontSizeMd,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCancelAction(
    BuildContext context,
    ShadActionSheetAction action,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(ShadRadius.md),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          action.onPressed?.call();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: ShadSpacing.md,
            horizontal: ShadSpacing.lg,
          ),
          child: Text(
            action.title,
            style: TextStyle(
              fontSize: ShadTypography.fontSizeMd,
              fontWeight: FontWeight.w600,
              color: cancelTextColor ?? colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// Represents an action in an action sheet.
class ShadActionSheetAction<T> {
  /// Creates an action sheet action.
  const ShadActionSheetAction({
    required this.title,
    this.value,
    this.onPressed,
    this.isDestructive = false,
  });

  /// The title of the action.
  final String title;

  /// The value to return when this action is selected.
  final T? value;

  /// Callback when the action is pressed.
  final VoidCallback? onPressed;

  /// Whether this is a destructive action.
  final bool isDestructive;
}
