import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 210, 63),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.asset(
              'assets/images/logo_text.png',
              height: 120,
              width: 120,
            ),
          ),
          Image.asset(
            'assets/images/cards.png',
            height: MediaQuery.of(context).size.height * 0.49,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerRight,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              'A Life Full of\nSimplicity.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, right: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), shadowColor: Colors.transparent),
                child: Icon(Icons.arrow_circle_right,
                    color: Colors.black, size: 70.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
