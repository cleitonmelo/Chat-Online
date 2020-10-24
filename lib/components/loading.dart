import 'package:chat_online/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading {
  String text;
  dynamic indicator;
  String assetImage;

  Loading({this.text, this.indicator, this.assetImage});

  Widget build() {
    return Container(
        decoration: BoxDecoration(gradient: linearGradientDefault()),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getContent()));
  }

  List<Widget> getContent() {
    List<Widget> items = [];

    if (indicator != false) {
      items.add(indicator is Widget ? indicator : _getDefaultIndicator());
    }

    if (assetImage != null && assetImage.isNotEmpty) {
      items.add(this._getLogoImage());
    }

    if (text != null && text.isNotEmpty) {
      items.add(_getTextContent());
    }

    return items;
  }

  Widget _getLogoImage() => Image.asset(
    this.assetImage,
    height: 120,
  );

  Widget _getDefaultIndicator() => Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.amber,
    ),
  );

  Widget _getTextContent() => Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        this.text,
        style: GoogleFonts.alef(
            fontSize: 18, color: Colors.white, decoration: TextDecoration.none),
        textAlign: TextAlign.center,
      ));
}