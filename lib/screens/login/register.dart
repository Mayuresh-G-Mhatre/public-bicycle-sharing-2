import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/home/default_home.dart';

class RegistrationScreen extends StatefulWidget {
  final String phoneNumber;
  const RegistrationScreen({super.key, required this.phoneNumber});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$");
  late String? _nameErrorText = '';
  late String? _emailErrorText = '';
  late String _name;
  late String _email;
  bool nameError = false;
  bool emailError = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController =
      TextEditingController(text: '+91 ${widget.phoneNumber}');

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
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/pp.jpg'),
                  ),
                  const SizedBox(width: 10.0),
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
                      onPressed:
                          (_nameErrorText == null && _emailErrorText == null)
                              ? () {
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
