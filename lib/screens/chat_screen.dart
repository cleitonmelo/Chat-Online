import 'dart:io';

import 'package:chat_online/components/loading.dart';
import 'package:chat_online/helpers/login.dart';
import 'package:chat_online/helpers/sender.dart';
import 'package:chat_online/model/message.dart';
import 'package:chat_online/screens/messages_screen.dart';
import 'package:chat_online/screens/text_composer.dart';
import 'package:chat_online/storage/DB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _stateWaiting = [ConnectionState.waiting, ConnectionState.none];

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  Map<String, dynamic> data = {};

  bool _isLoading = false;
  String _title;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
       setState(() {
         Auth().user = user;
         _title = Auth().isLogged() ? "Olá ${Auth().name}" : '';
      });
    });

    Auth().signIn().then((auth) {
       if (auth.isLoginFails) {
         setState(() {
           snackMessage(
               text: 'Não foi possível fazer o login. Tente novamente mais tarde!',
               color: Colors.red);
         });
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text(_title),
          elevation: 0,
          actions: [
            Auth().isLogged()
                ? IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      Auth().signOut();
                      snackMessage(
                          text: 'Logout efetuado com sucesso.',
                          color: Colors.blue);
                    },
                  )
                : Container()
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: DB.getCollection().orderBy('sendAt').snapshots(),
                builder: (context, snapshot) {
                  if (_stateWaiting.contains(snapshot.connectionState)) {
                    return Loading(text: 'Obtendo dados...').build();
                  }
                  List<DocumentSnapshot> documents =
                      snapshot.data.documents.reversed.toList();
                  return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        Message message =
                            Message.fromMap(documents[index].data);
                        print(message);
                        return ChatMessage(message);
                      });
                },
              ),
            ),
            _isLoading ? LinearProgressIndicator() : Container(),
            TextComposer( _sendMessage ),
          ],
        ));
  }

  Future<dynamic> _sendMessage({String text, File image}) async {
    final FirebaseUser user = await Auth().getUser();

    if (user == null) {
      snackMessage(
           text: 'Não foi possível efetuar o login. Tente novamente.',
           color: Colors.red);
      return;
    }
    Messenger(text: text, file: image).send();
  }

  snackMessage({@required String text, @required Color color}) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
    ));
  }
}
