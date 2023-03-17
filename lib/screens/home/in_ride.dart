import 'package:cloud_firestore/cloud_firestore.dart' hide GeoPoint;
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:lottie/lottie.dart';
import 'package:public_bicycle_sharing/main.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../services/shared_prefs.dart';
import 'after_ride.dart';

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

  late MapController mapController;

  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  String _phoneNumber = phNo;
  int balance = 0;

  GeoPoint currentLocation =
      GeoPoint(latitude: 19.060088, longitude: 73.013560);

  var lat = 0.0;
  var long = 0.0;

  // Future<void> getPhoneNumber() async {
  //   String? phoneNumber = await sprefs.getPhoneNumber();
  //   setState(() {
  //     _phoneNumber = phoneNumber!;
  //   });
  // }

  Future<void> getUserDetailsFS() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_phoneNumber)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          balance = documentSnapshot.get('balance') ?? 0;
        });
      }
    });
  }

  @override
  void initState() {
    // getPhoneNumber();
    _stopWatchTimer.setPresetMinuteTime(
        5); // for testing purposes (starts timer from 5 mins)
    _stopWatchTimer.onStartTimer();

    mapController = MapController(initMapWithUserPosition: true);
    getUserDetailsFS();

    super.initState();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ConfirmationSlider(
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
            rideFare = (minutess * 0.668)
                .round(); // 20rs every 30min (for testing purpose)
          }
          // print(duration);
          // print(minutes * 0.167);
          _stopWatchTimer.onStopTimer();

          // updated balance after subtracting ride fare
          balance = balance - rideFare;

          // sprefs.setWalletAmount(balance);
          updateDatabase(_phoneNumber);
          updateLocationDatabase(_phoneNumber, {});

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  AfterRideScreen(endRideTime: displayTime, rideFare: rideFare),
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
      body: SafeArea(
        child: Stack(
          children: [
            // container for testing purpose
            // Container(
            // color: Colors.red,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: OSMFlutter(
                controller: mapController,
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                      icon: Icon(
                    Icons.pedal_bike_rounded,
                    color: Colors.green,
                    size: 60,
                  )),
                  directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    size: 60,
                  )),
                ),
                trackMyPosition: true,
                mapIsLoading: Center(
                  child: SizedBox(
                    height: height * 0.15,
                    width: width * 0.8,
                    child: Lottie.asset('assets/bicycle_anim.json'),
                  ),
                ),
                initZoom: 19,
                staticPoints: [
                  StaticPositionGeoPoint(
                    "bicycleStands",
                    const MarkerIcon(
                      icon: Icon(
                        Icons.pedal_bike_rounded,
                        color: Colors.blue,
                        size: 60,
                      ),
                    ),
                    <GeoPoint>[
                      // college stand
                      GeoPoint(latitude: 19.060088, longitude: 73.013560),
                      GeoPoint(latitude: 19.060083, longitude: 73.013531),
                      GeoPoint(latitude: 19.060097, longitude: 73.013553),
                      GeoPoint(latitude: 19.060096, longitude: 73.013534),
                      GeoPoint(latitude: 19.060093, longitude: 73.013492),
                      GeoPoint(latitude: 19.060088, longitude: 73.013458),
                      // juinagar railway station stand
                      GeoPoint(latitude: 19.056817, longitude: 73.016936),
                      GeoPoint(latitude: 19.056811, longitude: 73.016952),
                      GeoPoint(latitude: 19.065815, longitude: 73.010961),
                      // sanpada railway station stand
                      GeoPoint(latitude: 19.065725, longitude: 73.010752),
                      GeoPoint(latitude: 19.065751, longitude: 73.010804),
                      GeoPoint(latitude: 19.065759, longitude: 73.010836),
                      // sanpada station stand
                      GeoPoint(latitude: 19.062998, longitude: 73.014012),
                      GeoPoint(latitude: 19.062994, longitude: 73.014032),
                      GeoPoint(latitude: 19.062985, longitude: 73.014039),
                      // sanpada millenuim tower stand
                      GeoPoint(latitude: 19.060049, longitude: 73.010936),
                      GeoPoint(latitude: 19.060039, longitude: 73.010953),
                      GeoPoint(latitude: 19.060021, longitude: 73.010979),
                      // juinagar bridge station
                      GeoPoint(latitude: 19.053414, longitude: 73.016526),
                      GeoPoint(latitude: 19.053404, longitude: 73.016438),
                      GeoPoint(latitude: 19.053389, longitude: 73.016426),
                    ],
                  )
                ],
                onLocationChanged: (p0) {
                  setState(() {
                    lat = currentLocation.latitude;
                    long = currentLocation.longitude;
                  });
                  updateLocationDatabase(
                      _phoneNumber, {'latitude': lat, 'longitude': long});
                },
              ),
            ),
            Positioned(
              bottom: 80,
              right: 15,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 25,
                child: IconButton(
                  onPressed: () async {
                    await mapController.currentLocation();
                  },
                  color: Colors.white,
                  iconSize: 22,
                  icon: const Icon(Icons.my_location),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: (width / 2) - 80,
              child: SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }

  Future updateDatabase(String phoneNumber) async {
    final DocumentReference documentRef =
        FirebaseFirestore.instance.collection('users').doc(phoneNumber);

    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      await documentRef.update({
        'balance': balance,
      });
    }
  }

  Future updateLocationDatabase(String phoneNumber, Map latlong) async {
    final DocumentReference documentRef =
        FirebaseFirestore.instance.collection('users').doc(phoneNumber);

    final DocumentSnapshot documentSnapshot = await documentRef.get();

    if (documentSnapshot.exists) {
      await documentRef.update({
        'location': latlong,
      });
    }
  }
}
