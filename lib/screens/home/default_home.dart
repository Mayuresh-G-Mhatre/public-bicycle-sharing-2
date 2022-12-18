import 'dart:ui';

import 'package:flutter/material.dart';
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
    const ProfileScreen(),
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
      appBar: AppBar(
        title: const Text('WePedL'),
        centerTitle: true,
      ),
      drawer: SafeArea(
        child: SidebarX(
          showToggleButton: false,
          animationDuration: const Duration(milliseconds: 0),
          theme: const SidebarXTheme(
            width: 250,
          ),
          headerBuilder: (context, extended) {
            return SizedBox(
              height: 190,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 60,
                      // implement avatar choosing //
                      backgroundImage: AssetImage('assets/pp.jpg'),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  // get username from database //
                  Text('John Wick',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            );
          },
          controller: SidebarXController(selectedIndex: 0, extended: true),
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
      ),
      // logic for routing navigation bar tabs
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
