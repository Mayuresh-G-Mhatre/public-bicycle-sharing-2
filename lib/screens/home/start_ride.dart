import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

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
                Text('\u{20B9}10 first 30 min ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('then '),
                Text('\u{20B9}5/30 min',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Rules:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    '  1. Should be above age 14.\n  2. End ride only at WePedL Zone.\n  3. Follow traffic rules.'),
              ],
            ),
          ),
          SizedBox(height: height * 0.60),
          Center(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
                iconSize: 30),
          ),
          const SizedBox(height: 5),
          SlideAction(
            onSubmit: () {},
            innerColor: Colors.white,
            outerColor: Colors.blue,
            elevation: 5,
            text: 'Slide to Unlock',
            sliderButtonIcon: const Icon(Icons.lock_outline),
            submittedIcon: const Icon(Icons.lock_open),
            sliderRotate: false,
          ),
        ],
      ),
    );
  }
}
