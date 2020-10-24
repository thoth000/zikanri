//packages
import 'package:flutter/material.dart';

class LatelyController with ChangeNotifier {
  LatelyController(int length) {
    this.index = length - 1;
  }
  int index = 0;

  void changeIndex(int i) {
    index = i;
    notifyListeners();
  }
}
