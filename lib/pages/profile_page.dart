import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // fetch user profile details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("No current user");
    }

    String email = currentUser.email ?? "";

    // Check if the user exists in the "Tutors" collection
    var tutorSnapshot =
        await FirebaseFirestore.instance.collection("Tutors").doc(email).get();

    if (tutorSnapshot.exists) {
      return tutorSnapshot;
    } else {
      // Otherwise, return the user details from the "Students" collection
      return await FirebaseFirestore.instance
          .collection("Students")
          .doc(email)
          .get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile")),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // error
          else if (snapshot.hasError) {
            return (Text("Error: ${snapshot.error}"));
          }

          // data
          else if (snapshot.hasData) {
            // extract data
            Map<String, dynamic>? user = snapshot.data!.data();

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: user!.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${entry.key}: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          TextSpan(
                            text: '${entry.value}',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return (Text("No data"));
          }
        },
      ),
    );
  }
}
