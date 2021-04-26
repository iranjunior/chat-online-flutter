import 'package:chat_online/provider/message.dart';
import 'package:chat_online/provider/user.dart';
import 'package:chat_online/screens/home/widgets/list_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BodyApp extends StatelessWidget {
  const BodyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: StreamBuilder(
              stream: Provider.of<MessageProvider>(context)
                  .getLastConversation(_user),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Text('Sem mensagens'),
                    );
                  }
                  return ListMessages(
                    user: _user,
                    snapshots: snapshot.data.docs,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}
