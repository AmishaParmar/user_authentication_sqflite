import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_authentication_sqflite/database/user_database_helper.dart';
import 'package:user_authentication_sqflite/model/users.dart';
import 'package:user_authentication_sqflite/screens/log_in_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController uNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isVisible = false;

  final DatabaseHelper db = DatabaseHelper();

  Future<String> _hashPassword(String password) async {
    final bytes = utf8.encode(password);
    final digest = await sha256.convert(bytes);
    return base64Encode(digest.bytes);
  }

  final TextStyle labels = const TextStyle(
      color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Sign Up",
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
                    height: 300,
                    child: Image.asset("assets/images/home.png")),
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
                              return 'Please enter username';
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
                              return 'Please enter email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.grey,
                            ),
                            focusColor: Colors.grey,
                            label: const Text("Email"),
                            labelStyle: labels,
                          ),
                          controller: emailController,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // TextFormField(
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Please enter phone number';
                        //     }
                        //     return null;
                        //   },
                        //   keyboardType: TextInputType.phone,
                        //   decoration: InputDecoration(
                        //     prefixIcon: const Icon(
                        //       Icons.phone,
                        //       color: Colors.grey,
                        //     ),
                        //     focusColor: Colors.grey,
                        //     label: const Text("Phone No"),
                        //     labelStyle: labels,
                        //   ),
                        //   controller: phoneController,
                        //   style: const TextStyle(
                        //       color: Colors.grey,
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.w600),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
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
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty ||
                                passwordController.text !=
                                    confirmPasswordController.text) {
                              return 'Please confirm password';
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
                            label: const Text("Confirm Password"),
                            labelStyle: labels,
                          ),
                          controller: confirmPasswordController,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                                Fluttertoast.showToast(msg:'Registration successful', toastLength: Toast.LENGTH_SHORT);
                              _hashPassword(passwordController.text)
                                  .then((hashedPassword) {
                                db
                                    .createUser(Users(
                                        userName: uNameController.text,
                                        userEmail: emailController.text,
                                        userPassword: passwordController.text))
                                    .whenComplete(() {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return const LogIn();
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
                            "Create an account",
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
                              "Already have an account?",
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
                                  return const LogIn();
                                }));
                              },
                              child: const Text(
                                "Log In",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ],
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
