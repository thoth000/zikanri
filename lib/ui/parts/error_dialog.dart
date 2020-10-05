import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  ErrorDialog({@required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('エラー'),
      content: Text(error),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
