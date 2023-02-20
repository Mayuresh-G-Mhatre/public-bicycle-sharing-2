import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:public_bicycle_sharing/screens/login/login.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late double width;
  late double height;

  Widget buildImage(String path) {
    return Center(
      child: Image.asset(
        path,
        width: width,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    const bodyStyle = TextStyle(fontSize: 14.0);
    const pageDecoration = PageDecoration(
      bodyAlignment: Alignment.centerLeft,
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            image: buildImage('assets/zones.png'),
            title: 'Welcome to WePedL',
            body:
                'Look for WePedL Zones near your location, check the destination route & walk towards the WePedL Zone.',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/pick.png'),
            title: 'Pick a bicycle',
            body:
                'Scan the QR Code to unlock your ride. Pull up the level to remove the stand & start your journey.',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/safely.png'),
            title: 'Ride safely!',
            body:
                'Follow all the traffic rules and ride safely. Have an enjoyable ride.',
            decoration: pageDecoration,
          ),
          PageViewModel(
            image: buildImage('assets/end.png'),
            title: 'End ride at WePedL Zone',
            body:
                'Park your ride only at a designated WePedL Zone, Scan QR Code, and tap on "End Ride".',
            decoration: pageDecoration,
          ),
        ],
        skip: const Text(
          'Skip',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        next: const Text(
          'Next',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        done: const Text(
          'Enter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        showNextButton: true,
        showSkipButton: true,
        onDone: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
      ),
    );
  }
}
