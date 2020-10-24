import 'package:flutter/material.dart';
import 'package:zikanri/config.dart';

class UserDetailController with ChangeNotifier {
  UserDetailController({
    @required this.themeColor,
    @required this.isDark,
    @required this.isFavorite,
    @required this.user,
  });

  bool isFavorite;
  bool isDark;
  double hideHeight = 0;
  double hideWidth = 0;
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
    isChanging = true;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 250));
    this.themeColor = color;
    hideHeight = 0;
    hideWidth = 0;
    await Future.delayed(Duration(milliseconds: 250));
    isChanging = false;
    notifyListeners();
  }

  void switchFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
