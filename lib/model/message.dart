import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Message {
  static const PRETTY_DATE_FORMAT = 'E, d MMMM y H:m';

  String id;
  String uuid;
  String text;
  String imageUrl;
  String photoUrl;
  String senderName;
  DateTime sendAt;
  DateTime readAt;
  bool read;

  Message({
    this.uuid,
    this.text,
    this.imageUrl,
    this.photoUrl,
    this.sendAt,
    this.readAt,
    this.read,
    this.senderName,
  });

  Map<String, dynamic> toMap(){
    return {
      'uuid': uuid,
      'imageURL': imageUrl,
      'read': read ?? false,
      'readAt': readAt,
      'sendAt': sendAt,
      'text': text,
      'photoUrl': photoUrl,
      'senderName': senderName,
    };
  }

  String toString(){
    return toMap().toString();
  }

  Message.fromMap(Map<String, dynamic> data){
    uuid = data['uuid'] ?? null;
    imageUrl = data['imageURL'] ?? null;
    read = data['read'] ?? null;
    readAt = data['readAt'] != null ? data['readAt'].toDate() : null;
    sendAt = data['sendAt'].toDate();
    text = data['text'] ?? null;
    photoUrl = data['photoUrl'] ?? null;
    senderName = data['senderName'] ?? null;
  }

  markAsRead() {
    readAt = DateTime.now();
    read = true;
  }

  markAsUnread() {
    readAt = null;
    read = false;
  }

  _initDateFormatter() {
    Intl.defaultLocale = 'pt_BR';
    initializeDateFormatting();
  }

  String get sentAtFormatted {
    _initDateFormatter();
    return sendAt != null
        ? DateFormat(PRETTY_DATE_FORMAT).format(sendAt)
        : null;
  }

  String get readAtFormatted {
    _initDateFormatter();
    return readAt != null
        ? DateFormat(PRETTY_DATE_FORMAT).format(readAt)
        : null;
  }

  String get readTime {
    _initDateFormatter();
    return readAt != null ? DateFormat('H:m').format(readAt) : null;
  }

  bool isMine(String uuid) {
    return this.uuid == uuid;
  }
}