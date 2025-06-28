import 'package:flutter/material.dart';
import 'dart:io';
import '../theme/shad_theme.dart';

enum ShadFileUploadVariant { default_, outline, filled, ghost }

enum ShadFileUploadSize { sm, md, lg }

enum ShadFileUploadState { normal, success, error, warning }

class ShadFileUpload extends StatefulWidget {
  final List<File>? files;
  final ValueChanged<List<File>>? onFilesSelected;
  final ValueChanged<File>? onFileRemoved;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? successText;
  final String? warningText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ShadFileUploadVariant variant;
  final ShadFileUploadSize size;
  final ShadFileUploadState state;
  final bool disabled;
  final bool multiple;
  final bool showPreview;
  final List<String>? allowedExtensions;
  final int? maxFiles;
  final int? maxFileSize; // in bytes
  final bool dragAndDrop;
  final String? dragText;
  final String? dropText;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadFileUpload({
    super.key,
    this.files,
    this.onFilesSelected,
    this.onFileRemoved,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.successText,
    this.warningText,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = ShadFileUploadVariant.default_,
    this.size = ShadFileUploadSize.md,
    this.state = ShadFileUploadState.normal,
    this.disabled = false,
    this.multiple = false,
    this.showPreview = true,
    this.allowedExtensions,
    this.maxFiles,
    this.maxFileSize,
    this.dragAndDrop = true,
    this.dragText,
    this.dropText,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ShadFileUpload> createState() => _ShadFileUploadState();
}

class _ShadFileUploadState extends State<ShadFileUpload>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isDragOver = false;
  List<File> _selectedFiles = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
    _selectedFiles = widget.files ?? [];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ShadFileUpload oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.files != oldWidget.files) {
      _selectedFiles = widget.files ?? [];
    }
  }

  ShadFileUploadSizeTokens _getSizeTokens() {
    switch (widget.size) {
      case ShadFileUploadSize.sm:
        return ShadFileUploadSizeTokens(
          height: 80,
          paddingX: 12,
          paddingY: 8,
          borderRadius: 6,
          borderWidth: 1,
          fontSize: 12,
          iconSize: 16,
        );
      case ShadFileUploadSize.lg:
        return ShadFileUploadSizeTokens(
          height: 120,
          paddingX: 20,
          paddingY: 16,
          borderRadius: 12,
          borderWidth: 2,
          fontSize: 16,
          iconSize: 24,
        );
      case ShadFileUploadSize.md:
        return ShadFileUploadSizeTokens(
          height: 100,
          paddingX: 16,
          paddingY: 12,
          borderRadius: 8,
          borderWidth: 1,
          fontSize: 14,
          iconSize: 20,
        );
    }
  }

  ShadFileUploadVariantTokens _getVariantTokens(ShadThemeData theme) {
    switch (widget.variant) {
      case ShadFileUploadVariant.default_:
        return ShadFileUploadVariantTokens(
          backgroundColor: theme.backgroundColor,
          borderColor: theme.borderColor,
          textColor: theme.textColor,
          dragOverColor: theme.primaryColor.withValues(alpha: 0.1),
        );
      case ShadFileUploadVariant.outline:
        return ShadFileUploadVariantTokens(
          backgroundColor: Colors.transparent,
          borderColor: theme.borderColor,
          textColor: theme.textColor,
          dragOverColor: theme.primaryColor.withValues(alpha: 0.1),
        );
      case ShadFileUploadVariant.filled:
        return ShadFileUploadVariantTokens(
          backgroundColor: theme.mutedColor.withValues(alpha: 0.1),
          borderColor: theme.borderColor,
          textColor: theme.textColor,
          dragOverColor: theme.primaryColor.withValues(alpha: 0.2),
        );
      case ShadFileUploadVariant.ghost:
        return ShadFileUploadVariantTokens(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          textColor: theme.textColor,
          dragOverColor: theme.primaryColor.withValues(alpha: 0.1),
        );
    }
  }

  Color _getBackgroundColor(ShadThemeData theme) {
    final variantTokens = _getVariantTokens(theme);
    if (widget.disabled) {
      return theme.mutedColor.withValues(alpha: 0.1);
    }
    if (_isDragOver) {
      return variantTokens.dragOverColor;
    }
    return variantTokens.backgroundColor;
  }

  Color _getBorderColor(ShadThemeData theme) {
    final variantTokens = _getVariantTokens(theme);
    if (widget.disabled) {
      return theme.mutedColor;
    }
    switch (widget.state) {
      case ShadFileUploadState.error:
        return theme.errorColor;
      case ShadFileUploadState.success:
        return theme.successColor;
      case ShadFileUploadState.warning:
        return theme.warningColor;
      case ShadFileUploadState.normal:
        if (_isDragOver) {
          return theme.primaryColor;
        }
        return variantTokens.borderColor;
    }
  }

  Color _getTextColor(ShadThemeData theme) {
    final variantTokens = _getVariantTokens(theme);
    if (widget.disabled) {
      return theme.mutedColor;
    }
    return variantTokens.textColor;
  }

  String _getHelperText() {
    if (widget.errorText != null && widget.errorText!.isNotEmpty) {
      return widget.errorText!;
    }
    if (widget.successText != null && widget.successText!.isNotEmpty) {
      return widget.successText!;
    }
    if (widget.warningText != null && widget.warningText!.isNotEmpty) {
      return widget.warningText!;
    }
    return widget.helperText ?? '';
  }

  Color _getHelperTextColor(ShadThemeData theme) {
    if (widget.errorText != null && widget.errorText!.isNotEmpty) {
      return theme.errorColor;
    }
    if (widget.successText != null && widget.successText!.isNotEmpty) {
      return theme.successColor;
    }
    if (widget.warningText != null && widget.warningText!.isNotEmpty) {
      return theme.warningColor;
    }
    return theme.mutedColor;
  }

  Future<void> _pickFiles() async {
    if (widget.disabled) return;

    try {
      final result = await showDialog<List<File>>(
        context: context,
        builder: (context) => _FilePickerDialog(
          multiple: widget.multiple,
          allowedExtensions: widget.allowedExtensions,
          maxFiles: widget.maxFiles,
          maxFileSize: widget.maxFileSize,
        ),
      );

      if (result != null && result.isNotEmpty) {
        _addFiles(result);
      }
    } catch (e) {
      // Handle error
    }
  }

  void _addFiles(List<File> newFiles) {
    if (widget.disabled) return;

    List<File> updatedFiles = List.from(_selectedFiles);

    for (final file in newFiles) {
      if (widget.maxFiles != null && updatedFiles.length >= widget.maxFiles!) {
        break;
      }

      if (!updatedFiles.contains(file)) {
        updatedFiles.add(file);
      }
    }

    setState(() {
      _selectedFiles = updatedFiles;
    });

    widget.onFilesSelected?.call(updatedFiles);
  }

  void _removeFile(File file) {
    if (widget.disabled) return;

    final updatedFiles = List<File>.from(_selectedFiles)..remove(file);

    setState(() {
      _selectedFiles = updatedFiles;
    });

    widget.onFilesSelected?.call(updatedFiles);
    widget.onFileRemoved?.call(file);
  }

  void _handleDragEnter(dynamic details) {
    if (widget.disabled || !widget.dragAndDrop) return;
    setState(() {
      _isDragOver = true;
    });
  }

  void _handleDragLeave(dynamic details) {
    if (widget.disabled || !widget.dragAndDrop) return;
    setState(() {
      _isDragOver = false;
    });
  }

  void _handleDragOver(dynamic details) {
    if (widget.disabled || !widget.dragAndDrop) return;
    details.accept();
  }

  void _handleDrop(dynamic details) {
    if (widget.disabled || !widget.dragAndDrop) return;

    setState(() {
      _isDragOver = false;
    });

    // Handle dropped files
    // This would need to be implemented based on the platform
    // For now, we'll just trigger the file picker
    _pickFiles();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final sizeTokens = _getSizeTokens();
    final helperText = _getHelperText();

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: TextStyle(
                  fontSize: sizeTokens.fontSize,
                  fontWeight: FontWeight.w500,
                  color: _getTextColor(theme),
                ),
              ),
              SizedBox(height: sizeTokens.fontSize * 0.5),
            ],
            Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: MouseRegion(
                  onEnter: !widget.disabled
                      ? (_) => setState(() => _isDragOver = true)
                      : null,
                  onExit: !widget.disabled
                      ? (_) => setState(() => _isDragOver = false)
                      : null,
                  child: GestureDetector(
                    onTap: _pickFiles,
                    child: DragTarget<File>(
                      onWillAcceptWithDetails: (details) =>
                          !widget.disabled && widget.dragAndDrop,
                      onAcceptWithDetails: (details) =>
                          _addFiles([details.data]),
                      onMove: (details) => _handleDragEnter(details),
                      onLeave: (data) => _handleDragLeave(data),
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          height: sizeTokens.height,
                          padding: EdgeInsets.symmetric(
                            horizontal: sizeTokens.paddingX,
                            vertical: sizeTokens.paddingY,
                          ),
                          decoration: BoxDecoration(
                            color: _getBackgroundColor(theme),
                            border: Border.all(
                              color: _getBorderColor(theme),
                              width: sizeTokens.borderWidth,
                            ),
                            borderRadius: BorderRadius.circular(
                              sizeTokens.borderRadius,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.prefixIcon != null) ...[
                                widget.prefixIcon!,
                                SizedBox(height: sizeTokens.fontSize * 0.5),
                              ] else ...[
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  size: sizeTokens.iconSize,
                                  color: _getTextColor(theme),
                                ),
                                SizedBox(height: sizeTokens.fontSize * 0.5),
                              ],
                              Text(
                                _isDragOver
                                    ? (widget.dropText ?? 'Drop files here')
                                    : (widget.dragText ??
                                          'Click to upload or drag files here'),
                                style: TextStyle(
                                  fontSize: sizeTokens.fontSize,
                                  color: _getTextColor(theme),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (widget.hint != null) ...[
                                SizedBox(height: sizeTokens.fontSize * 0.25),
                                Text(
                                  widget.hint!,
                                  style: TextStyle(
                                    fontSize: sizeTokens.fontSize * 0.8,
                                    color: theme.mutedColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (helperText.isNotEmpty) ...[
              SizedBox(height: sizeTokens.fontSize * 0.5),
              Text(
                helperText,
                style: TextStyle(
                  fontSize: sizeTokens.fontSize * 0.8,
                  color: _getHelperTextColor(theme),
                ),
              ),
            ],
            if (widget.showPreview && _selectedFiles.isNotEmpty) ...[
              SizedBox(height: sizeTokens.fontSize),
              ...(_selectedFiles.map(
                (file) => _buildFilePreview(file, theme, sizeTokens),
              )),
            ],
          ],
        );
      },
    );
  }

  Widget _buildFilePreview(
    File file,
    ShadThemeData theme,
    ShadFileUploadSizeTokens sizeTokens,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: sizeTokens.fontSize * 0.5),
      padding: EdgeInsets.all(sizeTokens.fontSize * 0.5),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border.all(color: theme.borderColor),
        borderRadius: BorderRadius.circular(sizeTokens.borderRadius * 0.5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file,
            size: sizeTokens.iconSize * 0.8,
            color: theme.mutedColor,
          ),
          SizedBox(width: sizeTokens.fontSize * 0.5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.path.split('/').last,
                  style: TextStyle(
                    fontSize: sizeTokens.fontSize * 0.9,
                    color: _getTextColor(theme),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _formatFileSize(file.lengthSync()),
                  style: TextStyle(
                    fontSize: sizeTokens.fontSize * 0.7,
                    color: theme.mutedColor,
                  ),
                ),
              ],
            ),
          ),
          if (!widget.disabled)
            GestureDetector(
              onTap: () => _removeFile(file),
              child: Icon(
                Icons.close,
                size: sizeTokens.iconSize * 0.7,
                color: theme.mutedColor,
              ),
            ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

class ShadFileUploadSizeTokens {
  final double height;
  final double paddingX;
  final double paddingY;
  final double borderRadius;
  final double borderWidth;
  final double fontSize;
  final double iconSize;

  const ShadFileUploadSizeTokens({
    required this.height,
    required this.paddingX,
    required this.paddingY,
    required this.borderRadius,
    required this.borderWidth,
    required this.fontSize,
    required this.iconSize,
  });
}

class ShadFileUploadVariantTokens {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color dragOverColor;

  const ShadFileUploadVariantTokens({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.dragOverColor,
  });
}

class _FilePickerDialog extends StatelessWidget {
  final bool multiple;
  final List<String>? allowedExtensions;
  final int? maxFiles;
  final int? maxFileSize;

  const _FilePickerDialog({
    required this.multiple,
    this.allowedExtensions,
    this.maxFiles,
    this.maxFileSize,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Files'),
      content: const Text('File picker dialog would be implemented here.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop([]),
          child: const Text('Select'),
        ),
      ],
    );
  }
}
