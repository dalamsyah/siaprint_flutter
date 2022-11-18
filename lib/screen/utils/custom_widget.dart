import 'package:flutter/material.dart';

class CustomWidget {

  Widget createDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: const <Widget>[
          Text('dialog'),
          Text('text'),
        ],
      ),
    );
  }

}