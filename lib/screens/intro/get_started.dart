import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/intro/onboarding.dart';
import 'package:geolocator/geolocator.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late double width;
  late double height;

  void askLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 90),
            child: SizedBox(
              width: width,
              height: height * 0.4,
              child: const Image(
                image: AssetImage('assets/get_started.png'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Let's get started!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "WePedL collects location data to show you nearest WePedL zones & journey routes, even when the app is closed or not in use. Allow WePedL to access this device's location.",
              // style: TextStyle(
              //   fontSize: 20,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
          ),
          SizedBox(height: height * 0.08),
          Center(
            child: ElevatedButton(
              onPressed: () {
                askLocationPermission();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const OnBoardingScreen(),
                  ),
                );
              },
              child: const Text('Enable Location'),
            ),
          ),
        ],
      ),
    );
  }
}
