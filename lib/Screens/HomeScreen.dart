import 'package:ez_bank/pages/Convert.dart';
import 'package:ez_bank/pages/Deposit.dart';
import 'package:ez_bank/pages/Overview.dart';
import 'package:ez_bank/pages/Withdraw.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../controllers/profileController.dart';
import '../models/Account.dart';
import '../pages/Transfer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  List<Widget> _pages = [
    Overview(),
    Deposit(),
    Withdraw(),
    Transfer(),
    Convert(),
  ];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
          title: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Account userData = snapshot.data as Account;
                  int index = userData.name.indexOf(' ');
                  return Text(
                    'Welcome back ${userData.name.substring(0, index)},',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return const Text('Welcome to EZ Bank');
                }
              } else {
                return const Text('');
              }
            },
            future: profileController.getUserData(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  LineIcons.userCircle,
                  size: 30,
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            )
          ]),
      body: _pages[page],
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(LineIcons.home),
          Icon(Icons.arrow_outward),
          Icon(LineIcons.coins),
          Icon(LineIcons.paperPlane),
          Icon(LineIcons.euroSign),
        ],
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        height: 60,
        key: _bottomNavigationKey,
        index: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (value) => true,
      ),
    );
  }
}
