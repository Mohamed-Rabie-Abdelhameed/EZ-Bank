import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/loginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            backgroundBlendMode:
                Theme.of(context).scaffoldBackgroundColor == Colors.white
                    ? BlendMode.darken
                    : BlendMode.lighten,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).scaffoldBackgroundColor == Colors.white
                    ? Colors.white
                    : Colors.black,
              ],
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(LineIcons.envelope),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)')
                              .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: controller.password,
                    decoration: InputDecoration(
                      prefixIcon: Icon(LineIcons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(LineIcons.eye),
                        onPressed: () {},
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 5 ||
                          value.contains(' ')) {
                        return 'Password must be at least 5 characters long and cannot contain spaces';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 20),
                  child: OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        try {
                          LoginController.instance.login(
                              controller.email.text.trim(),
                              controller.password.text.trim());
                        } catch (e) {
                          
                        }
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: Center(
                        child: Text('Login', style: TextStyle(fontSize: 25)),
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Column(
                    children: [
                      Text("Don't have an account?",
                          style: TextStyle(fontSize: 18)),
                      Text("Sign up here!",
                          style: TextStyle(
                              color: Colors.green[300],
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
