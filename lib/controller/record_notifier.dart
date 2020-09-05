//packages
import 'package:flutter/material.dart';
//my files
import 'package:zikanri/config.dart';

class RecordNotifier with ChangeNotifier {
  String title = '';
  int time = 0;
  int categoryIndex = 0;
  bool isGood = false;
  bool isRecord = true;
  bool timeCheck = true;
  bool titleCheck = true;
  bool check() => isRecord ? (titleCheck || timeCheck) : titleCheck;

  void changeTitle(String s) {
    if (s.isEmpty) {
      titleCheck = true;
    } else {
      title = s;
      titleCheck = false;
    }
    notifyListeners();
  }

  void changeTime(String s) {
    if (s.isEmpty) {
      timeCheck = true;
    } else {
      final int _minute = int.parse(s);
      if (_minute > 1440 || _minute == 0) {
        timeCheck = true;
      } else {
        timeCheck = false;
        time = _minute;
      }
    }
    notifyListeners();
  }

  void changeValue(bool b) {
    if (isGood == b) {
      return;
    }
    isGood = b;
    Vib.select();
    notifyListeners();
  }

  void changeCategoryIndex(int index) {
    categoryIndex = index;
    notifyListeners();
  }

  void recordMode() {
    if (isRecord == true) {
      return;
    }
    Vib.select();
    isRecord = true;
    time = 0;
    timeCheck = true;
    notifyListeners();
  }

  void startMode() {
    if (isRecord == false) {
      return;
    }
    Vib.select();
    isRecord = false;
    time = 0;
    timeCheck = false;
    notifyListeners();
  }
}
