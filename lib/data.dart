import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';

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

class Vib {
  static void select() {
    Vibration.vibrate(duration: 30);
  }

  static void decide() {
    Vibration.vibrate(duration: 50);
  }

  static void error() {
    Vibration.vibrate(duration: 100);
  }
}

AssetImage userIcon = AssetImage('images/zikanri_icon.png');
const List iconList = [
  [
    58726,
    "運動",
  ],
  [58128, "音楽"],
  [
    58699,
    "読書",
  ],
  [
    58378,
    "イラスト",
  ],
  [
    58168,
    "ゲーム",
  ],
  [59677, "ペット"],
  [
    58937,
    "メディア",
  ],
  [
    58917,
    "SNS",
  ],
  [
    58143,
    "IT",
  ],
  [59497, "創作"],
  [60231, "料理"],
  [60227, "筋トレ"],
  [60236, "リラックス"],
  [59471, "鑑賞"],
  [59540, "ネット"],
  [
    58373,
    "演奏",
  ],
  [58693, "園芸"],
  [57388, "映画"],
  [60222, "バカンス"],
  [60224, "ギャンブル"],
  [59517, "恋愛"],
  [59596, "買い物"],
  [
    58386,
    "カメラ",
  ],
  [
    58899,
    "ドライブ",
  ],
];

//BaseColor
//単色をベースにしていく
//今なんこ,９
const List baseColors = [
  //[Color(0XFF1DA1F2), Color(0XFF1DA1F2)], //0
  //[Color(0XFFea7070), Color(0XFFea7070)], //1
  //[Color(0XFF00CDAC), Color(0XFF02AAB0)], //2
  [Color(0XFF39BAE8), Color(0XFF0000A1)], //3
  [Color(0XFFef473a), Color(0XFFcb2d3e)], //4
  [Color(0XFF08ffc8), Color(0XFF204969)], //緑
  [Color(0XFFffcccc), Color(0XFFcaabd8)],//ピンク
  [Color(0XFF4776E6), Color(0XFF8E54E9)], //紫
  [Color(0XFFFFFDE4), Color(0XFF005AA7)], //7
  [Color(0XFFfffbd5),Color(0XFFb20a2c)], //9
  [Color(0XFFe4e4d9),Color(0XFF215f00)], //9
  [Color(0XFFFFB75E),Color(0XFFED8F03)], //9
  [Color(0XFFffc0cb),Color(0XFF800080)], //9
];
//userHasColors => call baseColors

List activities = [];

//changeNotifier for record
class RecordNotifier with ChangeNotifier {
  String _title = "";
  String get title => _title;
  bool _isRecord = true;
  bool get isRecord => _isRecord;
  int _categoryIndex = 0;
  int get categoryIndex => _categoryIndex;
  bool _isGood = false;
  bool get isGood => _isGood;
  int _time = 0;
  int get time => _time;
  bool _timeCheck = true;
  bool get timeCheck => _timeCheck;
  bool _titleCheck = true;
  bool get titleCheck => _titleCheck;
  bool _clickCheck = false;
  bool get clickCheck => _clickCheck;
  bool _shortCut = false;
  bool get shortCut => _shortCut;

  void changeTitle(String s) {
    _title = s;
    if (_title == "") {
      _titleCheck = true;
    } else {
      _titleCheck = false;
    }
    notifyListeners();
  }

  void changeShortCut() {
    _shortCut = !_shortCut;
    notifyListeners();
  }

  void changeTime(String s) {
    int _minute = int.parse(s);
    if (_minute > 1440 || _minute == 0) {
      _timeCheck = true;
    } else {
      _timeCheck = false;
      _time = _minute;
    }
    notifyListeners();
  }

  void changeValue(bool b) {
    if (_isGood == b) {
    } else {
      _isGood = b;
      Vib.select();
      notifyListeners();
    }
  }

  void click() {
    _clickCheck = true;
    Vib.error();
    notifyListeners();
  }

  void changeCategoryIndex(int index) {
    _categoryIndex = index;
    notifyListeners();
  }

  void recordMode() {
    if (_isRecord == true) {
    } else {
      Vib.select();
      _isRecord = true;
      _time = 0;
      _timeCheck = true;
      _clickCheck = false;
      notifyListeners();
    }
  }

