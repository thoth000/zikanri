import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  static double big = displaySize.width / 6;
}

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
  ["58143", "IT"],
  ["58386", "カメラ"],
  ["58899", "ドライブ"],
  ["59601", "生活"],
  ["58693", "園芸"],
];

//BaseColor
//単色をベースにしていく
const List baseColors = [
  [Color(0XFF1DA1F2), Color(0XFF1DA1F2)], //単色
  [Color(0XFFea7070), Color(0XFFea7070)], //単色
  [Color(0XFF3b8686), Color(0XFF3b8686)], //単色
  [Color(0XFF39BAE8), Color(0XFF0000A1)],
  [Color(0XFFffcccc), Color(0XFFcaabd8)],
  [Color(0XFFa2a9af), Color(0XFF4c5870)],
  [Color(0XFF08ffc8), Color(0XFF204969)],
  [Color(0XFF947B89), Color(0XFF4E0E2E)],
  [Color(0XFFe8f044), Color(0XFF21bf73)],
];
//userHasColors => call baseColors

List activities = [];

//changeNotifier for record
class RecordNotifier with ChangeNotifier {
  String _title = "";
  String get title => _title;
  bool _isRecord = true;
  bool get isRecord => _isRecord;
  String _category = "57746";
  String get category => _category;
  int _rating = 1;
  int get rating => _rating;
  int _time = 0;
  int get time => _time;
  bool _timecheck = true;
  bool get timecheck => _timecheck;

  void changeTitle(String s) {
    _title = s;
    notifyListeners();
  }

