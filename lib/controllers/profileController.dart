import 'package:ez_bank/models/Account.dart';
import 'package:ez_bank/models/Transaction.dart';
import 'package:ez_bank/repository/authRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserByEmail(email);
    } else {
      Get.snackbar("Error", "Login to continue.");
      return null;
    }
  }

  getUserDataByEmail(String email) async {
    if (email != null) {
      return _userRepo.getUserByEmail(email);
    } else {
      Get.snackbar("Error", "User not found");
      return null;
    }
  }

  updateProfile(Account account) async {
    await _userRepo.updateUser(account);
  }

  updateBalance(double amount, Account user) async {
    await _userRepo.updateBalance(amount, user.id);
  }

  addTransaction(TransactionModel transaction, Account user) async {
    await _userRepo.addTransaction(transaction, user.id);
  }

  transferMoney(double amount, Account sender, String recieverEmail) async {
    await getUserDataByEmail(recieverEmail).then((value) {
      if (value != null && value.email != '') {
        print(value.email);
        double senderBalance = sender.balance - amount;
        double recieverBalance = value.balance + amount;
        updateBalance(senderBalance, sender);
        updateBalance(recieverBalance, value);
        addTransaction(
            TransactionModel(
                title: value.name,
                amount: amount,
                date: DateTime.now(),
                accountNumber: value.accountNumber),
            sender);
        addTransaction(
            TransactionModel(
                title: sender.name,
                amount: amount,
                date: DateTime.now(),
                accountNumber: sender.accountNumber),
            value);
        Get.snackbar("Success", "Money transfered successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
            margin: EdgeInsets.all(8));
      } else {
        Get.snackbar(
          "Error",
          "User not found",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          margin: EdgeInsets.all(8),
        );
        return;
      }
    });
  }

  getTransactions() async {
    final user = await getUserData();
    return _userRepo.getTransactions(user.id);
  }
}
