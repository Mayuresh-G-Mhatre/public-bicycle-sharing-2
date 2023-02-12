import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/home/after_ride.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class InRideScreen extends StatefulWidget {
  String bicycleNumber;
  InRideScreen({super.key, required this.bicycleNumber});

  @override
  State<InRideScreen> createState() => _InRideScreenState();
}

class _InRideScreenState extends State<InRideScreen> {
  late double width;
  late double height;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  late int rideFare;
  late var displayTime;

  @override
  void initState() {
    super.initState();
    // _stopWatchTimer.setPresetMinuteTime(5); // for testing purposes
    _stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

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
            const SizedBox(height: 22),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.pedal_bike, size: 20),
                          Text(widget.bicycleNumber),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          StreamBuilder<int>(
                              stream: _stopWatchTimer.rawTime,
                              initialData: _stopWatchTimer.rawTime.value,
                              builder: (context, snapshot) {
                                final value = snapshot.data;
                                displayTime = StopWatchTimer.getDisplayTime(
                                    value!,
                                    hours: true,
                                    milliSecond: false);
                                return Text(displayTime);
                              }),
                          const Text('On ride'),
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
                  // print(displayTime);
                  Duration duration = Duration(
                      hours: int.parse(displayTime.split(':')[0]),
                      minutes: int.parse(displayTime.split(':')[1]),
                      seconds: int.parse(displayTime.split(':')[2]));

                  int minutess = duration.inMinutes;
                  // if ride started only 2 minutes ago and user wants to cancel due to some problem then dont take any fare
                  if (minutess <= 2) {
                    rideFare = 0;
                  } else {
                    // rideFare = (minutes * 0.167).round(); // 5rs every 30min
                    rideFare = (minutess * 0.668).round(); // 20rs every 30min (for testing purpose)
                  }
                  // print(duration);
                  // print(minutes * 0.167);
                  _stopWatchTimer.onStopTimer();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => AfterRideScreen(
                          endRideTime: displayTime, rideFare: rideFare),
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
