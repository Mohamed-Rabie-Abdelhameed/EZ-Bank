import 'package:ez_bank/main.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LineIcons.angleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Update Profile"),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Stack(children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  LineIcons.camera,
                  size: 20,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 35,
          ),
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter your name",
                    prefixIcon: Icon(LineIcons.user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    prefixIcon: Icon(LineIcons.envelope),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter the new password",
                    prefixIcon: Icon(LineIcons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text("Update", style: TextStyle(fontSize: 20)),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: themeManager.themeMode == ThemeMode.dark
                          ? Color(0xFFFFD23F)
                          : Color(0xFF5EBC66),
                      shape: StadiumBorder()),
                ),
              ),
            ],
          ))
        ]),
      )),
    );
  }
}
