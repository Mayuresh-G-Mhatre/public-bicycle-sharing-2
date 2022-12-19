import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/login/otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;
  FocusNode inputNode = FocusNode();
  bool isButtonEnabled = false;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
                child: SizedBox(
                  height: 18.0,
                  child: Text(
                    'Welcome!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              const Image(
                image: AssetImage('assets/bicycle.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  maxLength: 10,
                  // auto focus and open keyboard
                  focusNode: inputNode,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    counterText: '',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone_outlined),
                    prefixText: '+91 ',
                    prefixStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        // if no input in text field then disable button else enable
                        setState(() {
                          isButtonEnabled = false;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                phoneNumber: _phoneController.text,
                              ),
                            ),
                          );
                        });
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
