import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  late double width;
  late double height;

  final _formKey = GlobalKey<FormState>();
  String defaultAvatar = 'assets/avatars/1.png';
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,})+$");
  late String? _nameErrorText = null;
  late String? _emailErrorText = null;
  late int _avatarIndex; // shared prefs //
  late String _phoneNumber; // shared prefs //
  late String _name;
  late String _email;
  bool nameError = false;
  bool emailError = false;
  String editOrSave = 'Edit';
  bool _tfReadOnly = true;
  bool _tfEnabled = false;

  late TextEditingController nameController =
      TextEditingController(text: _name);
  late TextEditingController emailController =
      TextEditingController(text: _email);
  late TextEditingController phoneController =
      TextEditingController(text: '+91 $_phoneNumber');

  // shared pref //
  Future<void> getAvatarIndex() async {
    int? avatarIndex = await sprefs.getAvatarIndex();
    setState(() {
      _avatarIndex = avatarIndex!;
    });
  }
  // shared pref //

  // shared pref //
  Future<void> getName() async {
    String? name = await sprefs.getName();
    setState(() {
      _name = name!;
    });
  }
  // shared pref //

  // shared pref //
  Future<void> getEmail() async {
    String? email = await sprefs.getEmail();
    setState(() {
      _email = email!;
    });
  }
  // shared pref //

  // shared pref //
  Future<void> getPhoneNumber() async {
    String? phoneNumber = await sprefs.getPhoneNumber();
    setState(() {
      _phoneNumber = phoneNumber!;
    });
  }
  // shared pref //

  @override
  void initState() {
    super.initState();
    // shared pref //
    getAvatarIndex();
    getName();
    getEmail();
    getPhoneNumber();
    // shared pref //
  }

  @override
  Widget build(BuildContext context) {
    // getAvatarIndex();  // this fixes the side bar profile pic bug but causes another in profile avatar while selecting
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // _phoneNumber = widget.phoneNumber; // shared prefs //
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.03),
              SizedBox(
                height: 150,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: GestureDetector(
                        onTap: () async {
                          if (editOrSave != 'Edit') {
                            await showAvatarPicker(context);
                          }
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                              'assets/avatars/$_avatarIndex.png'), // shared prefs //
                        ),
                      ),
                    ),
                    // get name from firestore database and set here //
                  ],
                ),
              ),
              editOrSave == 'Edit'
                  ? const SizedBox(height: 2.0)
                  : const Text(
                      'Tap to choose',
                      style: TextStyle(fontSize: 12.0),
                    ),
              SizedBox(height: height * 0.01),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _nameErrorText == null &&
                            _emailErrorText == null &&
                            editOrSave == 'Edit') {
                          setState(() {
                            editOrSave = 'Save';
                            _tfReadOnly = false;
                            _tfEnabled = true;
                          });
                        }

                        // logic to store avatar index, name, email and phone number in firestore database //

                        else {
                          setState(() {
                            editOrSave = 'Edit';
                            _tfReadOnly = true;
                            _tfEnabled = false;
                          });

                          Fluttertoast.showToast(
                            msg: 'Saved',
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );

                          // shared pref //
                          await sprefs.setAvatarIndex(_avatarIndex);
                          await sprefs.setPhoneNumber(_phoneNumber);
                          await sprefs.setName(_name);
                          await sprefs.setEmail(_email);
                          //shared pref //
                        }
                      },
                      child: Text(editOrSave),
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

  Future<void> showAvatarPicker(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: const Text('Choose your Avatar'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage('assets/avatars/$_avatarIndex.png'),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width / 2,
                        width: 200,
                        height: 100,
                        child: Card(
                          elevation: 0,
                          // color: Colors.red,
                          child: GridView.count(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 5.0,
                            ),
                            crossAxisCount: 3,
                            children: List.generate(15, (index) {
                              index = index + 1;
                              return GestureDetector(
                                onTap: () {
                                  // Handle image tap
                                  print('clicked image no: $index');
                                  setState(() {
                                    defaultAvatar = 'assets/avatars/$index.png';
                                    _avatarIndex = index;
                                  });
                                },
                                child: FractionallySizedBox(
                                  widthFactor: 0.8,
                                  heightFactor: 0.8,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundImage:
                                        AssetImage('assets/avatars/$index.png'),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await sprefs.setAvatarIndex(_avatarIndex);
                    },
                    child: const Text('Done'),
                  )
                ],
              ),
            );
          });
        }).whenComplete(() {
      setState(() {});
    });
  }

  Widget _nameField() {
    return Expanded(
      flex: 0,
      child: TextField(
        controller: nameController,
        readOnly: _tfReadOnly,
        enabled: _tfEnabled,
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
        readOnly: _tfReadOnly,
        enabled: _tfEnabled,
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
