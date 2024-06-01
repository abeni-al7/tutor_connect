import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/pages/chat_page.dart';
import 'package:tutor_connect/services/auth/chat/chat_service.dart';

import '../helper/helper_functions.dart';

class TutorsPage extends StatelessWidget {
  final ChatService chatService = ChatService();
  TutorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Tutors")),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Tutors").snapshots(),
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
              final tutors = snapshot.data?.docs;

              return ListView.builder(
                  itemCount: tutors?.length,
                  itemBuilder: (context, index) {
                    // get individual tutor
                    final tutor = tutors?[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      recieverEmail: tutor?['email'],
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
                                    Text(tutor?['username']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Bio: "),
                                    Text(tutor?['bio']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Education level: "),
                                    Text(tutor?['education']),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Experience: "),
                                    Text(tutor?['strengths']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(tutor?['email']),
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
