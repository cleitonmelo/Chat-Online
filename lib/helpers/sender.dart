import 'dart:io';

import 'package:chat_online/helpers/login.dart';
import 'package:chat_online/model/message.dart';
import 'package:chat_online/repository/chat.dart';
import 'package:chat_online/storage/file.dart';

class Messenger {
  String text;
  File file;
  bool isImage;

  Messenger({this.text, this.file, this.isImage});

  send() async {
    Message message = _getMessageWithDefaultInformation();

    if (file != null) {
      final task = await FileStorage.upload(
          file: file,
          owner: Auth().uid
      );

      message.imageUrl = (await task.ref.getDownloadURL()).toString();
    }

    if (text != null) {
      message.text = text;
    }

    ChatRepository(message).push();
  }

  Message _getMessageWithDefaultInformation() {
    return Message(
      uuid: Auth().uid,
      photoUrl: Auth().avatarUrl,
      senderName: Auth().name,
      sendAt: DateTime.now(),
    );
  }
}
