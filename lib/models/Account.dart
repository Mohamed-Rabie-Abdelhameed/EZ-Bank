import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime dob;
  final double balance;
  final int accountNumber;
  final List? transactions;

  Account(
      {this.id="",
      required this.name,
      required this.email,
      required this.password,
      required this.dob,
      this.balance = 0,
      required this.accountNumber,
       this.transactions});

  toJson() {
    return {
      'name': name,
      'email': email,
      'dob': dob,
      'balance': balance,
      'accountNumber': accountNumber,
      'password': password
    };
  }

  factory Account.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Account(
        id: snapshot.id,
        name: data['name'],
        email: data['email'],
        dob: data['dob'].toDate(),
        balance: data['balance'].toDouble(),
        accountNumber: data['accountNumber'],
        password: data['password'],
        transactions: data['transactions']);
  }
}
