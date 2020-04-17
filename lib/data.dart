import 'package:flutter/material.dart';

Size displaySize;
var tmp;

class FontSize {
  static double xxsmall = displaySize.width / 30;
  static double xsmall = displaySize.width / 25;
  static double small = displaySize.width / 20;
  static double midium = displaySize.width / 17;
  static double large = displaySize.width / 15.5;
  static double xlarge = displaySize.width / 12;
  static double xxlarge = displaySize.width / 8;
  static double big = displaySize.width / 6.5;
}

DateTime firstLoginDate;
String previousDate = '2020年07月21日';

int totalPassedDays;
int passedDays = 20;

AssetImage userIcon = AssetImage('images/zikanri_icon.png');

const List iconList = [
  ["57746", "指定なし"],
  ["57680", "勉強"],
  ["58699", "読書"],
  ["58726", "運動"],
  ["57519", "仕事"],
  ["58373", "音楽"],
  ["58378", "イラスト"],
  ["58168", "ゲーム"],
  ["58937", "メディア"],
  ["58917", "SNS"],
  ["58143", "開発"],
  ["59497", "創作"],
  ["60227", "筋トレ"],
  ["58386", "カメラ"],
  ["58899", "ドライブ"],
  ["58721", "食事"],
  ["60231", "料理"],
  ["59677", "ペット"],
  ["59596", "買い物"],
  ["58693", "園芸"],
];

//BaseColor
const List baseColors = [
  [Color(0XFF39BAE8), Color(0XFF0000A1)],
  [Color(0XFFffcccc), Color(0XFFcaabd8)],
  [Color(0XFFa2a9af), Color(0XFF4c5870)],
  [Color(0XFF08ffc8), Color(0XFF204969)],
  [Color(0XFF947B89), Color(0XFF4E0E2E)],
  [Color(0XFFe8f044), Color(0XFF21bf73)],
];
//userHasColors => call baseColors
List myColors = ['0', '1', '4', '5'];

//changeNotifier for record
class RecordNotifier with ChangeNotifier {
  String _title = "";
  String get title => _title;
  String _category = "57746";
  String get category => _category;
  int _rating = 0;
  int get rating => _rating;
  int _time = 0;
  int get time => _time;
  bool _timecheck = true;
  bool get timecheck => _timecheck;
  var tmp;

  void changeTitle(String s) {
    _title = s;
    notifyListeners();
  }

  void changeTime(String s) {
    int _minite = int.parse(s);
    if (_minite > 1440 || _minite == 0) {
      _timecheck = true;
    } else {
      _timecheck = false;
      _time = _minite;
    }
    notifyListeners();
  }

  void changeValue(int i) {
    if (_rating == i) {
    } else {
      _rating = i;
      notifyListeners();
    }
  }

  void changeCategory(String s) {
    if (_category == s) {
    } else {
      _category = s;
      notifyListeners();
    }
  }

  void initialize() {
    _title = "";
    _category = "57746";
    _time = 0;
    _rating = 0;
    _timecheck = false;
    notifyListeners();
  }
}

//changeNotifier for theme
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

//changeNotifier for userData
class UserDataNotifier with ChangeNotifier {
  int _totalPointScore = 1286749;
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
    _latelyData.removeAt(_latelyData.length - 1);
    _latelyData.add(
      [
        previousDate,
        _todayMinite.toString(),
        _todayPoint.toString(),
        _todayValue,
      ],
    );
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
    _latelyData.removeAt(_latelyData.length - 1);
    _latelyData.add(
      [
        previousDate,
        _todayMinite.toString(),
        _todayPoint.toString(),
        _todayValue,
      ],
    );
    notifyListeners();
  }
}
