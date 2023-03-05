import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../help/get_help.dart';
import 'home.dart';
import '../login/login.dart';
import '../profile/profile.dart';
import '../refer/refer.dart';
import '../ride_history/history.dart';
import '../settings/settings.dart';
import '../wallet/wallet.dart';
import '../../services/shared_prefs.dart';

class DefaultHomeScreen extends StatefulWidget {
  const DefaultHomeScreen({super.key});

  @override
  _DefaultHomeScreenState createState() => _DefaultHomeScreenState();
}

class _DefaultHomeScreenState extends State<DefaultHomeScreen> {
  // shared pref //
  SharedPrefGetsNSets sprefs = SharedPrefGetsNSets();
  // shared pref //

  String defaultAvatar = 'assets/avatars/1.png'; // maybe useless
  int _sharedPrefAvatarInd = 1; // shared prefs //
  late bool _isDark;

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  int _avatarIndex = 1;
  String _name = 'Loading';

  String? _phoneNumber;

  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const WalletScreen(),
    const GetHelpScreen(),
    const ProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.home_outlined),
        icon: const Icon(Icons.home),
        title: "Home",
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.account_balance_wallet_outlined),
        icon: const Icon(Icons.account_balance_wallet),
        title: "Wallet",
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.help_center_outlined),
        icon: const Icon(Icons.help_center),
        title: "Get Help",
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: const Icon(Icons.person_outlined),
        icon: const Icon(Icons.person),
        title: "Profile",
      ),
    ];
  }

  void getUserDetailsFS() {
    FirebaseFirestore.instance
        .collection('users')
        .where('phone_number', isEqualTo: _phoneNumber)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        setState(() {
          _avatarIndex = doc.get('avatar_index') ?? 1;
          _name = doc.get('name') ?? 'Error';
        });
      }
    });
  }

  // shared pref //
  Future<void> getPhoneNumber() async {
    String? phoneNumber = await sprefs.getPhoneNumber();
    setState(() {
      _phoneNumber = phoneNumber!;
    });
  }
  // shared pref //

  // // shared pref //
  // Future<void> getAvatarIndex() async {
  //   int? avatarIndex = await sprefs.getAvatarIndex();
  //   setState(() {
  //     _avatarIndex = avatarIndex!;
  //   });
  // }
  // // shared pref //

  // // shared pref //
  // Future<void> getName() async {
  //   String? name = await sprefs.getName();
  //   setState(() {
  //     _name = name!;
  //   });
  // }
  // // shared pref //

  // shared prefs //
  Future<void> logoutSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Other logout logic goes here
  }
  // shared prefs //

  // shared pref //
  Future<void> getDarkThemeStatus() async {
    bool? isDark = await sprefs.getDarkThemeStatus();
    setState(() {
      _isDark = isDark!;
    });
  }

  void setLoginStatus() async {
    await sprefs.setDepositStatus(true);
  }

  @override
  void initState() {
    super.initState();
    // shared pref //
    // getAvatarIndex();
    // getName();
    getDarkThemeStatus();
    setLoginStatus();
    getPhoneNumber();
    // shared pref //

    getUserDetailsFS();
  }

  @override
  Widget build(BuildContext context) {
    // getAvatarIndex();
    // getName();
    getDarkThemeStatus();
    // print('avind');
    // print(_avatarIndex);
    // print('nam');
    // print(_name);
    // print('phan');
    // print(_phoneNumber);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WePedL'),
        centerTitle: true,
      ),
      drawer: _sideBar(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _pages,
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style9,
        navBarHeight: 65,
        confineInSafeArea: true,
        backgroundColor: _isDark ? const Color(0xFF212121) : Colors.white,
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
                                  // print('clicked image no: $index');
                                  setState(() {
                                    defaultAvatar = 'assets/avatars/$index.png';
                                    _sharedPrefAvatarInd =
                                        index; // shared prefs //
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
                      Fluttertoast.showToast(
                        msg: 'Changed Avatar',
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      // await sprefs.setAvatarIndex(_sharedPrefAvatarInd);
                      updateDatabase(_phoneNumber!);
                    },
                    child: const Text('Done'),
                  )
                ],
              ),
            );
          });
        });
  }

  Widget _sideBar() {
    return SafeArea(
      child: SidebarX(
        showToggleButton: false,
        animationDuration: const Duration(milliseconds: 0),
        theme: const SidebarXTheme(
          width: 220,
        ),
        headerBuilder: (context, extended) {
          return SizedBox(
            height: 190,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        // print('tapped');
                        Scaffold.of(context).closeDrawer();
                      });
                      await showAvatarPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          'assets/avatars/$_avatarIndex.png'), // shared prefs //
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                // get name from firestore database and set here //
                Text(
                  _name!, // shared prefs //
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        controller: SidebarXController(
          selectedIndex: 4,
          extended: true,
        ),
        items: [
          SidebarXItem(
            icon: Icons.not_listed_location,
            label: '  Ride History',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
          SidebarXItem(
            icon: Icons.group_add,
            label: '  Refer & Earn',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ReferScreen(),
                ),
              );
            },
          ),
          SidebarXItem(
            icon: Icons.settings,
            label: '  Settings',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          SidebarXItem(
            iconWidget: const Icon(Icons.settings, color: Colors.transparent),
            label: '',
            onTap: () {},
          ),
        ],
        footerBuilder: (context, extended) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10.0)),
                  backgroundColor:
                      const MaterialStatePropertyAll<Color>(Colors.blue),
                ),
                onPressed: () {
                  // logic for logout and disconnect from firebase //
                  // shared prefs //
                  logoutSharedPrefs();
                  // shared prefs //
                  Fluttertoast.showToast(
                    msg: 'Logged Out',
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
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 18.0,
                  color: Colors.white,
                ),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future updateDatabase(String phoneNumber) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phone_number', isEqualTo: phoneNumber)
        .get();

    // print(_phoneNumber);
    // print(balance);
    // print(deposit_paid);

    final List<DocumentSnapshot> documents = querySnapshot.docs;
    if (documents.isNotEmpty) {
      final DocumentSnapshot document = documents.first;
      await document.reference.update({
        'avatar_index': _avatarIndex,
      });
    }
  }
}
