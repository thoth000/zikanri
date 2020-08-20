import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zikanri/data.dart';

//changeNotifier for theme
class ThemeNotifier with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  int _themeColorsIndex = 0;
  //List _myColors = [true,true,true,false,false,false,false,false,false,false];
  //List get myColors => _myColors;
  List _themeColors() => baseColors[_themeColorsIndex];
  List get themeColors => _themeColors();
  ThemeData buildTheme() => ThemeData(
        fontFamily: 'NotoSansJP',
        brightness: _isDark ? Brightness.dark : Brightness.light,
        primaryIconTheme: IconThemeData(
          color: _isDark ? _themeColors()[0] : _themeColors()[1],
        ),
        iconTheme: IconThemeData(
          color: _isDark ? _themeColors()[0] : _themeColors()[1],
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: _isDark ? Colors.white : Colors.black,
          ),
        ),
      );
  Future changeMode() async {
    Vib.select();
    _isDark = !_isDark;
    notifyListeners();
    await Hive.box('theme').put('isDark', _isDark);
  }

  Future changeTheme(int i) async {
    Vib.select();
    _themeColorsIndex = i;
    notifyListeners();
    await Hive.box('theme').put('themeColorsIndex', _themeColorsIndex);
  }

  Future initialize() async {
    var box = Hive.box('theme');
    _isDark = await box.get('isDark');
    _themeColorsIndex = await box.get('themeColorsIndex');
    notifyListeners();
  }
}
