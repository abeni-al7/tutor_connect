import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutor_connect/components/my_button.dart';
import 'package:tutor_connect/components/my_textfield.dart';
import 'package:tutor_connect/helper/helper_functions.dart';

class StudentRegisterPage extends StatefulWidget {
  final void Function()? login;
  final void Function()? tutorRegister;

  const StudentRegisterPage(
      {super.key, required this.login, required this.tutorRegister});

  @override
  State<StudentRegisterPage> createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {
  // text Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController gradeLevelController = TextEditingController();
  final TextEditingController strengthsController = TextEditingController();
  final TextEditingController weaknessesController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Student register method
  void studentRegister() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (passwordController.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error to user
      displayMessageToUser("Passwords don't match", context);
    } else {
      // try creating tutor user
      try {
        // create user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // create user document
        createUserDocument(userCredential);

        // pop loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);

        // show error to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create a user document and add it to firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Students")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
        'bio': bioController.text,
        'grade': gradeLevelController.text,
        'strengths': strengthsController.text,
        'weaknesses': weaknessesController.text,
        'budget': budgetController.text
      });
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

                // username textfield
                MyTextField(
                    hintText: "Username",
                    obscureText: false,
                    controller: userNameController),
                const SizedBox(height: 10),

                // email textfield
                MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController),
                const SizedBox(height: 10),

                // bio textfield
                MyTextField(
                    hintText: "About Student",
                    obscureText: false,
                    controller: bioController),
                const SizedBox(height: 10),

                // grade level textfield
                MyTextField(
                    hintText: "Grade level",
                    obscureText: false,
                    controller: gradeLevelController),
                const SizedBox(height: 10),

                // strengths textfield
                MyTextField(
                    hintText: "Strengths as a student",
                    obscureText: false,
                    controller: strengthsController),
                const SizedBox(height: 10),

                // weaknesses textfield
                MyTextField(
                    hintText: "Weaknesses",
                    obscureText: false,
                    controller: weaknessesController),
                const SizedBox(height: 10),

                // budget textfield
                MyTextField(
                    hintText: "Budget per hour",
                    obscureText: false,
                    controller: budgetController),
                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController),
                const SizedBox(height: 25),

                // confirm password textfield
                MyTextField(
                    hintText: "Confirm Password",
                    obscureText: true,
                    controller: confirmPasswordController),
                const SizedBox(height: 25),

                // register button
                MyButton(text: "Register", onTap: studentRegister),
                const SizedBox(
                  height: 25,
                ),

                // Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                        onTap: widget.login,
                        child: const Text(
                          "Login here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),

                // Register as a tutor
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Or "),
                    GestureDetector(
                        onTap: widget.tutorRegister,
                        child: const Text(
                          "Register as a tutor",
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
