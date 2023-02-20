import 'dart:math';

import 'package:ez_bank/repository/authRepository.dart';
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
    }
  }
}
