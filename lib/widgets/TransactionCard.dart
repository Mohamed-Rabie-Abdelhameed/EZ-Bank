import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class TransactionCard extends StatelessWidget {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final int accountNumber;
  final String accountName;
  final double amount;
  final DateTime date;

  TransactionCard(
      {required this.accountNumber,
      required this.accountName,
      required this.amount,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Theme.of(context).primaryColor.withOpacity(0.2),
        leading: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.5),
          child:
              Icon(LineIcons.alternateExchange, color: Colors.black, size: 30),
        ),
        title: Text(accountName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Row(
          children: [
            Text(accountNumber.toString()),
            SizedBox(width: 10),
            Text(formatter.format(date)),
          ],
        ),
        trailing: Text("\$${amount.toString()}",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        contentPadding: EdgeInsets.all(10),
      ),
    );
  }
}
