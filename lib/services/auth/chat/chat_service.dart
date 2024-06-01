import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutor_connect/models/message.dart';

class ChatService {
  // get instance of firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream(String role) {
    return firestore.collection(role).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each tutor
        final user = doc.data();

        // return tutor
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String recieverEmail, message) async {
    // get current user info
    final String currentUserId = auth.currentUser!.uid;
    final String? currentUserEmail = auth.currentUser!.email;
    final Timestamp timeStamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      message: message,
      senderId: currentUserId,
      senderEmail: currentUserEmail!,
      recieverEmail: recieverEmail,
      timestamp: timeStamp,
    );

    // construct chatRoom Id for the two users
    List<String> ids = [currentUserEmail, recieverEmail];
    ids.sort();
    String chatRoomId = ids.join('_');

    // add new message to database
    await firestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userEmail, String? otherUserEmail) {
    // construct chatRoom Id for the users
    List<String?> ids = [userEmail, otherUserEmail];
    ids.sort();
    String chatRoomId = ids.join('_');

    // get messages
    return firestore
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("Messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
