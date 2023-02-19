import 'package:ez_bank/pages/Convert.dart';
import 'package:ez_bank/pages/Deposit.dart';
import 'package:ez_bank/pages/Overview.dart';
import 'package:ez_bank/pages/Withdraw.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:line_icons/line_icons.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to EZ Bank'), actions: [
        IconButton(
          icon: Icon(LineIcons.user),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        )
      ]),
      body: _pages[page],
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(LineIcons.home),
          Icon(LineIcons.donate),
          Icon(LineIcons.coins),
          Icon(LineIcons.paperPlane),
          Icon(LineIcons.euroSign),
        ],
        color: Color.fromARGB(255, 255, 210, 63),
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
