//packages
import 'package:flutter/material.dart';

class AchieveController with ChangeNotifier {
  bool isRecord = true;

  void changeAchieve(bool boolean) {
    isRecord = boolean;
    notifyListeners();
  }
}
