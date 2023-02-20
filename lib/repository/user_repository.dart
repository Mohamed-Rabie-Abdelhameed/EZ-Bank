import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/Account.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<bool> emailAreadyExists(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    print(snapshot.docs.isNotEmpty);
    return snapshot.docs.isNotEmpty;
  }

  createUser(Account account) async {
    if (!await emailAreadyExists(account.email)) {
      try {
        await _db
            .collection('Users')
            .add(account.toJson())
            .whenComplete(() => Get.snackbar(
                  "Success",
                  "Youre account has been created.",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.green,
                ));
      } catch (e) {
        print(e);
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
        print(e.toString());
      }
    } else {
      Get.snackbar(
        "Error",
        "Email already exists, try logging in",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
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
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(e.toString());
    }
    return Account(
        name: "",
        email: "",
        password: "",
        dob: DateTime.now(),
        accountNumber: 0);
  }
}
