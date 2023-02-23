import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_bank/widgets/TransactionCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/profileController.dart';
import '../models/Account.dart';
import '../models/Transaction.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late Future userFuture;
  @override
  void initState() {
    super.initState();
    userFuture = _getData();
  }

  _getData() async {
    final profileController = Get.put(ProfileController());
    Account userData = await profileController.getUserData();
    List<TransactionModel>? transactions =
        await profileController.getTransactions();
    print(userData.email);
    return [userData, transactions];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Account userData = snapshot.data[0] as Account;
              List<TransactionModel>? transactions = snapshot.data[1];
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
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Recent Transactions",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        )),
                    Container(
                      height: 300,
                      child: transactions == null
                          ? Center(
                              child: Text("No Data",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: transactions.length < 3
                                  ? transactions.length
                                  : 3,
                              itemBuilder: (context, index) {
                                return TransactionCard(
                                  accountNumber:
                                      transactions[index].accountNumber,
                                  accountName: transactions[index].title,
                                  amount: transactions[index].amount * 1.0,
                                  date: transactions[index].date,
                                );
                              },
                            ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                  child: SpinKitThreeInOut(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ));
            }
          } else {
            return Center(
                child: SpinKitThreeInOut(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ));
          }
        },
      ),
    );
  }
}
