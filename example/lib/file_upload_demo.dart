import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';
import 'package:shad_ui_flutter/src/tokens/tokens.dart';

class FileUploadDemo extends StatefulWidget {
  const FileUploadDemo({super.key});

  @override
  State<FileUploadDemo> createState() => _FileUploadDemoState();
}

class _FileUploadDemoState extends State<FileUploadDemo> {
  List<File> _selectedFiles = [];
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ShadSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'File Upload',
              style: TextStyle(
                fontSize: ShadTypography.fontSize2xl,
                fontWeight: ShadTypography.fontWeightBold,
              ),
            ),
            const SizedBox(height: ShadSpacing.md),
            Text(
              'Upload files with drag & drop support, preview, and validation.',
              style: TextStyle(
                fontSize: ShadTypography.fontSizeMd,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: ShadSpacing.xl),

            // Variants
            _buildSection('Variants', [
              Column(
                children: [
                  ShadFileUpload(
                    label: 'Default Variant',
                    hint: 'Upload a single file',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    variant: ShadFileUploadVariant.outline,
                    label: 'Outline Variant',
                    hint: 'Upload a single file',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    variant: ShadFileUploadVariant.filled,
                    label: 'Filled Variant',
                    hint: 'Upload a single file',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    variant: ShadFileUploadVariant.ghost,
                    label: 'Ghost Variant',
                    hint: 'Upload a single file',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Sizes
            _buildSection('Sizes', [
              Column(
                children: [
                  ShadFileUpload(
                    size: ShadFileUploadSize.sm,
                    label: 'Small Size',
                    hint: 'Small upload area',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    size: ShadFileUploadSize.md,
                    label: 'Medium Size',
                    hint: 'Medium upload area',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    size: ShadFileUploadSize.lg,
                    label: 'Large Size',
                    hint: 'Large upload area',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // States
            _buildSection('States', [
              Column(
                children: [
                  ShadFileUpload(
                    state: ShadFileUploadState.normal,
                    label: 'Normal State',
                    hint: 'Normal upload area',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    state: ShadFileUploadState.success,
                    label: 'Success State',
                    successText: 'Files uploaded successfully!',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    state: ShadFileUploadState.error,
                    label: 'Error State',
                    errorText: 'Please select valid files',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                  const SizedBox(height: ShadSpacing.md),
                  ShadFileUpload(
                    state: ShadFileUploadState.warning,
                    label: 'Warning State',
                    warningText: 'Some files may be too large',
                    onFilesSelected: (files) {
                      setState(() {
                        _selectedFiles = files;
                      });
                    },
                  ),
                ],
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Multiple Files
            _buildSection('Multiple Files', [
              ShadFileUpload(
                multiple: true,
                maxFiles: 5,
                label: 'Multiple Files',
                hint: 'Upload up to 5 files',
                helperText: 'Maximum 5 files allowed',
                onFilesSelected: (files) {
                  setState(() {
                    _selectedFiles = files;
                  });
                },
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Custom Icons
            _buildSection('Custom Icons', [
              ShadFileUpload(
                prefixIcon: const Icon(Icons.attach_file),
                label: 'With Prefix Icon',
                hint: 'Upload with custom icon',
                onFilesSelected: (files) {
                  setState(() {
                    _selectedFiles = files;
                  });
                },
              ),
              const SizedBox(height: ShadSpacing.md),
              ShadFileUpload(
                suffixIcon: const Icon(Icons.info_outline),
                label: 'With Suffix Icon',
                hint: 'Upload with info icon',
                onFilesSelected: (files) {
                  setState(() {
                    _selectedFiles = files;
                  });
                },
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Disabled State
            _buildSection('Disabled State', [
              ShadFileUpload(
                disabled: true,
                label: 'Disabled Upload',
                hint: 'This upload is disabled',
                onFilesSelected: (files) {
                  setState(() {
                    _selectedFiles = files;
                  });
                },
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Custom Text
            _buildSection('Custom Text', [
              ShadFileUpload(
                dragText: 'Click or drag files to upload',
                dropText: 'Release to upload files',
                label: 'Custom Text',
                hint: 'Custom drag and drop text',
                onFilesSelected: (files) {
                  setState(() {
                    _selectedFiles = files;
                  });
                },
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // File Restrictions
            _buildSection('File Restrictions', [
              ShadFileUpload(
                allowedExtensions: ['jpg', 'png', 'pdf'],
                maxFileSize: 5 * 1024 * 1024, // 5MB
                label: 'Restricted Files',
                hint: 'Only JPG, PNG, PDF files up to 5MB',
                helperText: 'Allowed: JPG, PNG, PDF (max 5MB)',
                onFilesSelected: (files) {
                  setState(() {
                    _selectedFiles = files;
                  });
                },
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // Without Preview
            _buildSection('Without Preview', [
              ShadFileUpload(
                showPreview: false,
                label: 'No Preview',
                hint: 'Files will not show preview',
                onFilesSelected: (files) {
                  setState(() {
                    _selectedFiles = files;
                  });
                },
              ),
            ]),
            const SizedBox(height: ShadSpacing.xl),

            // File Count Display
            _buildSection('File Count', [
              Text(
                'Selected Files: ${_selectedFiles.length}',
                style: TextStyle(
                  fontSize: ShadTypography.fontSizeMd,
                  fontWeight: ShadTypography.fontWeightMedium,
                ),
              ),
              const SizedBox(height: ShadSpacing.sm),
              Text(
                'Multiple Files: ${_selectedFiles.length}',
                style: TextStyle(
                  fontSize: ShadTypography.fontSizeMd,
                  fontWeight: ShadTypography.fontWeightMedium,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: ShadTypography.fontSizeXl,
            fontWeight: ShadTypography.fontWeightBold,
          ),
        ),
        const SizedBox(height: ShadSpacing.md),
        ...children,
      ],
    );
  }
}
