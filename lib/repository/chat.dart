import 'package:chat_online/model/message.dart';
import 'package:chat_online/storage/DB.dart';

class ChatRepository {
  Message message;
  ChatRepository(this.message);

  Future<void> push() async {
    return await DB.create(message.toMap());
  }

  Future<void> save() async {
    return await DB.update(id: message.id, data: message.toMap());
  }
}