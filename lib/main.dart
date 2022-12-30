import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/loading/splash.dart';
import 'package:public_bicycle_sharing/screens/settings/config.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WePedL',
      theme: ThemeData(
        primarySwatch: Colors.blue, // hex - #2196F3
        backgroundColor: Colors.white,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      home: const SplashScreen(),
      // home: OnBoardingScreen(), // for testing
    );
  }
}

// to do
// use plugin for otp screen
// implement dark theme
// separate all the things and make code clean
