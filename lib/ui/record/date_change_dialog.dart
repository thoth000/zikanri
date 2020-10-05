import 'package:flutter/material.dart';

class DateChangeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('日付が変わっています'),
      content: const Text('自動的にタイトル画面に戻ります'),
    );
  }
}