import 'package:chat_online/model/message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    print(message);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        children: [
          ! message.isMine(message.uuid) ?
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(message.photoUrl),
            ),
          ) : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment: ! message.isMine(message.uuid) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                message.imageUrl != null ?
                Image.network(message.imageUrl, width: 200) :
                Text(
                  message.text,
                  textAlign: ! message.isMine(message.uuid) ? TextAlign.start : TextAlign.end,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 16 ),
                ),
                Text(
                  message.senderName,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          message.isMine(message.uuid) ?
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(message.photoUrl),
            ),
          ) : Container()
        ],
      ),
    );
  }
}
