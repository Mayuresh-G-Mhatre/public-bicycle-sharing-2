import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_bicycle_sharing/screens/home/start_ride.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  late String _enteredBicycleNumber;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;
  bool _isFlashOn = false;
  TextEditingController bicycleNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller?.resumeCamera();
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        buildQrView(context),
        Positioned(bottom: 160, child: flashButton()),
        Positioned(bottom: 100, child: enterBicycleNumberButton()),
      ],
    );
  }

  Widget enterBicycleNumberButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white24,
      ),
      onPressed: () {
        showEnterBicycleNumberDialog(context);
      },
      child: const Text('Enter Bicycle Number'),
    );
  }

  Widget flashButton() {
    return Container(
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white24,
      ),
      child: IconButton(
        iconSize: 35,
        icon: _isFlashOn
            ? const Icon(
                Icons.flash_off,
                color: Colors.blue,
              )
            : const Icon(
                Icons.flash_on,
                color: Colors.blue,
              ),
        onPressed: () async {
          _isFlashOn = !_isFlashOn;
          await controller?.toggleFlash();
          setState(() {});
        },
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.blue,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
      if (isValid(barcode.code!)) {
        controller.pauseCamera();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StartRideScreen(bicycleNumber: barcode.code!),
          ),
        );
      } else {
        showInvalidQRToast();
      }
    });
  }

  bool isValid(String bikeNumber) {
    final regex = RegExp(r'^PEDL\d{5}$');
    return regex.hasMatch(bikeNumber);
  }

  void showInvalidQRToast() {
    Fluttertoast.showToast(
      msg: "Invalid QR Code.",
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
      textColor: Colors.red,
      fontSize: 16.0,
    );
  }

  Future<void> showEnterBicycleNumberDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: const Text('Enter Bicycle Number'),
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    autofocus: true,
                    maxLength: 5,
                    keyboardType: TextInputType.phone,
                    controller: bicycleNumberController,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                      prefixText: 'PEDL',
                    ),
                    onChanged: (value) {
                      _enteredBicycleNumber = value;
                    },
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      bicycleNumberController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await sprefs
                          .setBicycleNumber(bicycleNumberController.text);

                      // print(_enteredBicycleNumber);

                      if (_enteredBicycleNumber != null) {
                        controller?.dispose();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StartRideScreen(
                                bicycleNumber: _enteredBicycleNumber),
                          ),
                        );
                      } else {
                        showInvalidQRToast();
                      }
                    },
                    child: const Text('Done'),
                  ),
                ],
              ),
            );
          });
        }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
