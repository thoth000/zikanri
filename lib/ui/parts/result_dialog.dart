//packages
import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  ResultDialog({this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
