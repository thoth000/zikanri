import 'package:flutter/material.dart';

class AddTimeController with ChangeNotifier {
  AddTimeController({@required this.index});
  int index = 0;
  int time = 0;
  bool timecheck = false;

  void changeTime(int _time) {
    this.time = _time;
    if (time > 0 && time <= 1000) {
      timecheck = true;
    } else {
      timecheck = false;
    }
    notifyListeners();
  }
}
