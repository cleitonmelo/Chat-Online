import 'package:chat_online/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

void main() async {
  runApp(MyApp());

  Firestore.instance.collection('messages').document('4yUxoN3FXWMkIIXy8CKv')
      .snapshots().listen((event) {
        print(event.data);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        iconTheme: IconThemeData(
          color: Colors.indigo
        )
      ),
      home: ChatScreen(),
    );
  }
}
