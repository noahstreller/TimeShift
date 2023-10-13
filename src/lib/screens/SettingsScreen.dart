import 'package:TimeShift/providers/LayoutProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ThemeProvider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final layoutProvider = Provider.of<LayoutProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          ListTile(
            title: const Text('Display Milliseconds'),
            trailing: Switch(
              value: layoutProvider.isMillisecondsOn,
              onChanged: (value) {
                layoutProvider.toggleMilliseconds();
              },
            ),
          ),
        ],
      ),
    );
  }
}
