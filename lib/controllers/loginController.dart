import 'package:ez_bank/repository/authRepository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController{
  static LoginController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();

  void login(String emai, String password){
    AuthRepository.instance.loginWithEmailAndPassword(emai, password);
  }

}