//packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
//my files
import 'package:zikanri/config.dart';

class ThemeNotifier with ChangeNotifier {
  final themeBox = Hive.box('theme');

  bool isDark = false;
  int themeColorIndex = 0;
  List<Color> _themeColors() => baseColors[themeColorIndex];
  List<Color> get themeColors => _themeColors();
  ThemeData buildTheme() => ThemeData(
        fontFamily: 'NotoSansJP',
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryIconTheme: IconThemeData(
          color: isDark ? _themeColors()[0] : _themeColors()[1],
        ),
        iconTheme: IconThemeData(
          color: isDark ? _themeColors()[0] : _themeColors()[1],
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      );
  Future<void> changeMode() async {
    isDark = !isDark;
    notifyListeners();
    await themeBox.put('isDark', isDark);
  }

  Future<void> changeTheme(int i) async {
    themeColorIndex = i;
    notifyListeners();
    await themeBox.put('themeColorsIndex', themeColorIndex);
  }

  Future<void> initialize() async {
    isDark = await themeBox.get('isDark');
    themeColorIndex = await themeBox.get('themeColorsIndex');
    notifyListeners();
  }

  Future<void> firstOpenDataSet() async {
    await themeBox.put('isDark', false);
    await themeBox.put('themeColorsIndex', 0);
    await initialize();
  }
}
