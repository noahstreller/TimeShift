import 'package:flutter/material.dart';

class TimezoneSelectorDialog extends StatefulWidget {
  const TimezoneSelectorDialog({Key? key}) : super(key: key);

  @override
  TimezoneSelectorDialogState createState() => TimezoneSelectorDialogState();
}

class TimezoneSelectorDialogState extends State<TimezoneSelectorDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              value: "Select a timezone",
              items: const [
                DropdownMenuItem(
                  child: Text("UTC"),
                  value: "UTC",
                ),
                DropdownMenuItem(
                  child: Text("Local"),
                  value: "Local",
                ),
              ],
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ),
    );
  }
}

void showTimeZoneSelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TimezoneSelectorDialog();
    },
  );
}