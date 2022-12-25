import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';
import 'package:public_bicycle_sharing/screens/login/login.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //
  String splashPrefixText = 'We';

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 12600), () {
      setState(() {
        splashPrefixText = '';
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await sprefs.contains('phone_number')) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const DefaultHomeScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset('assets/bicycle_anim.json'),
              ),
              const SizedBox(height: 20),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: (MediaQuery.of(context).size.width) / 2.4),
                  Text(
                    splashPrefixText,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      repeatForever: false,
                      totalRepeatCount: 0,
                      pause: const Duration(milliseconds: 0),
                      onFinished: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      animatedTexts: [
                        RotateAnimatedText('LearN'),
                        RotateAnimatedText('PlaN'),
                        RotateAnimatedText('DiscoveR'),
                        RotateAnimatedText('TraveL'),
                        RotateAnimatedText('PedL'),
                        // ScaleAnimatedText(''),
                        // RotateAnimatedText('ExercisE'),
                        // RotateAnimatedText('RelaX'),
                        // RotateAnimatedText('InspirE'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
