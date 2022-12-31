import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_bicycle_sharing/screens/login/login.dart';
import 'package:public_bicycle_sharing/screens/settings/config.dart';
import 'package:public_bicycle_sharing/services/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();

  bool isSwitched = false;

  late bool _isDarkTheme;
  late String _themeColor;

  String _language = 'English';

  late double width;
  late double height;

  // shared prefs //
  Future<void> logoutSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Other logout logic goes here
  }
  // shared prefs //

  // shared pref //
  Future<void> getThemeColor() async {
    String? themeColor = await sprefs.getThemeColor();
    setState(() {
      _themeColor = themeColor!;
    });
  }

  // shared pref //
  Future<void> getDarkThemeStatus() async {
    bool? isDarkTheme = await sprefs.getDarkThemeStatus();
    setState(() {
      _isDarkTheme = isDarkTheme!;
    });
  }

  // shared pref //
  Future<void> getLanguage() async {
    String? language = await sprefs.getLanguage();
    setState(() {
      _language = language!;
    });
  }

  @override
  void initState() {
    super.initState();
    _language = 'English';
    getThemeColor();
    getDarkThemeStatus();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.auto_fix_high,
              color: Colors.blue,
              size: 28,
            ),
            title: const Text(
              'Appearance',
              style: TextStyle(fontSize: 14),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            onTap: () async {
              await showThemeDialog(context);
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.language,
              color: Colors.blue,
              size: 28,
            ),
            title: const Text(
              'Language',
              style: TextStyle(fontSize: 14),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            onTap: () async {
              await showLanguageDialog(context);
            },
          ),
          const ListTile(
            dense: true,
            leading: Icon(
              Icons.text_snippet,
              color: Colors.blue,
              size: 28,
            ),
            title: Text(
              'Terms & Conditions',
              style: TextStyle(fontSize: 14),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
            // onTap: () async {
            //   await showTnCDialog(context);
            // },
          ),
          const ListTile(
            dense: true,
            leading: Icon(
              Icons.safety_check,
              color: Colors.blue,
              size: 28,
            ),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 14),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 15),
            // onTap: () async {
            //   await showPrivacyPolicyDialog(context);
            // },
          ),
          const ListTile(
            dense: true,
            leading: Icon(
              Icons.android,
              color: Colors.blue,
              size: 28,
            ),
            title: Text(
              'Version',
              style: TextStyle(fontSize: 14),
            ),
            trailing: Text(
              'Version 0.1.5.9 (0159004)',
              style: TextStyle(fontSize: 10),
            ),
          ),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.delete_forever,
              color: Colors.red,
              size: 28,
            ),
            title: const Text(
              'Delete Account',
              style: TextStyle(fontSize: 14),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 15),
            onTap: () async {
              await showDeleteAccountDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> showThemeDialog(BuildContext context) async {
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
                title: const Text('Change Theme'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _themeColor = 'blue';
                            });
                            await sprefs.setThemeColor(_themeColor);
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _themeColor = 'purple';
                            });
                            await sprefs.setThemeColor(_themeColor);
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.purple,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _themeColor = 'orange';
                            });
                            await sprefs.setThemeColor(_themeColor);
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.orange,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _themeColor = 'teal';
                            });
                            await sprefs.setThemeColor(_themeColor);
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.teal,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _themeColor = 'brown';
                            });
                            await sprefs.setThemeColor(_themeColor);
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dark Theme'),
                        Switch(
                          activeColor: Colors.blue,
                          value: _isDarkTheme,
                          onChanged: (value) async {
                            currentTheme.switchTheme();
                            setState(() {
                              _isDarkTheme = value;
                            });
                            await sprefs.setDarkThemeStatus(_isDarkTheme);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                // actions: [
                //   ElevatedButton(
                //     onPressed: () async {
                //       setState(() {
                //         _themeColor = _themeColor;
                //         _isDarkTheme = !_isDarkTheme;
                //       });
                //        currentTheme.switchTheme();

                //       if (!mounted) return;
                //       Navigator.of(context).pop();
                //     },
                //     child: const Text('Cancel'),
                //   ),
                //   ElevatedButton(
                //     onPressed: () async {
                //       Fluttertoast.showToast(
                //         msg: 'Changed Theme',
                //         gravity: ToastGravity.BOTTOM,
                //         toastLength: Toast.LENGTH_LONG,
                //         backgroundColor: Colors.black,
                //         textColor: Colors.white,
                //         fontSize: 16.0,
                //       );

                //       await sprefs.setThemeColor(_themeColor);
                //       await sprefs.setDarkThemeStatus(_isDarkTheme);

                //       if (!mounted) return;
                //       Navigator.of(context).pop();
                //     },
                //     child: const Text('Set'),
                //   ),
                // ],
              ),
            );
          });
        }).whenComplete(() {
      setState(() {});
    });
  }

  Future<void> showLanguageDialog(BuildContext context) async {
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
                title: const Text('Choose Language'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      title: const Text('English'),
                      value: 'English',
                      groupValue: _language,
                      onChanged: (value) async {
                        setState(() {
                          _language = value.toString();
                        });
                        Fluttertoast.showToast(
                          msg: 'Language Changed',
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        await sprefs.setLanguage(_language);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                      },
                    ),
                    RadioListTile(
                      title: const Text('Hindi'),
                      value: 'Hindi',
                      groupValue: _language,
                      onChanged: (value) async {
                        setState(() {
                          _language = value.toString();
                        });
                        Fluttertoast.showToast(
                          msg: 'Language Changed',
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        await sprefs.setLanguage(_language);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                      },
                    ),
                    RadioListTile(
                      title: const Text('Marathi'),
                      value: 'Marathi',
                      groupValue: _language,
                      onChanged: (value) async {
                        setState(() {
                          _language = value.toString();
                        });
                        Fluttertoast.showToast(
                          msg: 'Language Changed',
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        await sprefs.setLanguage(_language);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        }).whenComplete(() {
      setState(() {});
    });
  }

  Future<void> showDeleteAccountDialog(BuildContext context) async {
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
                title: const Text('Delete Account'),
                content: const Text(
                    'Are you sure you want to delete your account?\nIf you delete your account, you will permanently lose your account.'),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      logoutSharedPrefs();
                      // shared prefs //
                      Fluttertoast.showToast(
                        msg: 'Goodbye',
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          });
        }).whenComplete(() {
      setState(() {});
    });
  }
}
