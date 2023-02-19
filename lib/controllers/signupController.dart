import 'package:ez_bank/repository/authRepository.dart';
import 'package:ez_bank/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/Account.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final dob = TextEditingController();
  final accountNumber = TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future<void> registerUser(Account account) async {
    await userRepo.createUser(account);
    AuthRepository.instance
        .createUserWithEmailAndPassword(account.email, account.password);
  }
}
