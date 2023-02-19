import 'package:flutter/material.dart';


class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  // final User? user = Auth().currentUser;

  // Future<void> signOut() async {
  //   await Auth().signOut();
  // }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Overview'),
    );
  }
}