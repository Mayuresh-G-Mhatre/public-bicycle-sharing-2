import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/account/account.dart';
import 'package:public_bicycle_sharing/screens/help/get_help.dart';
import 'package:public_bicycle_sharing/screens/profile/profile.dart';
import 'package:public_bicycle_sharing/screens/refer/refer.dart';
import 'package:public_bicycle_sharing/screens/ride_history/history.dart';
import 'package:public_bicycle_sharing/screens/settings/settings.dart';
import 'package:public_bicycle_sharing/screens/wallet/wallet.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/pp.jpg'),
              ),
              accountName: Text('John Wick'),
              accountEmail: Text('johnwick@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // navigate to profile screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Wallet'),
              onTap: () {
                // navigate to wallet screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WalletScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pedal_bike_rounded),
              title: const Text('Ride History'),
              onTap: () {
                // navigate to history screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt),
              title: const Text('Refer'),
              onTap: () {
                // navigate to refer screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReferScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // navigate to settings screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // logic for routing navigation bar tabs
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
