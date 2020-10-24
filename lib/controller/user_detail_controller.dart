import 'package:flutter/material.dart';
import 'package:zikanri/config.dart';

class UserDetailController with ChangeNotifier {
  UserDetailController({
    @required this.themeColor,
    @required this.isDark,
    @required this.isFavorite,
    @required this.user,
  }){
    this.hideColor = this.themeColor;
    notifyListeners();
  }

  bool isFavorite;
  bool isDark;
  double hideHeight = 0;
  double hideWidth = 0;
  double borderRadius = 100;
  Color hideColor;
  Map<String, dynamic> user;
  bool isChanging = false;
  Color themeColor;

  Future changeColor(int index) async {
    final colors = baseColors[index];
    final color = isDark ? colors[0] : colors[1];
    hideColor = color;
    notifyListeners();
    hideHeight = displaySize.height + 10;
    hideWidth = displaySize.width + 10;
    borderRadius = 0;
    isChanging = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 300));
    this.themeColor = color;
    hideHeight = 0;
    hideWidth = 0;
    borderRadius = 100;
    await Future.delayed(Duration(milliseconds: 300));
    isChanging = false;
    notifyListeners();
  }

  void switchFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
