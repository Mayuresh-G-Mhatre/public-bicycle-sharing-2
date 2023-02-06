import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/provider/theme.custom.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';
import 'package:public_bicycle_sharing/screens/home/qr_scan.dart';
import 'package:public_bicycle_sharing/screens/loading/splash.dart';
import 'package:public_bicycle_sharing/screens/settings/config.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';
import 'package:provider/provider.dart';

import 'provider/theme.data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();

  Map<String, Color> stringToColor = {
    'blue': Colors.blue,
    'purple': Colors.purple,
    'orange': Colors.orange,
    'teal': Colors.teal,
    'brown': Colors.brown,
  };

  // // shared pref //
  // Future<void> getThemeColor() async {
  //   String? themeColor = await sprefs.getThemeColor();
  //   setState(() {
  //     _themeColor = themeColor!;
  //   });
  // }

  // // shared pref //
  // Future<void> getDarkThemeStatus() async {
  //   bool? isDark = await sprefs.getDarkThemeStatus();
  //   setState(() {
  //     _isDark = isDark!;
  //   });
  // }

  final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryColor: Colors.blue, // #2196F3
    // floatingActionButtonTheme:
    //     const FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  );

  final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    // floatingActionButtonTheme:
    //     const FloatingActionButtonThemeData(backgroundColor: Colors.blue),
  );

  @override
  void initState() {
    super.initState();
    getThemeColor();
    getDarkThemeStatus();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WePedL',
        theme: CustomTheme.lightTheme(),
        darkTheme: CustomTheme.darkTheme(),
        themeMode: ThemeProvider().themeMode,
        home: const SplashScreen(),
        // home: const DefaultHomeScreen(), // for testing
      ),
    );
  }
}
