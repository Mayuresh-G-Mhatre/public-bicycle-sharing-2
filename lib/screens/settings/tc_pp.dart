import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class TCScreen extends StatelessWidget {
  const TCScreen({super.key});

  Future<String> loadTermsNConditions() async {
    return rootBundle.loadString('assets/TC.txt');
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
      ),
    );
  }
}

class PPScreen extends StatelessWidget {
  const PPScreen({super.key});

  Future<String> loadPrivacyPolicy() async {
    return rootBundle.loadString('assets/PP.txt');
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
      ),
    );
  }
}
