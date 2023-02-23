import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String title;
  final double amount;
  final DateTime date;
  final int accountNumber;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.accountNumber,
  });

  
 toJson() {
    return {
      'account_name': title,
      'account_number': accountNumber,
      'amount': amount,
      'date': date,
    };
  }

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TransactionModel(
      title: data['account_name'],
      amount: data['amount'].toDouble(),
      date: data['date'].toDate(),
      accountNumber: data['account_number'],
    );
  }

  fromJson(Map<String, dynamic> data ) {
    return {
      'account_name': title,
      'account_number': accountNumber,
      'amount': amount,
      'date': date,
    };
  }
}