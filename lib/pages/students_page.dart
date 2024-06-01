import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/pages/chat_page.dart';
import 'package:tutor_connect/services/auth/chat/chat_service.dart';

import '../helper/helper_functions.dart';

class StudentsPage extends StatelessWidget {
  final ChatService chatService = ChatService();
  StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Students")),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Students").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // error
            if (snapshot.hasError) {
              displayMessageToUser("Something went wrong", context);
            }

            // loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // get all tutors
            if (snapshot.hasData) {
              final students = snapshot.data?.docs;

              return ListView.builder(
                  itemCount: students?.length,
                  itemBuilder: (context, index) {
                    // get individual tutor
                    final student = students?[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      recieverEmail: student?['email'],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(40)),
                        child: ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(40)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text("Username: "),
                                    Text(student?['username']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Bio: "),
                                    Text(student?['bio']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Grade level: "),
                                    Text(student?['grade']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Strengths: "),
                                    Text(student?['strengths']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Weaknesses: "),
                                    Text(student?['weaknesses']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Budget per hour: "),
                                    Text(student?['budget']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(student?['email']),
                        ),
                      ),
                    );
                  });
            } else {
              return (const Text("No data"));
            }
          },
        ));
  }
}
