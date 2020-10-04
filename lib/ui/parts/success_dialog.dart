import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  SuccessDialog({@required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('完了'),
      content: Text(message),
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
