import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage);

  final Function({String text, File image}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: _sendPhoto,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: "Enviar uma mensagem"),
                controller: _controller,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text) {
                  _sendMessage(_controller);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _isComposing ? () {
                _sendMessage(_controller);
              } : null,
            ),
          ],
        )
    );
  }

  void _reset() {
    setState(() {
      _isComposing = false;
    });
  }

  void _sendMessage(TextEditingController textController) {
    widget.sendMessage(text: textController.text);
    textController.clear();
    _reset();
  }

  Future<void> _sendPhoto() async {
    // ignore: deprecated_member_use
    File photo = await ImagePicker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      return;
    }
    widget.sendMessage(image: photo);
  }
}
