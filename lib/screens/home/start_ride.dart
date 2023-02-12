import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:public_bicycle_sharing/screens/home/in_ride.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class StartRideScreen extends StatefulWidget {
  final String bicycleNumber;
  StartRideScreen({super.key, required this.bicycleNumber});

  @override
  State<StartRideScreen> createState() => _StartRideScreenState();
}

class _StartRideScreenState extends State<StartRideScreen> {
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.pedal_bike, size: 30),
            title: Text('PEDL${widget.bicycleNumber}'),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: const [
                Text('Ride charges: '),
                Text('\u{20B9}5 / 30 min ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Container(
                width: width * 0.6,
                height: height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/start_ride.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Text('Rules:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text(
                    '  1. Should be above age 14.\n  2. End ride only at WePedL Zone.\n  3. Follow traffic rules.'),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(
                    Icons.warning_amber_rounded,
                    size: 40,
                  ),
                  title: const Text(
                      'Violation of these rules will incur a penalty or a permanent ban from using the WePedL services',
                      style: TextStyle(fontSize: 14)),
                  iconColor: Colors.red,
                  tileColor: Colors.red[100],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.09),
          Center(
            child: ConfirmationSlider(
              width: width * 0.85,
              height: 50,
              onConfirmation: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        InRideScreen(bicycleNumber: widget.bicycleNumber),
                  ),
                );
              },
              sliderButtonContent: const Icon(Icons.lock_open_outlined),
              text: 'Slide to start ride',
              textStyle: const TextStyle(color: Colors.white),
              backgroundColor: Colors.blue,
              backgroundColorEnd: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
