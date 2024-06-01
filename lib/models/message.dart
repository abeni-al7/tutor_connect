import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverEmail;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.senderId,
    required this.senderEmail,
    required this.recieverEmail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverEmail': recieverEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
