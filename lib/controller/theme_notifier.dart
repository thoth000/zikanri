import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zikanri/data.dart';

//changeNotifier for theme
class ThemeNotifier with ChangeNotifier {
  final themeBox = Hive.box('theme');

  bool _isDark = false;
  bool get isDark => _isDark;
  int _themeColorsIndex = 0;
  //List _myColors = [true,true,true,false,false,false,false,false,false,false];
  //List get myColors => _myColors;
  List<Color> _themeColors() => baseColors[_themeColorsIndex];
  List<Color> get themeColors => _themeColors();
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
  Future<void> changeMode() async {
    Vib.select();
    _isDark = !_isDark;
    notifyListeners();
    await themeBox.put('isDark', _isDark);
  }

  Future<void> changeTheme(int i) async {
    Vib.select();
    _themeColorsIndex = i;
    notifyListeners();
    await themeBox.put('themeColorsIndex', _themeColorsIndex);
  }

  Future<void> initialize() async {
    _isDark = await themeBox.get('isDark');
    _themeColorsIndex = await themeBox.get('themeColorsIndex');
    notifyListeners();
  }

  Future<void> firstOpenDataSet() async {
    await themeBox.put('isDark', false);
    await themeBox.put('themeColorsIndex', 0);
    await initialize();
  }
}
