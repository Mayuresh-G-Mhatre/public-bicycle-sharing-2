import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'otp.dart';
import '../../services/shared_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //
  late TextEditingController _phoneController;
  FocusNode inputNode = FocusNode();
  bool isButtonEnabled = false;
  late double width;
  late double height;

  bool autoFetchExecuted = false;

  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  String getPhoneNumber(TextEditingController tec) {
    return _phoneController.text;
  }

  Future<void> _setData() async {
    String? selectedPhoneNumber = await SmsAutoFill().hint;
    _phoneController.text = selectedPhoneNumber ?? '';
    // print(selectedPhoneNumber.toString());
  }

  void filterData() {
    if (_phoneController.text.isNotEmpty &&
        _phoneController.text.startsWith('+91')) {
      _phoneController.text = _phoneController.text.substring(3);
    }
  }

  @override
  void initState() {
    super.initState();

    _phoneController = TextEditingController();
    _phoneController.addListener(() {
      final isButtonEnabled = _phoneController.text.length == 10;
      setState(() {
        this.isButtonEnabled = isButtonEnabled;
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    if (!autoFetchExecuted) {
      _setData();
      autoFetchExecuted = true;
    }

    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: height * 0.4,
                width: width * 0.8,
                child: const Image(
                  image: AssetImage('assets/bicycle.png'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              phoneNumberField(),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () async {
                        // if no input in text field then disable button else enable
                        setState(() {
                          isButtonEnabled = false;
                        });

                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+91${_phoneController.text}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            // push to otp screen after code sent
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                  phoneNumber: _phoneController.text,
                                  verificationId: verificationId,
                                ),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        if (!mounted) return;

                        await sprefs.setPhoneNumber(
                            _phoneController.text); // shared prefs //
                      }
                    : null,
                child: const Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneNumberField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        maxLength: 10,
        // auto focus and open keyboard
        autofocus: true,
        focusNode: inputNode,
        controller: _phoneController,
        // onChanged: (value) {
        //   if (value.startsWith('+91')) {
        //     setState(() {
        //       _phoneController.text = value.substring(3);
        //     });
        //   }
        // },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (_) {
          filterData();
          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          counterText: '',
          border: OutlineInputBorder(),
          prefixIcon: SizedBox(
            child: Icon(Icons.phone_outlined),
          ),
          prefixText: '+91 ',
          prefixStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
