import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';
import 'package:public_bicycle_sharing/screens/login/register.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();

  String getPhoneNumber() {
    return phoneNumber;
  }
}

class _OtpScreenState extends State<OtpScreen> {
  late OtpFieldController otpController = OtpFieldController();
  bool otpFilled = false;
  int _seconds = 60;
  late Timer _timer;

  late double width;
  late double height;

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
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 200),
            const Text(
              'OTP Verification',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: OTPTextField(
                controller: otpController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                spaceBetween: 5.0,
                textFieldAlignment: MainAxisAlignment.center,
                fieldWidth: width * 0.08,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 10,
                style: const TextStyle(fontSize: 15),
                keyboardType: TextInputType.number,
                onChanged: (otp) {
                  setState(() {
                    otpFilled = otp.length == 4;
                  });
                },
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't recieve any code?",
                  style: TextStyle(fontSize: 12.0),
                ),
                _seconds > 0
                    ? Text(
                        ' Resend in ${_seconds}s',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            _seconds = 60;
                          });
                          _startTimer();
                          // logic for sending firebase otp //
                        },
                        child: const Text(
                          'Resend Code',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      )
              ],
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: otpFilled
                  ? () {
                      setState(() {
                        otpFilled = true;
                        // check if otp is correct by qureying firestore database //

                        // simulate firebase //
                        // check if phone number exists in firestore and if doesn't then route to registration screen //
                        // else route to home screen //
                        if (widget.phoneNumber == '0000000000') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(
                                  phoneNumber: widget.phoneNumber),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const DefaultHomeScreen(),
                            ),
                          );
                        }
                      });
                    }
                  : null,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
