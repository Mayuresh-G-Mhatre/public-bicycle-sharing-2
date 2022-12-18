import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/account/account.dart';
import 'package:public_bicycle_sharing/screens/help/get_help.dart';
import 'package:public_bicycle_sharing/screens/home/home.dart';
import 'package:public_bicycle_sharing/screens/login/login.dart';
import 'package:public_bicycle_sharing/screens/profile/profile.dart';
import 'package:public_bicycle_sharing/screens/refer/refer.dart';
import 'package:public_bicycle_sharing/screens/ride_history/history.dart';
import 'package:public_bicycle_sharing/screens/settings/settings.dart';
import 'package:public_bicycle_sharing/screens/wallet/wallet.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sidebarx/sidebarx.dart';

class DefaultHomeScreen extends StatefulWidget {
  const DefaultHomeScreen({super.key});

  @override
  Default_HomePageSScreen createState() => Default_HomePageSScreen();
}

class Default_HomePageSScreen extends State<DefaultHomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const WalletScreen(),
    const GetHelpScreen(),
    const AccountScreen(),
  ];

  // no need of this as added anonymous function in salomon
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Scan QR"),
        icon: const Icon(Icons.qr_code_scanner_outlined),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            selectedColor: Colors.blue,
            activeIcon: const Icon(Icons.home),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text("Wallet"),
            selectedColor: Colors.blue,
            activeIcon: const Icon(Icons.account_balance_wallet),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.help_center_outlined),
            title: const Text("Get Help"),
            selectedColor: Colors.blue,
            activeIcon: const Icon(Icons.help_center),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outlined),
            title: const Text("Profile"),
            selectedColor: Colors.blue,
            activeIcon: const Icon(Icons.person),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.grey[300],
      //   elevation: 5,
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   showUnselectedLabels: false,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Account',
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        title: const Text('WePedL'),
        centerTitle: true,
      ),
      drawer: SidebarX(
        headerBuilder: (context, extended) {
          return const SizedBox(
            height: 200,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/pp.jpg'),
              ),
            ),
          );
        },
        headerDivider: const Divider(
          indent: 5.0,
          endIndent: 5.0,
        ),
        controller: SidebarXController(selectedIndex: 0, extended: true),
        items: [
          SidebarXItem(
            icon: Icons.not_listed_location,
            label: 'Ride History',
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
            label: 'Refer & Earn',
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
            label: 'Settings',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
        footerBuilder: (context, extended) {
          return SizedBox(
            child: TextButton.icon(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.exit_to_app,
                size: 15.0,
                color: Colors.white,
              ),
              label: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
      // drawer: Drawer(
      //   child: Column(
      //     children: <Widget>[
      //       const UserAccountsDrawerHeader(
      //         currentAccountPicture: CircleAvatar(
      //           backgroundImage: AssetImage('assets/pp.jpg'),
      //         ),
      //         accountName: Text('John Wick'),
      //         accountEmail: Text('johnwick@gmail.com'),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Profile'),
      //         onTap: () {
      //           // navigate to profile screen
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => const ProfileScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.account_balance_wallet),
      //         title: const Text('Wallet'),
      //         onTap: () {
      //           // navigate to wallet screen
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => const WalletScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.pedal_bike_rounded),
      //         title: const Text('Ride History'),
      //         onTap: () {
      //           // navigate to history screen
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => const HistoryScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person_add_alt),
      //         title: const Text('Refer'),
      //         onTap: () {
      //           // navigate to refer screen
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => const ReferScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.settings),
      //         title: const Text('Settings'),
      //         onTap: () {
      //           // navigate to settings screen
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => const SettingsScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      // logic for routing navigation bar tabs
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
