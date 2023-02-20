import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNumber;
  const RegistrationScreen({super.key, required this.phoneNumber});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  late double width;
  late double height;

  final _formKey = GlobalKey<FormState>();
  String defaultAvatar = 'assets/avatars/1.png';
  final RegExp _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$");
  late String? _nameErrorText = null;
  late String? _emailErrorText = null;
  int _sharedPrefAvatarInd = 1; // shared prefs //
  late String _name;
  late String _email;
  late String _phoneNumber; // shared prefs //
  bool nameError = false;
  bool emailError = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController =
      TextEditingController(text: '+91 ${widget.phoneNumber}');

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    _phoneNumber = widget.phoneNumber; // shared prefs //
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05),
              _avatarBox(),
              SizedBox(height: height * 0.04),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _nameField(),
                    SizedBox(height: height * 0.02),
                    _emailField(),
                    SizedBox(height: height * 0.02),
                    _phoneNumberField(),
                    SizedBox(height: height * 0.04),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          width * 0.26,
                          height * 0.05,
                        ),
                      ),
                      onPressed:
                          (_nameErrorText == null && _emailErrorText == null)
                              ? () async {
                                  if (_formKey.currentState!.validate() &&
                                      _nameErrorText == null &&
                                      _emailErrorText == null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DefaultHomeScreen(),
                                      ),
                                    );
                                    // logic to store avatar index, name, email and phone number in firestore database //

                                    Fluttertoast.showToast(
                                      msg: 'Registration Successfull',
                                      gravity: ToastGravity.BOTTOM,
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );

                                    // shared pref //
                                    await sprefs
                                        .setAvatarIndex(_sharedPrefAvatarInd);
                                    await sprefs.setPhoneNumber(_phoneNumber);
                                    await sprefs.setName(_name);
                                    await sprefs.setEmail(_email);
                                    //shared pref //
                                  }
                                }
                              : null,
                      child: const Text('Enter'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: width * 0.15,
          backgroundImage: AssetImage(defaultAvatar),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: SizedBox(
            width: width * 0.6,
            height: height * 0.14,
            child: Card(
              elevation: 0,
              child: GridView.count(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 5.0,
                ),
                crossAxisCount: 5,
                children: List.generate(15, (index) {
                  index = index + 1;
                  return GestureDetector(
                    onTap: () {
                      // Handle image tap
                      // print('clicked image no: $index');
                      setState(() {
                        defaultAvatar = 'assets/avatars/$index.png';
                        _sharedPrefAvatarInd = index; // shared prefs //
                      });
                    },
                    child: CircleAvatar(
                      radius: width * 0.19,
                      backgroundImage: AssetImage('assets/avatars/$index.png'),
                    ),
                  );
                }),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _nameField() {
    return Expanded(
      flex: 0,
      child: TextField(
        controller: nameController,
        maxLength: 30,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: 'Name',
          errorText: _nameErrorText,
          counterText: '',
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.person),
        ),
        onChanged: (value) {
          setState(() {
            _name = value;
            if (_name.isEmpty) {
              _nameErrorText = 'Name is required';
            } else if (_name.length < 3) {
              _nameErrorText = 'Name must be at least 3 characters';
            } else {
              _nameErrorText = null;
            }
          });
        },
      ),
    );
  }

  Widget _emailField() {
    return Expanded(
      flex: 0,
      child: TextField(
        controller: emailController,
        maxLength: 30,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          errorText: _emailErrorText,
          counterText: '',
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.email),
        ),
        onChanged: (value) {
          setState(() {
            _email = value;
            if (_email.isEmpty) {
              _emailErrorText = 'Email is required';
            } else if (!_emailRegex.hasMatch(_email)) {
              _emailErrorText = 'Enter a valid email';
            } else {
              _emailErrorText = null;
            }
          });
        },
      ),
    );
  }

  Widget _phoneNumberField() {
    return Expanded(
      flex: 0,
      child: TextField(
        readOnly: true,
        enabled: false,
        style: const TextStyle(color: Colors.grey),
        controller: phoneController,
        maxLength: 30,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          counterText: '',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }
}
