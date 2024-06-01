import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutor_connect/components/chat_bubble.dart';
import 'package:tutor_connect/components/my_textfield.dart';
import 'package:tutor_connect/services/auth/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  ChatPage({
    super.key,
    required this.recieverEmail,
  });

  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();

  // send message
  void sendMessage() async {
    // if the text field is occupied
    if (messageController.text.isNotEmpty) {
      // send message
      await chatService.sendMessage(recieverEmail, messageController.text);
      // clear text field
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: buildMessageList(),
          ),

          // display user input
          buildUserInput(context),
        ],
      ),
    );
  }

  // build message list
  Widget buildMessageList() {
    String? userEmail = chatService.auth.currentUser!.email;
    return StreamBuilder(
        stream: chatService.getMessages(recieverEmail, userEmail),
        builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // get all messages
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget buildMessageItem(DocumentSnapshot<Object?> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // align message based on who sent it
    bool isCurrentUser =
        data['senderEmail'] == chatService.auth.currentUser!.email;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ChatBubble(
                  message: data["message"], isCurrentUser: isCurrentUser),
            ]));
  }

  // build user input
  Widget buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          // text field
          Expanded(
            child: MyTextField(
              controller: messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),
          // send button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(40),
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}
