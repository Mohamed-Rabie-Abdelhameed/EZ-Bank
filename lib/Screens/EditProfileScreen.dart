import 'package:ez_bank/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/profileController.dart';
import '../models/Account.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
  
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
              child: FutureBuilder(
                future: profileController.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      Account userData = snapshot.data as Account;
                      return Column(children: [
                        Stack(children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),
                                child: Image.asset(
                                  'assets/images/man.png',
                                ),
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
                              initialValue: userData.name,
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
                              initialValue: userData.email,
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
                              initialValue: userData.password,
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
                                child: Text("Update",
                                    style: TextStyle(fontSize: 20)),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        themeManager.themeMode == ThemeMode.dark
                                            ? Color(0xFFFFD23F)
                                            : Color(0xFF5EBC66),
                                    shape: StadiumBorder()),
                              ),
                            ),
                          ],
                        ))
                      ]);
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(child: Text("Something went wrong"));
                },
              )),
        ));
  }
}
