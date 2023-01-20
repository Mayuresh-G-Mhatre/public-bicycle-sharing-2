import 'package:flutter/material.dart';

class AfterRideScreen extends StatefulWidget {
  const AfterRideScreen({super.key});

  @override
  State<AfterRideScreen> createState() => _AfterRideScreenState();
}

class _AfterRideScreenState extends State<AfterRideScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Thanks for riding')),
    );
  }
}
