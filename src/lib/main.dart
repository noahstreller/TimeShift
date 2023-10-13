import 'package:TimeShift/providers/LayoutProvider.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:TimeShift/screens/TimeScreen.dart';
import 'package:TimeShift/screens/TimerScreen.dart';
import 'package:TimeShift/screens/WorldScreen.dart';
import 'package:TimeShift/screens/ToolsScreen.dart';
import 'package:TimeShift/screens/SettingsScreen.dart';
import 'package:TimeShift/providers/ThemeProvider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const TimeShiftApp());
}

class TimeShiftApp extends StatelessWidget {
  const TimeShiftApp({super.key});

  static final _defaultLightColorScheme =
  ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider(context)),
          ChangeNotifierProvider(create: (_) => LayoutProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'TimeShift',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: themeProvider.isDarkMode
                    ? darkColorScheme ?? _defaultDarkColorScheme
                    : lightColorScheme ?? _defaultLightColorScheme,
                useMaterial3: true,
              ),
              home: const TimeShiftHome(title: 'TimeShift'),
            );
          }
        ),
      );
    });
  }
}

class TimeShiftHome extends StatefulWidget {
  const TimeShiftHome({super.key, required this.title});
  final String title;

  @override
  State<TimeShiftHome> createState() => _TimeShiftHomeState();
}

class _TimeShiftHomeState extends State<TimeShiftHome> {
  String _screenTitle = "TimeShift";
  int _selectedIndex = 0;

  List screens = [
    const TimeScreenBody(),
    const TimerScreen(),
    const WorldScreen(),
    const ToolsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //harmonize dark gray with primary,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          _screenTitle,
          textAlign: TextAlign.left,
        ),
        centerTitle: false,
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
            _screenTitle = [
              "Time",
              "Timer",
              "World",
              "Tools",
              "Settings"
            ][_selectedIndex];
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.access_time),
            label: 'Time',
          ),
          NavigationDestination(
            icon: Icon(Icons.hourglass_bottom),
            label: 'Timer',
          ),
          NavigationDestination(
            icon: Icon(Icons.public),
            label: 'World',
          ),
          NavigationDestination(
            icon: Icon(Icons.build),
            label: 'Tools',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
