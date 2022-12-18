import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  void _sendOtp() async {
    setState(() {
      _isLoading = true;
    });
// send OTP to phone number provided
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(15.0),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                maxLength: 10,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  // hintText: 'Enter Phone Number',
                  // hintStyle: TextStyle(
                  //   fontSize: 10,
                  // ),
                  prefixIcon: Icon(Icons.phone_outlined),
                  prefix: Text('+91 '),
                  prefixStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      _sendOtp();
                    },
                    child: const Text('Send OTP'),
                  ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: TextField(
                textAlign: TextAlign.center,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  // hintText: 'Enter OTP',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // verify OTP and move to HomeScreen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DefaultHomeScreen(),
                  ),
                );
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
