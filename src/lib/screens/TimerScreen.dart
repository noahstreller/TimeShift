import 'package:flutter/cupertino.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  String _currentTime = "";

  @override
  void initState() {
    super.initState();
    // Initialize or fetch the current time when the screen is created
    _updateTime();
  }

  // Function to update the current time
  void _updateTime() {
    final now = DateTime.now();
    final formattedTime = "${now.hour}:${now.minute}:${now.second}";

    setState(() {
      _currentTime = formattedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Current Time:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            _currentTime,
            style: const TextStyle(fontSize: 36),
          ),
        ],
      ),
    );
  }
}
