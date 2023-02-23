import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ez_bank/models/Transaction.dart';
import '../models/Account.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<bool> emailAlreadyExists(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    print(snapshot.docs.isNotEmpty);
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> accountNumberAlreadyExists(int accountNumber) async {
    final snapshot = await _db
        .collection("Users")
        .where("accountNumber", isEqualTo: accountNumber)
        .get();
    print(snapshot.docs.isNotEmpty);
    return snapshot.docs.isNotEmpty;
  }

  createUser(Account account) async {
    if (!await emailAlreadyExists(account.email) &&
        !await accountNumberAlreadyExists(account.accountNumber)) {
      try {
        await _db.collection('Users').add(account.toJson()).whenComplete(() =>
            Get.snackbar("Success", "Youre account has been created.",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green.withOpacity(0.1),
                colorText: Colors.green,
                margin: EdgeInsets.all(8)));
      } catch (e) {
        print(e);
        Get.snackbar("Error", "Something went wrong. Please try again later.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red,
            margin: EdgeInsets.all(8));
        print(e.toString());
      }
    } else {
      Get.snackbar("Error", "Email already exists, try logging in",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: EdgeInsets.all(8));
      return;
    }
  }

  // Get user by email
  Future<Account> getUserByEmail(String email) async {
    try {
      final snapshot =
          await _db.collection('Users').where('email', isEqualTo: email).get();
      final userData = snapshot.docs.map((e) => Account.fromSnapshot(e)).single;
      return userData;
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong, please try again later.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: EdgeInsets.all(8));
      print(e.toString());
    }
    return Account(
      id: "",
      name: "",
      email: "",
      password: "",
      dob: DateTime.now(),
      accountNumber: 0,
      balance: 0,
    );
  }

  Future<void> updateUser(Account account) async {
    try {
      await _db
          .collection('Users')
          .doc(account.id)
          .update(account.toJson())
          .whenComplete(() => Get.snackbar(
              "Success", "Your account has been updated.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
              margin: EdgeInsets.all(8)));
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong. Please try again later.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: EdgeInsets.all(8));
      print(e.toString());
      return null;
    }
  }

  Future<void> updateBalance(double amount, String id) async {
    try {
      await _db
          .collection('Users')
          .doc(id)
          .update({'balance': amount}).whenComplete(() => Get.snackbar(
              "Success", "Transaction successful.",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
              margin: EdgeInsets.all(8)));
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong. Please try again later.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: EdgeInsets.all(8));
      print(e.toString());
      return null;
    }
  }

  addTransaction(TransactionModel transaction, String id) {
    try {
      _db
          .collection('Users')
          .doc(id)
          .collection('Transactions')
          .add(transaction.toJson());
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Failed to add transaction.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: EdgeInsets.all(8));
      print(e.toString());
      return null;
    }
  }

  getTransactions(String id) async {
    try {
      final snapshot = await _db
          .collection('Users')
          .doc(id)
          .collection('Transactions')
          .orderBy('date', descending: true)
          .get();
      final transactions =
          snapshot.docs.map((e) => TransactionModel.fromSnapshot(e)).toList();
      print(transactions[0].date);
      return transactions;
    } catch (e) {
      print(e);
      print(e.toString());
      return null;
    }
  }
}
