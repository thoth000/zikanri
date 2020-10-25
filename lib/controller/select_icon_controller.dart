//packages
import 'package:flutter/material.dart';

class SelectIconController with ChangeNotifier {
  SelectIconController({@required this.beforeIcon}) {
    selectedIcon = this.beforeIcon;
    notifyListeners();
  }

  int beforeIcon;
  int selectedIcon;

  void selectIcon(int iconNum) {
    selectedIcon = iconNum;
    notifyListeners();
  }
}
