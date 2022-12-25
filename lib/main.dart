import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/loading/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WePedL',
      theme: ThemeData(
        primarySwatch: Colors.blue, // hex - #2196F3
      ),
      home: const SplashScreen(),
      // home: const LoginScreen(), // for testing
    );
  }
}

// to do
// use plugin for otp screen
// implement dark theme
// separate all the things and make code clean
