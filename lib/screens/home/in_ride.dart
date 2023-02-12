import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/home/after_ride.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class InRideScreen extends StatefulWidget {
  String bicycleNumber;
  InRideScreen({super.key, required this.bicycleNumber});

  @override
  State<InRideScreen> createState() => _InRideScreenState();
}

class _InRideScreenState extends State<InRideScreen> {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: height * 0.6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.6,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/placeholder_map.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 170,
              height: 70,
              child: Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.pedal_bike, size: 20),
                          Text(widget.bicycleNumber),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('.'),
                          Text('.'),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('00:00:00'),
                          Text('On ride'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: ConfirmationSlider(
                width: width * 0.85,
                height: 50,
                onConfirmation: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const AfterRideScreen(),
                    ),
                  );
                },
                sliderButtonContent: const Icon(Icons.lock_outline),
                text: 'Slide to end ride',
                textStyle: const TextStyle(color: Colors.white),
                backgroundColor: Colors.blue,
                backgroundColorEnd: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
