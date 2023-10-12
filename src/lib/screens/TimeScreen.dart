import 'dart:async';
import 'package:flutter/material.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  TimeScreenState createState() => TimeScreenState();
}

class TimeScreenState extends State<TimeScreen> {
  Column _currentTime = const Column();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 3), (timer) {
      _updateTime();
    });
  }

  // Function to update the current time
  void _updateTime() {
    final now = DateTime.now();
    double clockFontSize = 40;
    final hour = Text(now.hour.toString().padLeft(2, '0'), style: TextStyle(fontSize: clockFontSize),);
    final minute = Text(now.minute.toString().padLeft(2, '0'), style: TextStyle(fontSize: clockFontSize),);
    final second = Text(now.second.toString().padLeft(2, '0'), style: TextStyle(fontSize: clockFontSize),);
    final millisecond = Text(now.millisecond.toString().padLeft(3, '0'), style: TextStyle(fontSize: clockFontSize, color: Colors.grey),);
    final formattedTime = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Time for Timezone "${now.timeZoneName}":',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hour,
            Text(":", style: TextStyle(fontSize: clockFontSize, color: Colors.grey.withOpacity(0.8))),
            minute,
            Text(":", style: TextStyle(fontSize: clockFontSize, color: Colors.grey.withOpacity(0.8))),
            second,
            Text(".", style: TextStyle(fontSize: clockFontSize, color: Colors.grey.withOpacity(0.8))),
            millisecond,
          ]
        ),
      ],
    );

    setState(() {
      _currentTime = formattedTime;
    });
  }

  @override
  void dispose() {
    // Cancel the timer in the dispose method to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _currentTime,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
