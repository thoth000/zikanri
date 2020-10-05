import 'package:flutter/material.dart';

class LatelyController with ChangeNotifier {
  int index = 0;

  void changeIndex(int i) {
    index = i;
    notifyListeners();
  }
}
