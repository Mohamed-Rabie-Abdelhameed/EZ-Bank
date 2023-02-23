import 'package:ez_bank/controllers/profileController.dart';
import 'package:ez_bank/widgets/TransactionCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/Transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late Future transactions;

  @override
  void initState() {
    super.initState();
    transactions = _getTransactions();
  }

  _getTransactions() async {
    final profileController = Get.put(ProfileController());
    List<TransactionModel>? transactions =
        await profileController.getTransactions();
    if (transactions == null) {
      return null;
    }
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10),
        margin: EdgeInsets.all(20),
        child: FutureBuilder(
          future: transactions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<TransactionModel>? data =
                  snapshot.data as List<TransactionModel>;
              return data == null
                  ? Text(
                      "No Data!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                            accountNumber: data[index].accountNumber,
                            accountName: data[index].title,
                            amount: data[index].amount * 1.0,
                            date: data[index].date);
                      },
                    );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: Text("No Data!"));
          },
        ),
      ),
    );
  }
}
