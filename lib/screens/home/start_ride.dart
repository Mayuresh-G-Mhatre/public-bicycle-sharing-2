import 'package:flutter/material.dart';

class StartRideScreen extends StatefulWidget {
  final String bicycleNumber;
  StartRideScreen({super.key, required this.bicycleNumber});

  @override
  State<StartRideScreen> createState() => _StartRideScreenState();
}

class _StartRideScreenState extends State<StartRideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Bicycle Number: PEDL${widget.bicycleNumber}')),
    );
  }
}
