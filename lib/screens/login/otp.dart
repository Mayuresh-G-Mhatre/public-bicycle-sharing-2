import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';
import 'package:public_bicycle_sharing/screens/login/login.dart';

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
  final OtpFieldController otpController = OtpFieldController();
  bool otpFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
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
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 35,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 10,
                style: const TextStyle(fontSize: 15),
                keyboardType: TextInputType.number,
                onCompleted: (pin) {
                  otpFilled = true;
                },
              ),

              // child: TextField(
              //   autofocus: true,
              //   textAlign: TextAlign.center,
              //   maxLength: 4,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     labelText: 'OTP',
              //     counterText: '',
              //     border: OutlineInputBorder(),
              //     // hintText: 'Enter OTP',
              //   ),
              // ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't recieve any code?",
                  style: TextStyle(fontSize: 12.0),
                ),
                TextButton(
                  onPressed: () {
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
              onPressed: () {
                // verify OTP and move to HomeScreen
                otpFilled
                    ? Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DefaultHomeScreen(),
                        ),
                      )
                    : null;
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
