import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profileController.dart';
import '../models/Account.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return SingleChildScrollView(
      child: FutureBuilder(
        future: profileController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Account userData = snapshot.data as Account;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Overview",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text("\$ ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                '${userData.balance}',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Account Number",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color)),
                              Text(
                                '${userData.accountNumber}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("My Cards",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        )),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/images/logo_text.png',
                                  height: 40,
                                ),
                                Image.asset(
                                  'assets/images/chip.png',
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          Text("1234 1234 1234 1234 1234",
                              style: TextStyle(
                                color: Colors.yellow[600],
                                fontSize: 20,
                                wordSpacing: 12,
                              )),
                          SizedBox(height: 50),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              userData.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
