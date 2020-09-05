//packages
import 'package:flutter/material.dart';
//myfiles
import 'package:zikanri/config.dart';

class ActivityNotifier with ChangeNotifier {
  bool isGood = false;
  bool isRecording = false;

  void changeValue(bool b) {
    if (isGood == b) {
      return;
    }
    isGood = b;
    Vib.select();
    notifyListeners();
  }

  void startRecord() {
    isRecording = true;
    notifyListeners();
  }
}
