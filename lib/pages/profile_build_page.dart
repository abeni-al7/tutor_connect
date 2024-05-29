import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/components/dropdown_question_bar.dart';
import 'package:tutor_connect/components/my_button.dart';
import 'package:tutor_connect/components/my_text_field.dart';

class ProfileBuildPage extends StatelessWidget {
  final fullNameController = TextEditingController();
  final genderController = DropdownQuestionController();
  final typeController = DropdownQuestionController();

  ProfileBuildPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // Sign out the user
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text(
              "TutorConnect",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout, color: Colors.white),
            )
          ]),
      body: Center(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Center(
              child: Text("Let us build your profile",
                  style: TextStyle(fontSize: 20)),
            ),
          ),

          // Full name
          MyTextField(
            controller: fullNameController,
            hintText: 'Full name',
            obscureText: false,
          ),
          const SizedBox(height: 10),

          // Gender
          DropdownQuestionBar(
              question: 'Gender',
              controller: genderController,
              options: const ["Male", "Female"]),

          // Type
          DropdownQuestionBar(
            question: 'I am or I represent:',
            controller: typeController,
            options: const ["Tutor", "Student"],
          ),

          // Button
          MyButton(
              onTap: () {
                if (typeController.selectedValue == "Tutor") {
                  // Go to tutor builder
                  Navigator.pushNamed(
                    context,
                    '/tutor_builder',
                  );
                } else if (typeController.selectedValue == "Student") {
                  // Go to student builder
                  Navigator.pushNamed(context, '/student_builder');
                }
              },
              text: "Next")
        ]),
      ),
    );
  }
}
