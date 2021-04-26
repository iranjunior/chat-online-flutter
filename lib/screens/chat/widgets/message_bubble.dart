import 'package:chat_online/model/message.dart';
import 'package:flutter/material.dart';
import 'package:chat_online/extensions/timestamp.dart';

class MessageBubble extends StatelessWidget {
  final Message _message;
  final bool _isPropety;
  const MessageBubble({
    Key key,
    @required Message message,
    @required bool isPropety,
  })  : _message = message,
        _isPropety = isPropety,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          _isPropety ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    '${_message.message}',
                    softWrap: true,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: _isPropety ? Colors.yellow[50] : Colors.blue[50],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft:
                        _isPropety ? Radius.circular(12) : Radius.circular(0),
                    topRight:
                        _isPropety ? Radius.circular(0) : Radius.circular(12)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
              _isPropety ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(
              '${_message.timestamp.getDateFormated()}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
