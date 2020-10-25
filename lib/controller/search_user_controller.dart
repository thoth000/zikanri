//packages
import 'package:flutter/material.dart';

class SearchUserController with ChangeNotifier {
  final textController = TextEditingController();
  String text = '';

  void changeText(String _text) {
    if (_text.isEmpty) {
      this.text = '';
    } else {
      this.text = _text;
    }
    notifyListeners();
  }
}
