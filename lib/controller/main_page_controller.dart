import 'package:flutter/material.dart';

class MainPageController with ChangeNotifier {
  int currentIndex = 0;
  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
