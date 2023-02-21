import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/loading/splash.dart';
import 'screens/settings/config.dart';
import 'services/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();

  // late String _themeColor;
  late bool _isDark;

  // Map<String, Color> stringToColor = {
  //   'blue': Colors.blue,
  //   'purple': Colors.purple,
  //   'orange': Colors.orange,
  //   'teal': Colors.teal,
  //   'brown': Colors.brown,
  // };

  // // shared pref //
  // Future<void> getThemeColor() async {
  //   String? themeColor = await sprefs.getThemeColor();
  //   setState(() {
  //     _themeColor = themeColor!;
  //   });
  // }

  // shared pref //
  Future<void> getDarkThemeStatus() async {
    bool? isDark = await sprefs.getDarkThemeStatus();
    setState(() {
      _isDark = isDark!;
    });
  }

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
    // getThemeColor();
    getDarkThemeStatus();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WePedL',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: currentTheme.currentTheme(),
      home: const SplashScreen(),
      // home:  // for testing
    );
  }
}
