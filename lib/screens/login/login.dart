import 'package:flutter/material.dart';

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

  void openKeyboard() {
    FocusScope.of(context).requestFocus(inputNode);
  }

  String getPhoneNumber(TextEditingController tec) {
    return _phoneController.text;
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
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  maxLength: 10,
                  // auto focus and open keyboard
                  autofocus: true,
                  focusNode: inputNode,
                  controller: _phoneController,
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
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () async {
                        // if no input in text field then disable button else enable
                        setState(() {
                          isButtonEnabled = false;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(
                              phoneNumber: _phoneController.text,
                            ),
                          ),
                        );
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
}
