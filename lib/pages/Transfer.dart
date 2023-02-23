import 'package:ez_bank/controllers/profileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/Account.dart';

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ProfileController _profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _profileController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Account user = snapshot.data as Account;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Transfer",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Current Balance",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color)),
                            Text("\$${user.balance}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Transfer Amount",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Amount',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty || value.contains('-')) {
                            return 'Please enter a valid amount';
                          } else if (value.contains('.')) {
                            return 'Please enter a number without decimal';
                          } else if (!value.isNumericOnly) {
                            return 'Please enter a numeric value';
                          } else if (double.parse(value) > 10000) {
                            return 'Please enter a value less than 10000';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  _amountController.text = "1000";
                                },
                                child: Text("1000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Colors.black)),
                                style: TextButton.styleFrom(
                                  shape: StadiumBorder(),
                                  backgroundColor:
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                )),
                            TextButton(
                                onPressed: () {
                                  _amountController.text = "2000";
                                },
                                child: Text("2000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Colors.black)),
                                style: TextButton.styleFrom(
                                  shape: StadiumBorder(),
                                  backgroundColor:
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                )),
                            TextButton(
                                onPressed: () {
                                  _amountController.text = "5000";
                                },
                                child: Text("5000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Colors.black)),
                                style: TextButton.styleFrom(
                                  shape: StadiumBorder(),
                                  backgroundColor:
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                )),
                            TextButton(
                                onPressed: () {
                                  _amountController.text = "10000";
                                },
                                child: Text("10000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Colors.black)),
                                style: TextButton.styleFrom(
                                  shape: StadiumBorder(),
                                  backgroundColor:
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                )),
                          ]),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: 'Reciever Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid email';
                          } else if (!value.isEmail) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (user.balance -
                                      double.parse(_amountController.text) <
                                  0) {
                                Get.snackbar("Error", "Insufficient Balance",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor:
                                        Colors.red.withOpacity(0.8),
                                    margin: EdgeInsets.all(8));
                                return;
                              }
                              await _profileController.transferMoney(
                                  double.parse(_amountController.text),
                                  user,
                                  _emailController.text);
                              setState(() {
                                _amountController.text = "";
                                _emailController.text = "";
                              });
                              Get.back();
                            }
                          },
                          child: Text("Transfer",
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              )),
                          style:
                              ElevatedButton.styleFrom(shape: StadiumBorder()),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/transactions');
                          },
                          child: Text("Transaction History",
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              )),
                          style:
                              ElevatedButton.styleFrom(shape: StadiumBorder()),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: SpinKitThreeInOut(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                  );
                }
              }
              return Center(
                child: SpinKitThreeInOut(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
