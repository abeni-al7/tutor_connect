import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/components/my_button.dart';
import 'package:tutor_connect/components/my_text_field.dart';

class StudentBuilderPage extends StatelessWidget {
  final bioController = TextEditingController();
  final educationController = TextEditingController();
  final experienceController = TextEditingController();

  StudentBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('TutorConnect', style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: const Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyTextField(
                  controller: bioController,
                  hintText: "Some details",
                  obscureText: false),
            ),

            // Grade
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyTextField(
                  controller: educationController,
                  hintText: "Grade level",
                  obscureText: false),
            ),

            // Age
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyTextField(
                  controller: experienceController,
                  hintText: "Age",
                  obscureText: false),
            ),

            // Strengths
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyTextField(
                  controller: experienceController,
                  hintText: "Areas of strength",
                  obscureText: false),
            ),

            // Weaknesses
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyTextField(
                  controller: experienceController,
                  hintText: "Areas that need to be improved",
                  obscureText: false),
            ),

            // Budget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MyTextField(
                  controller: experienceController,
                  hintText: "Budget",
                  obscureText: false),
            ),

            // Button
            MyButton(
                onTap: () {
                  Navigator.pushNamed(context, '/homepage');
                },
                text: "Done"),
          ],
        ),
      ),
    );
  }
}
