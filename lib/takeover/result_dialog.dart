//packages
import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  ResultDialog({this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('結果'),
      content: Text(message),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
