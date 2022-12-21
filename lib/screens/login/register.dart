import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';
import 'package:public_bicycle_sharing/screens/login/my_paint.dart';
import 'package:public_bicycle_sharing/screens/login/svg_wrapper.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNumber;
  const RegistrationScreen({super.key, required this.phoneNumber});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String svgCode = multiavatar('086');
  late DrawableRoot svgRoot;
  final _formKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$");
  late String? _nameErrorText = '';
  late String? _emailErrorText = '';
  late String _name;
  late String _email;
  bool nameError = false;
  bool emailError = false;

  TextEditingController randomField = TextEditingController(text: '086');
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController =
      TextEditingController(text: '+91 ${widget.phoneNumber}');

  _generateSvg() async {
    return SvgWrapper(svgCode).generateLogo().then((value) {
      setState(() {
        svgRoot = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _generateSvg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 58.0),
                  avatarPreview(),
                  const SizedBox(width: 10.0),
                  _randomButton(),
                  // const SizedBox(height: 35.0),
                  // _textField(),
                ],
              ),
              const SizedBox(height: 30.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _nameField(),
                    const SizedBox(height: 12.0),
                    _emailField(),
                    const SizedBox(height: 12.0),
                    _phoneNumberField(),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: (_nameErrorText == null &&
                              _emailErrorText == null)
                          ? () {
                              // save svg code string to firestore database //
                              print('Multiavatar string: ${randomField.text}');
                              if (_formKey.currentState!.validate() &&
                                  _nameErrorText == null &&
                                  _emailErrorText == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DefaultHomeScreen(),
                                  ),
                                );
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

  Widget avatarPreview() {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: svgRoot == null
          ? const SizedBox.shrink()
          : CustomPaint(
              painter: MyPainter(svgRoot, const Size(100.0, 100.0)),
              child: Container(),
            ),
    );
  }

  Widget _textField() {
    return TextField(
      controller: randomField,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
      onChanged: (field) {
        if (field.isNotEmpty) {
          setState(() {
            svgCode = multiavatar(field);
          });
          // dev.log(svgCode);
        } else {
          setState(() {
            svgCode = multiavatar('321');
          });
        }
        _generateSvg();
      },
      decoration: const InputDecoration(
        fillColor: Colors.white10,
        border: InputBorder.none,
        filled: true,
        hintText: "type anything here",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
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

  Widget _randomButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50.0,
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        color: Colors.blue,
        child: IconButton(
            iconSize: 18.0,
            onPressed: () {
              var l = List.generate(12, (_) => Random().nextInt(100));
              randomField.text = l.join();
              setState(() {
                svgCode = multiavatar(randomField.text);
              });
              _generateSvg();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white70,
            )),
      ),
    );
  }
}