  void startMode() {
    if (_isRecord == false) {
    } else {
      Vib.select();
      _isRecord = false;
      _time = 0;
      _timeCheck = false;
      _clickCheck = false;
      notifyListeners();
    }
  }

  void copyData(tmpCategoryIndex, tmpTitle, tmpTime) {
    _title = tmpTitle;
    _categoryIndex = tmpCategoryIndex;
    _time = tmpTime;
    notifyListeners();
  }

  void reset() {
    _title = "";
    _categoryIndex = 0;
    _time = 0;
    _isGood = false;
    _timeCheck = true;
    _titleCheck = true;
    _isRecord = true;
    _clickCheck = false;
    _shortCut = false;
    notifyListeners();
  }
}

//changeNotifier for theme
class ThemeNotifier with ChangeNotifier {
  //Theme
  bool _isDark = false;
  bool get isDark => _isDark;
  int _themeColorsIndex = 0;
  List _myColors = [0];
  List get myColors => _myColors;
  List _themeColors() => baseColors[_myColors[_themeColorsIndex]];
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
  String previousDate = "2020年01月01日";
  String thisMonth = "01";
  int totalPassedDays = 1;
  int passedDays = 1;
  int keynum = 5;

  String tmpName = '';

  int _allTime = 0;
  int get allTime => _allTime;
  int _allGood = 0;
  int get allGood => _allGood;
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

  int index = 0;
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  List _categories = [];
  List get categories => _categories;

  List _latelyData = [];
  List get latelyData => _latelyData;

  List _todayDoneList = [];
  List get todayDoneList => _todayDoneList;

  List _shortCuts = [];
  List get shortCuts => _shortCuts;

  List _activities = [];
  List get activities => _activities;

  void nameChange(s) {
    tmpName = s;
    notifyListeners();
  }

  Future editProfile() async {
    userName = tmpName;
    notifyListeners();
    await Hive.box('userData').put('userName', userName);
  }

  Future editCategory(int index, int icon, String title) async {
    _categories[index + 4][0] = icon;
    _categories[index + 4][1] = title;
    notifyListeners();
    await Hive.box('userData').put('categories', _categories);
  }

  Future resetCategory(int index) async {
    if (index == 0) {
      _categories[4] = [
        58368,
        "指定1",
        [0, 0, 0]
      ];
    } else if (index == 1) {
      _categories[5] = [
        58369,
        "指定2",
        [0, 0, 0]
      ];
    } else if (index == 2) {
      _categories[6] = [
        58363,
        "指定3",
        [0, 0, 0]
      ];
    } else {
      _categories[7] = [
        58365,
        "指定4",
        [0, 0, 0]
      ];
    }
    notifyListeners();
    await Hive.box('userData').put('categories', _categories);
  }

  Future addShortCuts(List item) async {
    keynum += 1;
    _shortCuts.add(item);
    notifyListeners();
    await Hive.box('userData').put('shortCuts', _shortCuts);
    await Hive.box('userData').put('keynum', keynum);
  }

  void sort(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final model = _shortCuts.removeAt(oldIndex);
    _shortCuts.insert(newIndex, model);
    notifyListeners();
    await Hive.box('userData').put('shortCuts', _shortCuts);
  }

  void deleteShortCut(int index) async {
    _shortCuts.removeAt(index);
    notifyListeners();
    await Hive.box('userData').put('shortCuts', _shortCuts);
  }

  //activity関連
  Future addActivity(
    DateTime startTime,
    String title,
    int categoryIndex,
  ) async {
    Vib.decide();
    _activities.add([startTime, false, title, categoryIndex, 1, 1]);
    notifyListeners();
    await Hive.box('userData').put('activities', _activities);
  }

  Future finishActivity(int i) async {
    _activities.removeAt(i);
    notifyListeners();
    await Hive.box('userData').put('activities', _activities);
  }

  Future loopReflesh() async {
    for (int i = 0; i < _activities.length; i++) {
      if (_activities[i][1]) {
      } else {
        _activities[i][5] = _activities[i][4] +
            DateTime.now().difference(_activities[i][0]).inMinutes;
      }
    }
    notifyListeners();
    await Hive.box('userData').put('activities', _activities);
  }

  Future startTimer(int i) async {
    Vib.select();
    _activities[i][0] = DateTime.now();
    _activities[i][1] = false;
    notifyListeners();
    await Hive.box('userData').put('activities', _activities);
  }

