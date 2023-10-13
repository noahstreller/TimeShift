import 'dart:async';
import 'package:TimeShift/Dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/LayoutProvider.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: const TimeScreenBody(),
    );
  }
}

class TimeScreenBody extends StatefulWidget {
  const TimeScreenBody({super.key});

  @override
  TimeScreenBodyState createState() => TimeScreenBodyState();
}

class TimeScreenBodyState extends State<TimeScreenBody> {
  Column _currentTime = const Column();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 3), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final layoutProvider = Provider.of<LayoutProvider>(context, listen: false);
    final now = DateTime.now();
    double clockFontSize = 40;

    TextStyle clockFontStyle = TextStyle(fontSize: clockFontSize, fontFamily: "Roboto", letterSpacing: 1.0);
    TextStyle subtleClockFontStyle = TextStyle(fontSize: clockFontSize, color: Colors.grey.withOpacity(0.85), fontFamily: "Roboto", letterSpacing: 1.0);

    final hour = Text(now.hour.toString().padLeft(2, '0'), style: clockFontStyle,);
    final minute = Text(now.minute.toString().padLeft(2, '0'), style: clockFontStyle,);
    final second = Text(now.second.toString().padLeft(2, '0'), style: clockFontStyle,);
    final millisecond = Text(now.millisecond.toString().padLeft(3, '0'), style: subtleClockFontStyle,);

    final semicolonSeparator = Text(":", style: subtleClockFontStyle,);
    final periodSeparator = Text(".", style: subtleClockFontStyle,);

    final timeWidgets = <Widget>[
      hour,
      semicolonSeparator,
      minute,
      semicolonSeparator,
      second,
    ];

    if (layoutProvider.isMillisecondsOn) {
      timeWidgets.add(periodSeparator);
      timeWidgets.add(millisecond);
    }

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
          children: timeWidgets,
        )
      ],
    );

    setState(() {
      _currentTime = formattedTime;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTimeZoneSelectionDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<LayoutProvider>(
        builder: (context, layoutProvider, child) {
          return Column(
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
          );
        },
      ),
    );
  }
}
