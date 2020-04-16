import 'package:flutter/material.dart';

Size displaySize;
DateTime firstLoginDate;
String previousDate = '2020年07月21日';

int totalPassedDays;
int passedDays = 20;

//記録追加時の必要変数
String title = '';
double rating = 0.0;
int time = 0;
int tmpValue = 0;
var tmp=0;

AssetImage userIcon = AssetImage('images/zikanri_icon.png');

//BaseColor
List baseColors = [
  [Color(0XFF39BAE8), Color(0XFF0000A1)],
  [Color(0XFFffcccc), Color(0XFFcaabd8)],
  [Color(0XFFa2a9af), Color(0XFF4c5870)],
  [Color(0XFF08ffc8), Color(0XFF204969)],
  [Color(0XFF947B89), Color(0XFF4E0E2E)],
  [Color(0XFFe8f044), Color(0XFF21bf73)],
];
//userHasColors => call baseColors
List myColors = ['0', '1', '4', '5'];

class ThemeNotifier with ChangeNotifier {
  //Theme
  bool _isDark = false;
  bool get isDark => _isDark;
  int _themeColorsIndex = 0;
  List _themeColors() => baseColors[int.parse(myColors[_themeColorsIndex])];
  List get themeColors => _themeColors();

  ThemeData buildTheme() => ThemeData(
        fontFamily: 'NotoSansJP',
        brightness: _isDark ? Brightness.dark : Brightness.light,
        buttonColor: _isDark ? _themeColors()[0] : _themeColors()[1],
        primaryIconTheme: IconThemeData(
          color: _isDark ? _themeColors()[0] : _themeColors()[1],
        ),
        iconTheme: IconThemeData(
          color: _isDark ? _themeColors()[0] : _themeColors()[1],
        ),
        textTheme: TextTheme(
          body1: TextStyle(
            color: _isDark ? Colors.white : Colors.black,
          ),
        ),
      );
  void changeMode() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void changeTheme(int i) {
    _themeColorsIndex = i;
    notifyListeners();
  }
}

class UserDataNotifier with ChangeNotifier {
  int _totalPointScore = 40000;
  int get totalPointScore => _totalPointScore;
  String _userName = 'ゲスト';
  String get userName => _userName;
  String _userID = '123456789';
  String get userID => _userID;
  bool _registerCheck = false;
  bool get registerCheck => _registerCheck;

  int _thisMonthPoint = 30000;
  int get thisMonthPoint => _thisMonthPoint;
  int _thisMonthMinite = 10000;
  int get thisMonthMinite => _thisMonthMinite;
  int _averagePoint = 1500;
  int get averagePoint => _averagePoint;
  String _thisMonthValue = '3.00';
  String get thisMonthValue => _thisMonthValue;
  //List<String>で保存するためにdayDataとdayDoneのデータを分けた。
  //こっちが値系の配列
  //日付,時間,総ポイント,時間価値
  List _latelyData = [
    ['2020年07月19日', '1000', '2900', '2.9'],
    ['2020年07月20日', '2000', '3500', '1.75'],
    ['2020年07月21日', '1640', '7600', '4.63'],
  ];
  List get latelyData => _latelyData;
  //こっちが記録を持っておく配列
  List _latelyDoneData() => [
        todayDoneList2,
        todayDoneList1,
        todayDoneList,
      ];
  List get latelyDoneData => _latelyDoneData();

  int index = 0;
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  int _todayPoint = 7600;
  int get todayPoint => _todayPoint;
  int _todayMinite = 1640;
  int get todayMinite => _todayMinite;
  String _todayValue = '4.63';
  String get todayValue => _todayValue;

  List _todayDoneList = [
    ['58168', '今日はひろしまひろしまスタジアムで試合でした。楽しかった', '120', '5', '600'],
    ['58168', '花火撮影', '120', '0', '0'],
    ['58168', 'イラスト描き', '1400', '5', '7000'],
  ];
  List get todayDoneList => _todayDoneList;

  List todayDoneList1 = [
    ['58168', 'かきくけこ', '120', '5', '600'],
    ['58168', '花火撮影', '120', '0', '0'],
    ['58168', 'イラスト描き', '1439', '5', '7195'],
  ];

  List todayDoneList2 = [
    ['58168', 'あいうえお', '120', '5', '600'],
    ['58168', '花火撮影', '120', '0', '0'],
    ['58168', 'イラスト描き', '1439', '5', '7195'],
  ];

  List _shortCuts = [
    ['58168', '1', '1439', '5', '7195'],
    ['58168', '2', '120', '5', '600'],
    ['58168', '3', '1439', '5', '7195'],
    ['58168', '4', '120', '5', '600'],
    ['58168', '5', '1439', '5', '7195'],
    ['58168', '6', '120', '5', '600'],
    ['58168', '7', '1439', '5', '7195'],
    ['58168', '8', '120', '5', '600'],
  ];
  List get shortCuts => _shortCuts;

  void recordDone(listData) {
    int _point = int.parse(listData[4]);
    int _minite = int.parse(listData[2]);
    _totalPointScore += _point;
    _thisMonthPoint += _point;
    _todayPoint += _point;
    _thisMonthMinite += _minite;
    _todayMinite += _minite;
    _averagePoint = (_thisMonthPoint / passedDays).round();
    _thisMonthValue = (_thisMonthPoint / _thisMonthMinite).toStringAsFixed(2);
    _todayValue = (_todayPoint / _todayMinite).toStringAsFixed(2);
    _todayDoneList.add(listData);
    _latelyData.removeAt(_latelyData.length-1);
    _latelyData.add([previousDate,_todayMinite.toString(),_todayPoint.toString(),_todayValue,]);
    print(_latelyData);
    notifyListeners();
  }

  void deleteDone(listData, index) {
    int _point = int.parse(listData[4]);
    int _minite = int.parse(listData[2]);
    _totalPointScore -= _point;
    _thisMonthPoint -= _point;
    _todayPoint -= _point;
    _thisMonthMinite -= _minite;
    _todayMinite -= _minite;
    _averagePoint = (_thisMonthPoint / passedDays).round();
    _thisMonthValue = (_thisMonthPoint / _thisMonthMinite).toStringAsFixed(2);
    _todayValue = (_todayPoint / _todayMinite).toStringAsFixed(2);
    _todayDoneList.removeAt(index);
    _latelyData.removeAt(_latelyData.length-1);
    _latelyData.add([previousDate,_todayMinite.toString(),_todayPoint.toString(),_todayValue,]);
    notifyListeners();
  }
}
