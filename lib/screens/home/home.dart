import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import 'qr_scan.dart';
import '../../services/shared_prefs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  bool _paid = false;
  int _amount = 0;

  late double width;
  late double height;

  late MapController mapController;

  @override
  void initState() {
    super.initState();
    // shared pref //
    getDepositStatus();
    getWalletAmount();
    // shared pref //

    mapController = MapController(initMapWithUserPosition: true);
  }

  // shared pref //
  Future<void> getDepositStatus() async {
    bool? paid = await sprefs.getDepositStatus();
    setState(() {
      _paid = paid!;
    });
  }
  // shared pref //

  // shared pref //
  Future<void> getWalletAmount() async {
    int? amount = await sprefs.getWalletAmount();
    setState(() {
      _amount = amount!;
    });
  }
  // shared pref //

  @override
  Widget build(BuildContext context) {
    getDepositStatus();
    getWalletAmount();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _paid && _amount > 10
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QRScannerScreen(),
                  ),
                );
              }
            : () {
                showPayFirstToast(_paid
                    ? 'Wallet should have minimum \u{20B9}10'
                    : 'Please pay security deposit first!');
                // print('pay first');
                // print(_paid);
                // print(_amount.toString());
              },
        label: const Text("Unlock"),
        icon: const Icon(Icons.qr_code_scanner_outlined),
      ),
      body: Stack(
        children: [
          // container for testing purpose
          // Container(
          //   color: Colors.red,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: OSMFlutter(
              controller: mapController,
              trackMyPosition: true,
              mapIsLoading: Center(
                child: SizedBox(
                  height: height * 0.15,
                  width: width * 0.8,
                  child: Lottie.asset('assets/bicycle_anim.json'),
                ),
              ),
              initZoom: 20,
              userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                    icon: Icon(
                  Icons.person_pin_circle_rounded,
                  color: Colors.green,
                  size: 60,
                )),
                directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                  Icons.keyboard_double_arrow_up_rounded,
                  size: 60,
                )),
              ),
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
            ),
          ),
          Positioned(
            bottom: 60,
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
        ],
      ),
    );
  }

  void showPayFirstToast(String depositOrMoney) {
    Fluttertoast.showToast(
      msg: depositOrMoney,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
