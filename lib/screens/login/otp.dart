import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';

import '../home/default_home.dart';
import 'register.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const OtpScreen(
      {super.key, required this.phoneNumber, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();

  String getPhoneNumber() {
    return phoneNumber;
  }
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  bool showError = false;
  String errorText = '';

  bool otpFilled = false;
  String _otp = '';
  int _seconds = 60;
  late Timer _timer;

  late double width;
  late double height;

  final FirebaseAuth auth = FirebaseAuth.instance;

  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    const length = 6;
    const borderColor = Color.fromARGB(255, 114, 178, 238);
    const errorColor = Colors.red;
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 200),
            const Text(
              'OTP Verification',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter OTP sent to '),
                Text(
                  '+91 ${widget.phoneNumber}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22.0),
            otpField(length, defaultPinTheme, borderColor, errorColor),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't recieve any code?",
                  style: TextStyle(fontSize: 14.0),
                ),
                _seconds > 0
                    ? Text(
                        ' Resend in ${_seconds}s',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : TextButton(
                        onPressed: () async {
                          setState(() {
                            _seconds = 60;
                          });
                          _startTimer();

                          // logic for resending firebase otp //
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91${widget.phoneNumber}',
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {},
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                        },
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      )
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: otpFilled
                  ? () async {
                      setState(() {
                        otpFilled = true;
                      });

                      // Create a PhoneAuthCredential with the code
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode: _otp);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);

                        checkPhoneNumberExistsFS(widget.phoneNumber);

                        // store phone number locally
                        sprefs.setPhoneNumber(widget.phoneNumber);

                        // if (!mounted) return;
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //       builder: (context) => RegistrationScreen(
                        //           phoneNumber: widget.phoneNumber),
                        //     ),
                        //     (route) => false);

                        // Fluttertoast.showToast(
                        //   msg: 'Login Successfull',
                        //   gravity: ToastGravity.BOTTOM,
                        //   toastLength: Toast.LENGTH_SHORT,
                        //   backgroundColor: Colors.black,
                        //   textColor: Colors.white,
                        //   fontSize: 16.0,
                        // );
                      } on FirebaseAuthException catch (e) {
                        print(e.code);

                        Fluttertoast.showToast(
                          msg: 'Invalid OTP',
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );

                        // setState(() {
                        //   showError = true;
                        // });
                      }

                      // check if otp is correct by qureying firestore database //

                      // Navigator.of(context).pushAndRemoveUntil(
                      //       MaterialPageRoute(
                      //         builder: (context) => const DefaultHomeScreen(),
                      //       ),
                      //       (route) => false);
                    }
                  : null,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox otpField(int length, PinTheme defaultPinTheme, Color borderColor,
      MaterialColor errorColor) {
    return SizedBox(
      height: 60,
      child: Pinput(
        // validator: (value) {
        //   if (showError) {
        //     return "Invalid OTP";
        //   }
        //   return null;
        // },
        onChanged: (pin) {
          // print(pin + ' ' + (pin.length).toString());
          setState(() {
            otpFilled = pin.length == 6;
          });
        },
        onCompleted: (pin) {
          // print(pin);
          _otp = pin;
          setState(() {
            otpFilled = true;
          });
        },
        autofocus: true,
        length: length,
        controller: otpController,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
        closeKeyboardWhenCompleted: true,
        errorText: 'Invalid OTP',
        keyboardType: TextInputType.number,
        pinAnimationType: PinAnimationType.slide,
        focusNode: otpFocusNode,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 58,
          width: 54,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Future updateDatabasePhoneNumber(String phoneNumber) async {
    final docUser = FirebaseFirestore.instance.collection('users');

    final jsonn = {
      'phone_number': phoneNumber,
    };

    await docUser.doc(phoneNumber).set(jsonn);
  }

  Future checkPhoneNumberExistsFS(String phoneNumber) async {
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get();

    if (result.exists) {
      // phone number exists in collection
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const DefaultHomeScreen(),
          ),
          (route) => false);
    } else {
      // phone number does not exist in collection
      updateDatabasePhoneNumber(phoneNumber);
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => RegistrationScreen(phoneNumber: phoneNumber),
          ),
          (route) => false);
    }
  }
}
