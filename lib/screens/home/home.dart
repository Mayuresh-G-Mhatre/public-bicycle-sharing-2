import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? qrdata = await scanner.scan();
      // temp
      () {
        Fluttertoast.showToast(
          msg: qrdata!,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      };
    } else {
      var isGrant = await Permission.camera.request();

      if (isGrant.isGranted) {
        String? qrdata = await scanner.scan();
        // temp
        () {
          Fluttertoast.showToast(
            msg: qrdata!,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        };
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _qrScanner();
        },
        label: const Text("Unlock"),
        icon: const Icon(Icons.qr_code_scanner_outlined),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
