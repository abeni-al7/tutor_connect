import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutor_connect/components/my_button.dart';
import 'package:tutor_connect/components/my_textfield.dart';
import 'package:tutor_connect/helper/helper_functions.dart';

class TutorRegisterPage extends StatefulWidget {
  final void Function()? login;
  final void Function()? studentRegister;

  const TutorRegisterPage(
      {super.key, required this.login, required this.studentRegister});

  @override
  State<TutorRegisterPage> createState() => _TutorRegisterPageState();
}

class _TutorRegisterPageState extends State<TutorRegisterPage> {
  // text Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Tutor register method
  void tutorRegister() async {
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
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        if (context.mounted) Navigator.pop(context);

        // show error to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create a user document and add it to firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Tutors")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text,
        'bio': bioController.text,
        'education': educationController.text,
        'experience': experienceController.text,
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
                    hintText: "About me",
                    obscureText: false,
                    controller: bioController),
                const SizedBox(height: 10),

                // education textfield
                MyTextField(
                    hintText: "Educational background",
                    obscureText: false,
                    controller: educationController),
                const SizedBox(height: 10),

                // experience textfield
                MyTextField(
                    hintText: "Relevant Experience",
                    obscureText: false,
                    controller: experienceController),
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
                MyButton(text: "Register", onTap: tutorRegister),
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
