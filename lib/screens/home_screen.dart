import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_authentication_sqflite/screens/log_in_screen.dart';
import 'package:user_authentication_sqflite/screens/splash_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to home screen!!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
              onPressed: () async {
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool(SplashPageState.KEYLOGIN, false);

                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return LogIn();
                }));
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                elevation: const WidgetStatePropertyAll(15),
                fixedSize: const WidgetStatePropertyAll(Size.infinite),
                backgroundColor: const WidgetStatePropertyAll(Colors.black),
                foregroundColor: const WidgetStatePropertyAll(Colors.white),
              ),
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
