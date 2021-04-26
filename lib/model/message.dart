import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderName;
  String senderUid;
  String message;
  int status;
  Timestamp timestamp;

  Message.fromMap(Map<String, dynamic> value) {
        this.senderName = value['senderName'];
        this.senderUid = value['senderUid'];
        this.message = value['message'];
        this.status = value['status'];
        this.timestamp = value['timestamp'];
  }

  @override
  String toString() {
    return 'senderName: $senderName, senderUid: $senderUid, message: $message, status: $status, timestamp: $timestamp';
  }
}