  Future stopTimer(int i) async {
    Vib.select();
    _activities[i][1] = true;
    _activities[i][4] += DateTime.now().difference(activities[i][0]).inMinutes;
    _activities[i][5] = _activities[i][4];
    notifyListeners();
    await Hive.box('userData').put('activities', _activities);
  }
  //ListDataとカテゴリーのインデックスを渡す。
  //つまりカテゴリーのインデックスの変数を作る必要がある。
  //つまりカテゴリーの変数ではなくて
  //カテゴリーインデックスからcategoriesにアクセスをして
  //アイコンデータを取得して表示する必要がある。

  Future recordDone(
    List listData,
  ) async {
    Vib.decide();
    int time = listData[2];
    _allTime += time;
    _thisMonthTime += time;
    _todayTime += time;
    _categories[listData[0]][2][0] += time;
    if (listData[3]) {
      _allGood += time;
      _thisMonthGood += time;
      _todayGood += time;
      _categories[listData[0]][2][1] += time;
    }
    _allPer = (_allGood * 100 / _allTime).round();
    _thisMonthPer = (_thisMonthGood * 100 / _thisMonthTime).round();
    _todayPer = (_todayGood * 100 / _todayTime).round();
    _categories[listData[0]][2][2] =
        (_categories[listData[0]][2][1] * 100 / _categories[listData[0]][2][0])
            .round();
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
    await Hive.box('userData').put('userValue', [
      _allTime,
      _allGood,
      _allPer,
      _thisMonthTime,
      _thisMonthGood,
      _thisMonthPer,
      _todayTime,
      _todayGood,
      _todayPer,
    ]);
    await Hive.box('userData').put('categories', _categories);
    await Hive.box('userData').put('todayDoneList', _todayDoneList);
    await Hive.box('userData').put('latelyData', _latelyData);
  }

  Future deleteDone(List listData, int index) async {
    Vib.select();
    int time = listData[2];
    _allTime -= time;
    _thisMonthTime -= time;
    _todayTime -= time;
    _categories[listData[0]][2][0] -= time;
    if (listData[3]) {
      _allGood -= time;
      _thisMonthGood -= time;
      _todayGood -= time;
      _categories[listData[0]][2][1] -= time;
    }
    _allPer = (_allTime == 0) ? 0 : (_allGood * 100 / _allTime).round();
    _thisMonthPer = (_thisMonthTime == 0)
        ? 0
        : (_thisMonthGood * 100 / _thisMonthTime).round();
    _todayPer = (_todayTime == 0) ? 0 : (_todayGood * 100 / _todayTime).round();
    _categories[listData[0]][2][2] = (_categories[listData[0]][2][0] == 0)
        ? 0
        : (_categories[listData[0]][2][1] *
                100 /
                _categories[listData[0]][2][0])
            .round();
    _todayDoneList.removeAt(index);
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
    await Hive.box('userData').put('userValue', [
      _allTime,
      _allGood,
      _allPer,
      _thisMonthTime,
      _thisMonthGood,
      _thisMonthPer,
      _todayTime,
      _todayGood,
      _todayPer,
    ]);
    await Hive.box('userData').put('todayDoneList', _todayDoneList);
    await Hive.box('userData').put('latelyData', _latelyData);
    await Hive.box('userData').put('categories', _categories);
  }

  Future initialize() async {
    var box = Hive.box('userData');
    var userValue = await box.get('userValue');
    _allTime = userValue[0];
    _allGood = userValue[1];
    _allPer = userValue[2];
    _thisMonthTime = userValue[3];
    _thisMonthGood = userValue[4];
    _thisMonthPer = userValue[5];
    _todayTime = userValue[6];
    _todayGood = userValue[7];
    _todayPer = userValue[8];
    _latelyData = await box.get('latelyData');
    _todayDoneList = await box.get('todayDoneList');
    _categories = await box.get('categories');
    _shortCuts = await box.get('shortCuts');
    _activities = await box.get('activities');
    userName = await box.get('userName');
    previousDate = await box.get('previousDate');
    thisMonth = await box.get('thisMonth');
    totalPassedDays = await box.get('totalPassedDays');
    passedDays = await box.get('passedDays');
    keynum = await box.get('keynum');
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
