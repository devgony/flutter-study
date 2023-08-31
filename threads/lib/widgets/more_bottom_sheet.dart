import 'package:flutter/material.dart';
import 'package:threads/widgets/report_bottom_sheet.dart';

import '../utils.dart';
import 'drag_handle.dart';

class MoreBottomSheet extends StatelessWidget {
  const MoreBottomSheet({
    Key? key,
  }) : super(key: key);

  void onReportTap(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => const ReportBottomSheet(),
      constraints: BoxConstraints(
        maxHeight: getScreenHeight(context) * 0.73,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DragHandle(),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Unfollow'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.volume_off),
                title: Text('Mute'),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.visibility_off),
                title: Text('Hide'),
              ),
              const Divider(),
              GestureDetector(
                onTap: () => onReportTap(context),
                child: const ListTile(
                  leading: Icon(Icons.report, color: Colors.red),
                  title: Text(
                    'Report',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
