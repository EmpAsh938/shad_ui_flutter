import 'package:flutter/material.dart';
import 'package:shad_ui_flutter/shad_ui_flutter.dart';

class BottomSheetDemo extends StatefulWidget {
  const BottomSheetDemo({super.key});

  @override
  State<BottomSheetDemo> createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheet Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShadButton(
              onPressed: () => _showBasicBottomSheet(context),
              child: const Text('Show Basic Bottom Sheet'),
            ),
            const SizedBox(height: 16),
            ShadButton(
              onPressed: () => _showActionSheet(context),
              child: const Text('Show Action Sheet'),
            ),
            const SizedBox(height: 16),
            ShadButton(
              onPressed: () => _showCustomBottomSheet(context),
              child: const Text('Show Custom Bottom Sheet'),
            ),
            const SizedBox(height: 16),
            ShadButton(
              onPressed: () => _showScrollableBottomSheet(context),
              child: const Text('Show Scrollable Bottom Sheet'),
            ),
          ],
        ),
      ),
    );
  }

  void _showBasicBottomSheet(BuildContext context) {
    ShadBottomSheet.show(
      context: context,
      title: 'Basic Bottom Sheet',
      subtitle: 'This is a simple bottom sheet with title and content',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This is the content of the bottom sheet.'),
            const SizedBox(height: 16),
            ShadButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    ShadActionSheet.show(
      context: context,
      title: 'Choose an action',
      actions: [
        const ShadActionSheetAction(title: 'Edit', value: 'edit'),
        const ShadActionSheetAction(title: 'Share', value: 'share'),
        const ShadActionSheetAction(
          title: 'Delete',
          value: 'delete',
          isDestructive: true,
        ),
      ],
      cancelAction: const ShadActionSheetAction(
        title: 'Cancel',
        value: 'cancel',
      ),
    ).then((value) {
      if (value != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Selected: $value')));
      }
    });
  }

  void _showCustomBottomSheet(BuildContext context) {
    ShadBottomSheet.show(
      context: context,
      showDragHandle: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info, size: 48, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Custom Bottom Sheet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This bottom sheet has custom styling and content.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ShadButton(
                    onPressed: () => Navigator.of(context).pop(),
                    variant: ShadButtonVariant.outline,
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ShadButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showScrollableBottomSheet(BuildContext context) {
    ShadBottomSheet.show(
      context: context,
      isScrollControlled: true,
      title: 'Scrollable Content',
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Item ${index + 1}'),
              subtitle: Text('This is item number ${index + 1}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected item ${index + 1}')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
