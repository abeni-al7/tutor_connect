import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("TutorConnect")),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: const Padding(
        padding:  EdgeInsets.all(8.0),
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to TutorConnect",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              SizedBox(height: 20),
              Text(
                  "Welcome to T U T O R C O N N E C T where students can find suitable tutors for their academic needs and tutors can find students to help.",
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
