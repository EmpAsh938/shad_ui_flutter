import 'package:flutter/material.dart';
import '../theme/shad_theme.dart';
import '../tokens/tokens.dart';

enum ShadPaginationVariant { default_, outline, ghost }

enum ShadPaginationSize { sm, md, lg }

enum ShadPaginationLayout { default_, compact, extended }

class ShadPagination extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final ShadPaginationVariant variant;
  final ShadPaginationSize size;
  final ShadPaginationLayout layout;
  final ValueChanged<int>? onPageChanged;
  final bool showFirstLast;
  final bool showPrevNext;
  final bool showPageNumbers;
  final bool showItemsInfo;
  final bool showItemsPerPage;
  final List<int>? itemsPerPageOptions;
  final ValueChanged<int>? onItemsPerPageChanged;
  final String? firstPageText;
  final String? lastPageText;
  final String? prevPageText;
  final String? nextPageText;
  final String? itemsInfoText;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? activeTextColor;
  final Color? activeBackgroundColor;
  final Color? hoverColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.totalItems = 0,
    this.itemsPerPage = 10,
    this.variant = ShadPaginationVariant.default_,
    this.size = ShadPaginationSize.md,
    this.layout = ShadPaginationLayout.default_,
    this.onPageChanged,
    this.showFirstLast = true,
    this.showPrevNext = true,
    this.showPageNumbers = true,
    this.showItemsInfo = false,
    this.showItemsPerPage = false,
    this.itemsPerPageOptions,
    this.onItemsPerPageChanged,
    this.firstPageText,
    this.lastPageText,
    this.prevPageText,
    this.nextPageText,
    this.itemsInfoText,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.activeTextColor,
    this.activeBackgroundColor,
    this.hoverColor,
    this.padding,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadPagination> createState() => _ShadPaginationState();
}

