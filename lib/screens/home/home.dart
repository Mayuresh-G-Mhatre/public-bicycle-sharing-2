import 'package:flutter/material.dart';
import 'package:public_bicycle_sharing/screens/account/account.dart';
import 'package:public_bicycle_sharing/screens/profile/profile.dart';
import 'package:public_bicycle_sharing/screens/refer/refer.dart';
import 'package:public_bicycle_sharing/screens/ride_history/history.dart';
import 'package:public_bicycle_sharing/screens/settings/settings.dart';
import 'package:public_bicycle_sharing/screens/wallet/wallet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkTheme = false;
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.qr_code_scanner_outlined),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        elevation: 5,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('PBS'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.dark_mode_outlined),
            onPressed: () {
              setState(() {
                _isDarkTheme = !_isDarkTheme;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/pp.jpg'),
              ),
              accountName: Text('John Wick'),
              accountEmail: Text('johnwick@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // navigate to profile screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Wallet'),
              onTap: () {
                // navigate to wallet screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WalletScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.pedal_bike_rounded),
              title: Text('Ride History'),
              onTap: () {
                // navigate to history screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add_alt),
              title: Text('Refer'),
              onTap: () {
                // navigate to refer screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReferScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // navigate to settings screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: _pages.elementAt(_selectedIndex),
      // ),
    );
  }
}
