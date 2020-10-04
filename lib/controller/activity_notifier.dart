//packages
import 'package:flutter/material.dart';

class ActivityNotifier with ChangeNotifier {
  bool isGood = false;
  bool isRecording = false;

  void changeValue(bool b) {
    if (isGood == b) {
      return;
    }
    isGood = b;
    notifyListeners();
  }

  void startRecord() {
    isRecording = true;
    notifyListeners();
  }
}
