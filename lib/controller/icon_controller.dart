import 'package:flutter/material.dart';

class IconController with ChangeNotifier{
  IconController({this.index, int icon}){
    selectIcon(icon);
  }
  int index;
  int selectedIcon=0;

  void selectIcon(int icon){
    selectedIcon = icon;
    notifyListeners();
  }
}