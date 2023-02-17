import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:public_bicycle_sharing/screens/home/qr_scan.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: OSMFlutter(
          controller: mapController,
          // markerOption: MarkerOption(
          //   defaultMarker: const MarkerIcon(
          //     icon: Icon(
          //       Icons.person_pin_circle,
          //       color: Colors.blue,
          //       size: 56,
          //     ),
          //   ),
          // ),
          trackMyPosition: true,
          mapIsLoading: Center(
            child: SizedBox(
              height: height * 0.15,
              width: width * 0.8,
              child: Lottie.asset('assets/bicycle_anim.json'),
            ),
          ),
          initZoom: 16,
          // userLocationMarker: UserLocationMaker(
          //   directionArrowMarker: const MarkerIcon(
          //     icon: Icon(
          //       Icons.double_arrow_rounded,
          //       color: Colors.blue,
          //       size: 60,
          //     ),
          //   ),
          //   personMarker: const MarkerIcon(
          //     icon: Icon(
          //       Icons.person_pin_circle_rounded,
          //       color: Colors.blue,
          //       size: 60,
          //     ),
          //   ),
          // ),
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
                GeoPoint(latitude: 19.060058, longitude: 73.013382),
                GeoPoint(latitude: 19.060086, longitude: 73.013468),
                GeoPoint(latitude: 19.060093, longitude: 73.013493),
                GeoPoint(latitude: 19.056817, longitude: 73.016936),
                GeoPoint(latitude: 19.056811, longitude: 73.016937),
                GeoPoint(latitude: 19.065815, longitude: 73.010743),
                GeoPoint(latitude: 19.065725, longitude: 73.010752),
                GeoPoint(latitude: 19.065751, longitude: 73.010804),
                GeoPoint(latitude: 19.065759, longitude: 73.010836),
              ],
            )
          ],
        ),
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
