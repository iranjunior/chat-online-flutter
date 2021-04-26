import 'dart:async';

import 'package:chat_online/model/user.dart';
import 'package:chat_online/provider/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_online/model/message.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  FirebaseFirestore _firestore;
  StreamSubscription<Message> _messagesStream;
  List<Message> _messages = [];

  MessageProvider(BuildContext context)
      : _firestore = FirebaseFirestore.instance;

  List<Message> get messages => _messages;

  @override
  void dispose() {
    super.dispose();
    _messagesStream.cancel();
  }

  Stream<QuerySnapshot> getLastConversation(UserApp user) {
    CollectionReference _collectionMessage = _firestore.collection('messages');

    return _collectionMessage
        .where('persons',
            arrayContains: Map.from({'name': user.name, 'uid': user.uid}))
        .snapshots();
  }

  Stream<QuerySnapshot> getLastMessages({
    @required String chatId,
  }) {
    CollectionReference _collectionMessage =
        _firestore.collection('messages').doc(chatId).collection('messages');

    return _collectionMessage
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessagesWithUser({@required String chatId}) {
    return _firestore
        .collection('messages')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(100)
        .snapshots();
  }

  Future<void> sendMessage({
    @required String chatId,
    @required String senderUid,
    @required String message,
  }) async {
    await _firestore
        .collection('messages')
        .doc(chatId)
        .collection('messages')
        .add({
      'message': message,
      'senderUid': senderUid,
      'status': 0,
      'timestamp': Timestamp.now()
    });
  }
}
