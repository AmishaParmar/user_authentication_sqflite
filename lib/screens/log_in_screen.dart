import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_authentication_sqflite/database/user_database_helper.dart';
import 'package:crypto/crypto.dart';
import 'package:user_authentication_sqflite/model/users.dart';
import 'package:user_authentication_sqflite/screens/home_screen.dart';
import 'package:user_authentication_sqflite/screens/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_authentication_sqflite/screens/splash_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController uNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  final DatabaseHelper db = DatabaseHelper();

  final formKey = GlobalKey<FormState>();

  final TextStyle labels = const TextStyle(
      color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600);

  Future<String> _hashPassword(String password) async {
    final bytes = utf8.encode(password);
    final digest = await sha256.convert(bytes);
    return base64Encode(digest.bytes);
  }

  login() async {
    var response = await db.loginUser(Users(
        userName: uNameController.text, userPassword: passwordController.text));
    if (response == true) {
      if (!mounted) return;
      Fluttertoast.showToast(
          msg: 'Log In successful', toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    } else {
      Fluttertoast.showToast(
          msg: "Invalid username and password", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Log In",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                    width: 300,
                    height: 350,
                    child: Image.asset("assets/images/user.jpg")),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  elevation: 30,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid username';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            focusColor: Colors.grey,
                            label: const Text("Username"),
                            labelStyle: labels,
                          ),
                          controller: uNameController,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid password';
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off),
                            ),
                            focusColor: Colors.grey,
                            label: const Text("Password"),
                            labelStyle: labels,
                          ),
                          controller: passwordController,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            var sharedPref =
                                await SharedPreferences.getInstance();

                            sharedPref.setBool(SplashPageState.KEYLOGIN, true);
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                             // formKey.currentState!.reset();
                              Fluttertoast.showToast(
                                  msg: 'Login successful',
                                  toastLength: Toast.LENGTH_SHORT);
                              _hashPassword(passwordController.text)
                                  .then((hashedPassword) {
                                db
                                    .loginUser(Users(
                                        userName: uNameController.text,
                                        userPassword: hashedPassword))
                                    .whenComplete(() {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return const HomeScreen();
                                  }));
                                });
                              });
                            }
                          },
                          style: const ButtonStyle(
                            minimumSize: WidgetStatePropertyAll(
                              Size.fromHeight(50),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            elevation: WidgetStatePropertyAll(10),
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 102, 133, 141)),
                          ),
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                ),
                                elevation: WidgetStatePropertyAll(20),
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return const RegistrationScreen();
                                }));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
