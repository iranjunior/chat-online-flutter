import 'package:chat_online/model/chat.dart';
import 'package:chat_online/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'list_tile_message.dart';

class ListMessages extends StatelessWidget {
  const ListMessages({
    Key key,
    @required UserApp user,
    @required List<QueryDocumentSnapshot> snapshots,
  }) : _user = user, 
   _snapshots = snapshots, 
  super(key: key);

  final UserApp _user;
  final List<QueryDocumentSnapshot> _snapshots;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _snapshots.length,
      itemBuilder: (_, index) {
        final indexOther = _snapshots[index]
            .data()['persons']
            .indexWhere((value) => value['uid'] != _user.uid);
        final indexMe = _snapshots[index]
            .data()['persons']
            .indexWhere((value) => value['uid'] == _user.uid);
        final _conversations = ChatConversation(
          uid: _snapshots[index].id,
          senderUid: _snapshots[index].data()['persons']
              [indexOther]['uid'],
          senderName: _snapshots[index].data()['persons']
              [indexOther]['name'],
          receivedUid: _snapshots[index].data()['persons']
              [indexMe]['uid'],
          receivedName: _snapshots[index]
              .data()['persons'][indexMe]['name'],
        );
        return ListTileMessage(conversations: _conversations);
      },
    );
  }
}

