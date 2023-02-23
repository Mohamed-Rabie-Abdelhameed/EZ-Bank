import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../controllers/signupController.dart';
import '../models/Account.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  DateTime birthDate = DateTime(1990, 1, 1);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            backgroundBlendMode:
                Theme.of(context).brightness == Brightness.light
                    ? BlendMode.darken
                    : BlendMode.lighten,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).brightness == Brightness.light
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
                    height: 120,
                    width: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: controller.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(LineIcons.user),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty || !value.contains(' ')||
                          value.length < 10 ||
                          !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15, left: 25.0, right: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: birthDate,
                          firstDate: DateTime.now()
                              .subtract(Duration(days: 365 * 100)),
                          lastDate: DateTime.now()
                              .subtract(Duration(days: 365 * 18)),
                        );
                        if (newDate != null) {
                          setState(() {
                            birthDate = newDate;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(LineIcons.calendar, size: 30),
                            Text(
                              '  Birth Date: ${birthDate.day}/${birthDate.month}/${birthDate.year}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: controller.accountNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.numbers),
                      labelText: 'Account Number',
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
                          value.length != 8 ||
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid account number (8 digits)';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(LineIcons.envelope),
                      labelText: 'Email',
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
                        final Account account = Account(
                          name: controller.name.text,
                          dob: birthDate,
                          accountNumber:
                              int.parse(controller.accountNumber.text.trim()),
                          email: controller.email.text.trim(),
                          password: controller.password.text.trim(),
                        );
                        SignupController.instance.registerUser(account);
                      }
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: Center(
                        child: Text('Signup', style: TextStyle(fontSize: 25)),
                      ),
                    ),
                    style: ButtonStyle(
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                    child: Column(
                      children: [
                        Text("Already have an account?",
                            style: TextStyle(fontSize: 18)),
                        Text("Login here!",
                            style: TextStyle(
                                color: Colors.green[300],
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
