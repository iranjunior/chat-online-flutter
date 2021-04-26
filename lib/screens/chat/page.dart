import 'package:chat_online/model/message.dart';
import 'package:chat_online/provider/message.dart';
import 'package:chat_online/provider/user.dart';
import 'package:chat_online/screens/chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String _chatId;
  final String _nameSender;

  ChatPage({
    Key key,
    @required String chatId,
    @required String nameSender,
  })  : this._chatId = chatId,
        this._nameSender = nameSender,
        super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controllerText = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${this.widget._nameSender}'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.teal[100],
                    BlendMode.lighten,
                  ),
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/26/01/03/2601039697d8c8c730ec09e78a8395e0.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(bottom: 40),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: Provider.of<MessageProvider>(context)
                      .getMessagesWithUser(chatId: widget._chatId),
                  builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (_, index) {
                            final _message = Message.fromMap(
                                snapshot.data.docs[index].data());

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 16.0),
                              child: MessageBubble(
                                message: _message,
                                isPropety: _user.uid == _message.senderUid,
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Text('Falha ao carregar mensagens'),
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 8,
                    right: 8,
                  ),
                  color: Colors.greenAccent[100],
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Escreva sua mensagem...',
                        ),
                        controller: _controllerText,
                      )),
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            await context.read<MessageProvider>()
                                .sendMessage(
                              chatId: widget._chatId,
                              senderUid: _user.uid,
                              message: _controllerText.text,
                            );
                            _controllerText.text = '';
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