  void changeTime(String s) {
    int _minute = int.parse(s);
    if (_minute > 1440 || _minute == 0) {
      _timecheck = true;
    } else {
      _timecheck = false;
      _time = _minute;
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

  void recordMode() {
    if (_isRecord == true) {
    } else {
      _isRecord = true;
      notifyListeners();
    }
  }

  void startMode() {
    if (_isRecord == false) {
    } else {
      _isRecord = false;
      _time = 0;
      _timecheck = false;
      notifyListeners();
    }
  }

  void reset() {
    _title = "";
    _category = "57746";
    _time = 0;
    _rating = 1;
    _timecheck = false;
    _isRecord = true;
    notifyListeners();
  }
}

//changeNotifier for theme
class ThemeNotifier with ChangeNotifier {
  //Theme
  bool _isDark = false;
  bool get isDark => _isDark;
  int _themeColorsIndex = 0;
  List _myColors = ['0', '1', '2', '3', '4', '5', '6', '7'];
  List get myColors => _myColors;
  List _themeColors() => baseColors[int.parse(_myColors[_themeColorsIndex])];
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
  Future changeMode() async {
    _isDark = !_isDark;
    await Hive.box('theme').put('isDark', _isDark);
    notifyListeners();
  }

  Future changeTheme(int i) async {
    _themeColorsIndex = i;
    await Hive.box('theme').put('themeColorsIndex', _themeColorsIndex);
    notifyListeners();
  }

  Future addTheme(int i) async {
    _myColors.add(i);
    await Hive.box('theme').put('myColors', _myColors);
    notifyListeners();
  }

  Future initialize() async {
    var box = Hive.box('theme');
    _isDark = await box.get('isDark');
    _themeColorsIndex = await box.get('themeColorsIndex');
    _myColors = await box.get('myColors');
    notifyListeners();
  }
}

//changeNotifier for userData
class UserDataNotifier with ChangeNotifier {
  String userName = "ゲスト";
  String userID = "";
  bool registerCheck = false;
  String previousDate = "2020年01月01日";
  String thisMonth = "01";
  int totalPassedDays = 1;
  int passedDays = 1;
  /*
  int _allTime = 0;
  int get aTime => _allTime;
  int _allGood = 0;
  int get aGood => _allGood;
  int _allPer = 0;
  int get allPer => _allPer;
  int _thisMonthTime = 0;
  int get thisMonthTime => _thisMonthTime;
  int _thisMonthGood = 0;
  int get thisMonthGood => _thisMonthGood;
  int _thisMonthPer = 0;
  int get thisMonthPer => _thisMonthPer;
  int _todayTime = 0;
  int get todayTime => _todayTime;
  int _todayGood = 0;
  int get todayGood => _todayGood;
  int _todayPer = 0;
  int get todayPer => _todayPer;
  */
  int _totalPointScore = 0;
  int get totalPointScore => _totalPointScore;
  int _thisMonthPoint = 0;
  int get thisMonthPoint => _thisMonthPoint;
  int _thisMonthMinute = 0;
  int get thisMonthMinute => _thisMonthMinute;

  String _thisMonthValue = '0.00';
  String get thisMonthValue => _thisMonthValue;
  int _thisMonthAverage = 0;
  int get thisMonthAverage => _thisMonthAverage;

  int _todayPoint = 0;
  int get todayPoint => _todayPoint;
  int _todayMinute = 0;
  int get todayMinute => _todayMinute;
  String _todayValue = '0.00';
  String get todayValue => _todayValue;
  //日付,時間,総ポイント,時間価値,DoneList
  List _latelyData = [];
  List get latelyData => _latelyData;

  int index = 0;
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  List _todayDoneList = [];
  List get todayDoneList => _todayDoneList;

  List _shortCuts = [];
  List get shortCuts => _shortCuts;

  Future addShortCuts(item) async {
    _shortCuts.add(item);
    notifyListeners();
    await Hive.box('userName').put('shortCuts', _shortCuts);
  }

  Future addActivities(
    DateTime startTime,
    String title,
    String category,
  ) async {
    /*スタートした時刻、
    ストップ
    タイトル、
    カテゴリー、
    ストップしたときに更新する時間（スタート時刻は再スタートした時刻に更新する）
    */
    activities.add([startTime, false, title, category, 0]);
    await Hive.box('userData').put('activities', activities);
    notifyListeners();
  }

  Future recordDone(listData) async {
    int _point = int.parse(listData[4]);
    int _minute = int.parse(listData[2]);
    _totalPointScore += _point;
    _thisMonthPoint += _point;
    _todayPoint += _point;
    _thisMonthMinute += _minute;
    _todayMinute += _minute;
    _thisMonthAverage = (_thisMonthPoint / passedDays).round();
    _thisMonthValue = (_thisMonthPoint / _thisMonthMinute).toStringAsFixed(2);
    _todayValue = (_todayPoint / _todayMinute).toStringAsFixed(2);
    _todayDoneList.add(listData);
    _latelyData.removeAt(_latelyData.length - 1);
    _latelyData.add(
      [
        previousDate,
        _todayMinute.toString(),
        _todayPoint.toString(),
        _todayValue,
        _todayDoneList,
      ],
    );
    notifyListeners();
    /*
    time=listData[2];
    _allTime += time;
    _thisMonthTime += time;
    _todayTime += time;
    if(listData[3]){
      _allGood += time;
      _thisMonthGood += time;
      _todayGood += time;
    }
    _allPer = (_allGood / _allTime).round();
    _thisMonthPer = (_thisMonthGood / _thisMonthTime).round();
    _todayPer = (_todayGood / _todayTime).round();
    _todayDoneList.add(listData);
    _latelyData.removeAt(_latelyData.length - 1);
    _latelyData.add(
      [
        previousDate,
        _todayTime,
        _todayGood,
        _todayPer,
        _todayDoneList,
      ],
    );
    notifyListeners();
    */
    await Hive.box('userData').put('userValue', [
      _totalPointScore,
      _thisMonthPoint,
      _thisMonthMinute,
      _thisMonthValue,
      _thisMonthAverage,
      _todayPoint,
      _todayMinute,
      _todayValue,
    ]);
    await Hive.box('userData').put('todayDoneList', _todayDoneList);
    await Hive.box('userData').put('latelyData', _latelyData);
  }

  Future deleteDone(listData, index) async {
    int _point = int.parse(listData[4]);
    int _minute = int.parse(listData[2]);
    _totalPointScore -= _point;
    _thisMonthPoint -= _point;
    _todayPoint -= _point;
    _thisMonthMinute -= _minute;
    _todayMinute -= _minute;
    _thisMonthAverage = (_thisMonthPoint / passedDays).round();
    _thisMonthValue = (_thisMonthPoint / _thisMonthMinute).toStringAsFixed(2);
    _todayValue = (_todayPoint / _todayMinute).toStringAsFixed(2);
    _todayDoneList.removeAt(index);
    _latelyData.removeAt(_latelyData.length - 1);
    _latelyData.add(
      [
        previousDate,
        _todayMinute.toString(),
        _todayPoint.toString(),
        _todayValue,
        _todayDoneList,
      ],
    );

    /*
    time=listData[2];
    _allTime += time;
    _thisMonthTime += time;
    _todayTime += time;
    if(listData[3]){
      _allGood += time;
      _thisMonthGood += time;
      _todayGood += time;
    }
    _allPer = (_allGood / _allTime).round();
    _thisMonthPer = (_thisMonthGood / _thisMonthTime).round();
    _todayPer = (_todayGood / _todayTime).round();
    notifyListeners();
    */

    await Hive.box('userData').put('userValue', [
      _totalPointScore,
      _thisMonthPoint,
      _thisMonthMinute,
      _thisMonthValue,
      _thisMonthAverage,
      _todayPoint,
      _todayMinute,
      _todayValue,
    ]);
    await Hive.box('userData').put('todayDoneList', _todayDoneList);
    await Hive.box('userData').put('latelyData', _latelyData);
    notifyListeners();
  }

  Future finishActivity(itemList, i) async {
    //これして
    activities.removeAt(i);
    await Hive.box('userData').put('activities', activities);
    notifyListeners();
  }

  Future initialize() async {
    var box = Hive.box('userData');
    var userValue = await box.get('userValue');
    _totalPointScore = userValue[0];
    _thisMonthPoint = userValue[1];
    _thisMonthMinute = userValue[2];
    _thisMonthValue = userValue[3];
    _thisMonthAverage = userValue[4];
    _todayPoint = userValue[5];
    _todayMinute = userValue[6];
    _todayValue = userValue[7];
    /*
    _allTime = userValue[0];
    _allGood = userValue[1];
    _allPer = userValue[2];
    _tmTime = userValue[3];
    _tmGood = userValue[4];
    _tmPer = userValue[5];
    _tTime = userValue[6];
    _tGood = userValue[7];
    _tPer = userValue[8];
    */
    _latelyData = await box.get('latelyData');
    _todayDoneList = await box.get('todayDoneList');
    _shortCuts = await box.get('shortCuts');
    userName = await box.get('userName');
    userID = await box.get('userID');
    registerCheck = await box.get('resisterCheck');
    previousDate = await box.get('previousDate');
    thisMonth = await box.get('thisMonth');
    totalPassedDays = await box.get('totalPassedDays');
    passedDays = await box.get('passedDays');
  }
}

class ReloadNotifier with ChangeNotifier {
  bool _reload = false;
  bool get reload => _reload;
  void reloded() {
    _reload = true;
    notifyListeners();
  }

  void finishload() {
    _reload = false;
    notifyListeners();
  }
}
