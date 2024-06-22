import 'package:flutter/material.dart';
import 'package:user_authentication_sqflite/screens/log_in_screen.dart';
import 'package:user_authentication_sqflite/screens/registration_screen.dart';

class StartUp extends StatefulWidget {
  const StartUp({super.key});

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  );

  final TextStyle labels = const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 18,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 247, 249, 249)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 500,
                    width: 250,
                    child: Image.asset("assets/images/two.jpg"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      elevation: 20,
                      backgroundColor: const Color.fromARGB(255, 102, 133, 141),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) {
                        return const RegistrationScreen();
                      }));
                    },
                    child: Text(
                      "Create an account",
                      style: labels,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 102, 133, 141), width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      elevation: 20,
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) {
                        return const LogIn();
                      }));
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 102, 133, 141),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
