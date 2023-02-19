import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("If you need help, please contact our customer service.",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text("Email:m@rabie.com",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Phone: 01000000000",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
