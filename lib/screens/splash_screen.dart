import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_authentication_sqflite/screens/home_screen.dart';
import 'package:user_authentication_sqflite/screens/log_in_screen.dart';
import 'package:user_authentication_sqflite/screens/start_up_screen.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static const String KEYLOGIN = 'LogIn';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 240, 213, 123),
              Color.fromARGB(255, 170, 240, 123),
              Color.fromARGB(255, 202, 32, 46),
              Color.fromARGB(255, 123, 158, 240),
              Color.fromARGB(255, 240, 123, 215),
              Color.fromARGB(255, 90, 6, 72),
              Color.fromARGB(255, 240, 123, 183),
              Color.fromARGB(255, 240, 213, 123),
              Color.fromARGB(255, 240, 123, 138),
              Color.fromARGB(255, 202, 32, 46),
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 100,
              ),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Timer(
      const Duration(seconds: 3),
      () {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const LogIn();
            }));
          }
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const StartUp();
          }));
        }
      },
    );
  }
}
