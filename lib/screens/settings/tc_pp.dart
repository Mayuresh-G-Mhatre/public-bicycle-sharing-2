import 'package:flutter/material.dart';
import 'dart:io';

class TCScreen extends StatelessWidget {
  const TCScreen({super.key});

  Future<String> loadTermsNConditions() async {
    final TCfile = File('assets/TC.txt');
    return await TCfile.readAsString();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: loadTermsNConditions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    child: Text(snapshot.data ?? 'Error'));
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class PPScreen extends StatelessWidget {
  const PPScreen({super.key});

  Future<String> loadPrivacyPolicy() async {
    final PPfile = File('assets/PP.txt');
    return await PPfile.readAsString();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: loadPrivacyPolicy(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    child: Text(snapshot.data ?? 'Error'));
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