class _ShadPaginationState extends State<ShadPagination>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ShadPaginationSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadPaginationSize.sm:
        return ShadPaginationSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.sm,
            vertical: ShadSpacing.xs,
          ),
          fontSize: ShadTypography.fontSizeSm,
          iconSize: 16,
          borderRadius: ShadRadius.sm,
          buttonSize: 32,
        );
      case ShadPaginationSize.lg:
        return ShadPaginationSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.lg,
            vertical: ShadSpacing.md,
          ),
          fontSize: ShadTypography.fontSizeLg,
          iconSize: 24,
          borderRadius: ShadRadius.lg,
          buttonSize: 48,
        );
      case ShadPaginationSize.md:
      default:
        return ShadPaginationSizeTokens(
          padding: const EdgeInsets.symmetric(
            horizontal: ShadSpacing.md,
            vertical: ShadSpacing.sm,
          ),
          fontSize: ShadTypography.fontSizeMd,
          iconSize: 20,
          borderRadius: ShadRadius.md,
          buttonSize: 40,
        );
    }
  }

  ShadPaginationVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadPaginationVariant.default_:
        return ShadPaginationVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          activeTextColor: widget.activeTextColor ?? theme.primaryColor,
          activeBackgroundColor:
              widget.activeBackgroundColor ?? theme.primaryColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadPaginationVariant.outline:
        return ShadPaginationVariantTokens(
          backgroundColor: widget.backgroundColor ?? theme.backgroundColor,
          borderColor: widget.borderColor ?? theme.borderColor,
          textColor: widget.textColor ?? theme.textColor,
          activeTextColor: widget.activeTextColor ?? theme.primaryColor,
          activeBackgroundColor:
              widget.activeBackgroundColor ?? theme.primaryColor,
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
      case ShadPaginationVariant.ghost:
        return ShadPaginationVariantTokens(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          borderColor: widget.borderColor ?? Colors.transparent,
          textColor: widget.textColor ?? theme.textColor,
          activeTextColor: widget.activeTextColor ?? theme.primaryColor,
          activeBackgroundColor:
              widget.activeBackgroundColor ??
              theme.primaryColor.withValues(alpha: 0.1),
          hoverColor:
              widget.hoverColor ?? theme.mutedColor.withValues(alpha: 0.1),
        );
    }
  }

  List<int> _getVisiblePages() {
    final currentPage = widget.currentPage;
    final totalPages = widget.totalPages;

    if (totalPages <= 7) {
      return List.generate(totalPages, (index) => index + 1);
    }

    final List<int> pages = [];

    if (currentPage <= 4) {
      // Show first 5 pages + ellipsis + last page
      for (int i = 1; i <= 5; i++) {
        pages.add(i);
      }
      pages.add(-1); // Ellipsis
      pages.add(totalPages);
    } else if (currentPage >= totalPages - 3) {
      // Show first page + ellipsis + last 5 pages
      pages.add(1);
      pages.add(-1); // Ellipsis
      for (int i = totalPages - 4; i <= totalPages; i++) {
        pages.add(i);
      }
    } else {
      // Show first page + ellipsis + current-1, current, current+1 + ellipsis + last page
      pages.add(1);
      pages.add(-1); // Ellipsis
      pages.add(currentPage - 1);
      pages.add(currentPage);
      pages.add(currentPage + 1);
      pages.add(-1); // Ellipsis
      pages.add(totalPages);
    }

    return pages;
  }

  void _handlePageChange(int page) {
    if (page >= 1 && page <= widget.totalPages && page != widget.currentPage) {
      widget.onPageChanged?.call(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final variantTokens = _getVariantTokens(theme);
    final visiblePages = _getVisiblePages();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          padding: widget.padding ?? sizeTokens.padding,
          decoration: BoxDecoration(
            color: variantTokens.backgroundColor,
            border: widget.variant == ShadPaginationVariant.outline
                ? Border.all(color: variantTokens.borderColor)
                : null,
            borderRadius:
                widget.borderRadius ??
                BorderRadius.circular(sizeTokens.borderRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main pagination controls
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // First page button
                  if (widget.showFirstLast)
                    _buildPageButton(
                      icon: Icons.first_page,
                      isActive: false,
                      isDisabled: widget.currentPage == 1,
                      onTap: () => _handlePageChange(1),
                      sizeTokens: sizeTokens,
                      variantTokens: variantTokens,
                      tooltip: widget.firstPageText ?? 'First page',
                    ),

                  // Previous page button
                  if (widget.showPrevNext) ...[
                    if (widget.showFirstLast)
                      const SizedBox(width: ShadSpacing.xs),
                    _buildPageButton(
                      icon: Icons.chevron_left,
                      isActive: false,
                      isDisabled: widget.currentPage == 1,
                      onTap: () => _handlePageChange(widget.currentPage - 1),
                      sizeTokens: sizeTokens,
                      variantTokens: variantTokens,
                      tooltip: widget.prevPageText ?? 'Previous page',
                    ),
                  ],

                  // Page numbers
                  if (widget.showPageNumbers) ...[
                    if (widget.showPrevNext)
                      const SizedBox(width: ShadSpacing.sm),
                    ...visiblePages.map((page) {
                      if (page == -1) {
                        // Ellipsis
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: ShadSpacing.xs,
                          ),
                          child: Text(
                            '...',
                            style: TextStyle(
                              fontSize: sizeTokens.fontSize,
                              color: variantTokens.textColor,
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: ShadSpacing.xs),
                        child: _buildPageButton(
                          text: page.toString(),
                          isActive: page == widget.currentPage,
                          isDisabled: false,
                          onTap: () => _handlePageChange(page),
                          sizeTokens: sizeTokens,
                          variantTokens: variantTokens,
                        ),
                      );
                    }).toList(),
                  ],

                  // Next page button
                  if (widget.showPrevNext) ...[
                    if (widget.showPageNumbers)
                      const SizedBox(width: ShadSpacing.sm),
                    _buildPageButton(
                      icon: Icons.chevron_right,
                      isActive: false,
                      isDisabled: widget.currentPage == widget.totalPages,
                      onTap: () => _handlePageChange(widget.currentPage + 1),
                      sizeTokens: sizeTokens,
                      variantTokens: variantTokens,
                      tooltip: widget.nextPageText ?? 'Next page',
                    ),
                  ],

                  // Last page button
                  if (widget.showFirstLast) ...[
                    if (widget.showPrevNext)
                      const SizedBox(width: ShadSpacing.xs),
                    _buildPageButton(
                      icon: Icons.last_page,
                      isActive: false,
                      isDisabled: widget.currentPage == widget.totalPages,
                      onTap: () => _handlePageChange(widget.totalPages),
                      sizeTokens: sizeTokens,
                      variantTokens: variantTokens,
                      tooltip: widget.lastPageText ?? 'Last page',
                    ),
                  ],
                ],
              ),

              // Items info and per-page selector
              if (widget.showItemsInfo || widget.showItemsPerPage) ...[
                const SizedBox(height: ShadSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Items info
                    if (widget.showItemsInfo)
                      Text(
                        widget.itemsInfoText ??
                            'Showing ${((widget.currentPage - 1) * widget.itemsPerPage) + 1} to ${widget.currentPage * widget.itemsPerPage > widget.totalItems ? widget.totalItems : widget.currentPage * widget.itemsPerPage} of ${widget.totalItems} items',
                        style: TextStyle(
                          fontSize: sizeTokens.fontSize * 0.9,
                          color: variantTokens.textColor,
                        ),
                      ),

                    // Items per page selector
                    if (widget.showItemsPerPage &&
                        widget.itemsPerPageOptions != null)
                      Row(
                        children: [
                          Text(
                            'Items per page: ',
                            style: TextStyle(
                              fontSize: sizeTokens.fontSize * 0.9,
                              color: variantTokens.textColor,
                            ),
                          ),
                          const SizedBox(width: ShadSpacing.xs),
                          DropdownButton<int>(
                            value: widget.itemsPerPage,
                            onChanged: (value) {
                              if (value != null) {
                                widget.onItemsPerPageChanged?.call(value);
                              }
                            },
                            items: widget.itemsPerPageOptions!.map((option) {
                              return DropdownMenuItem(
                                value: option,
                                child: Text(option.toString()),
                              );
                            }).toList(),
                            style: TextStyle(
                              fontSize: sizeTokens.fontSize * 0.9,
                              color: variantTokens.textColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageButton({
    String? text,
    IconData? icon,
    required bool isActive,
    required bool isDisabled,
    required VoidCallback onTap,
    required ShadPaginationSizeTokens sizeTokens,
    required ShadPaginationVariantTokens variantTokens,
    String? tooltip,
  }) {
    final button = GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: MouseRegion(
        cursor: isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: widget.animationDuration,
          width: sizeTokens.buttonSize,
          height: sizeTokens.buttonSize,
          decoration: BoxDecoration(
            color: isActive
                ? variantTokens.activeBackgroundColor
                : isDisabled
                ? variantTokens.hoverColor.withValues(alpha: 0.5)
                : Colors.transparent,
            border: widget.variant == ShadPaginationVariant.outline
                ? Border.all(
                    color: isActive
                        ? variantTokens.activeBackgroundColor
                        : variantTokens.borderColor,
                    width: 1.0,
                  )
                : null,
            borderRadius: BorderRadius.circular(sizeTokens.borderRadius),
          ),
          child: Center(
            child: text != null
                ? Text(
                    text,
                    style: TextStyle(
                      fontSize: sizeTokens.fontSize,
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isActive
                          ? Colors.white
                          : isDisabled
                          ? variantTokens.textColor.withValues(alpha: 0.5)
                          : variantTokens.textColor,
                    ),
                  )
                : Icon(
                    icon,
                    size: sizeTokens.iconSize,
                    color: isActive
                        ? Colors.white
                        : isDisabled
                        ? variantTokens.textColor.withValues(alpha: 0.5)
                        : variantTokens.textColor,
                  ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip, child: button);
    }

    return button;
  }
}

class ShadPaginationSizeTokens {
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final double iconSize;
  final double borderRadius;
  final double buttonSize;

  const ShadPaginationSizeTokens({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.borderRadius,
    required this.buttonSize,
  });
}

class ShadPaginationVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color activeTextColor;
  final Color activeBackgroundColor;
  final Color hoverColor;

  const ShadPaginationVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.activeTextColor,
    required this.activeBackgroundColor,
    required this.hoverColor,
  });
}
