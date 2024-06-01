import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/components/my_button.dart';
import 'package:tutor_connect/components/my_textfield.dart';
import 'package:tutor_connect/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? studentRegister;
  final void Function()? tutorRegister;

  const LoginPage(
      {super.key, required this.studentRegister, required this.tutorRegister});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login method
  void login() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    }

    // display any errors
    on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Icon(Icons.group,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary),
                const SizedBox(
                  height: 25,
                ),

                // app name
                const Text(
                  'T U T O R C O N N E C T',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),

                // email textfield
                MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController),
                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController),
                const SizedBox(height: 25),

                // sign in button
                MyButton(text: "Login", onTap: login),
                const SizedBox(
                  height: 25,
                ),

                // Register as a tutor
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                        onTap: widget.tutorRegister,
                        child: const Text(
                          "Register as a tutor",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),

                // Register as a student
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Or "),
                    GestureDetector(
                        onTap: widget.studentRegister,
                        child: const Text(
                          "Register a student",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
