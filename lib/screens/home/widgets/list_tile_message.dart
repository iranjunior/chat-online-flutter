import 'package:chat_online/model/chat.dart';
import 'package:chat_online/model/message.dart';
import 'package:chat_online/provider/message.dart';
import 'package:chat_online/screens/chat/page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_online/extensions/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTileMessage extends StatelessWidget {
  const ListTileMessage({
    Key key,
    @required ChatConversation conversations,
  }) : _conversations = conversations, super(key: key);

  final ChatConversation _conversations;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChatPage(
                      chatId: _conversations.uid,
                      nameSender: _conversations.senderName,
                    )));
      },
      tileColor: Colors.grey[200],
      leading: CircleAvatar(
        child:
            Text(_conversations.senderName.characters.first),
      ),
      title: Text(
        _conversations.senderName,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: StreamBuilder(
        stream: Provider.of<MessageProvider>(context)
            .getLastMessages(chatId: _conversations.uid),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final _message =
                Message.fromMap(snapshot.data.docs[0].data());
            return Text(
              _message.message,
              style: TextStyle(
                  fontWeight: _message.status == 0 &&
                          _message.senderUid ==
                              _conversations.senderUid
                      ? FontWeight.w800
                      : FontWeight.w500),
            );
          } else {
            return Text('...carregando');
          }
        },
      ),
      trailing: StreamBuilder(
        stream: Provider.of<MessageProvider>(context)
            .getLastMessages(chatId: _conversations.uid),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final Timestamp _timestamp =
                snapshot.data.docs[0].data()['timestamp'];
            return Text(
                '${_timestamp.getHourFormated()}');
          } else {
            return Text('...carregando');
          }
        },
      ),
    );
  }
}
