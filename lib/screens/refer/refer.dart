import 'package:flutter/material.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  _ReferScreenState createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refer'),
      ),
      body: const Center(
        child: Text('Refer Screen'),
      ),
    );
  }
}
