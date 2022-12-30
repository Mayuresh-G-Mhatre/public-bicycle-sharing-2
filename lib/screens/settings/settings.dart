import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/settings/config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Row(
        children: [
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
              currentTheme.switchTheme();
            },
          ),
          const Text('Enable Dark theme'),
        ],
      ),
    );
  }
}
