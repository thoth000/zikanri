import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Size displaySize;
FlutterLocalNotificationsPlugin flutterNotification;

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

  static void add() {
    Vibration.vibrate(duration: 150);
  }
}

const List<int> iconList = [
  57746,
  57680,
  58726,
  59601,
  58128,
  58699,
  58378,
  58168,
  59677,
  58937,
  58917,
  58143,
  59497,
  60231,
  60227,
  60236,
  59471,
  59540,
  58373,
  58693,
  57388,
  60222,
  60224,
  59517,
  59596,
  58386,
  58899,
];

const List<String> iconHintList = [
  "時間",
  "勉強",
  "運動",
  "家事",
  "音楽",
  "読書",
  "イラスト",
  "ゲーム",
  "ペット",
  "メディア",
  "SNS",
  "パソコン",
  "DIY",
  "料理",
  "筋トレ",
  "リラックス",
  "博物館",
  "インターネット",
  "音",
  "園芸",
  "映画",
  "バカンス",
  "ギャンブル",
  "恋愛",
  "買い物",
  "カメラ",
  "ドライブ",
];

List<int> achiveM = [500, 1000, 3000, 5000, 10000];
List<int> achiveD = [1, 3, 7, 30, 100];

//BaseColor
//単色をベースにしていく
//今なんこ,14
List<List<Color>> baseColors = [
  [Color(0XFF39BAE8), Color(0XFF0000A1)], //青
  [Color(0XFFef473a), Color(0XFFcb2d3e)], //赤
  [Color(0XFF08ffc8), Color(0XFF204969)], //緑
  [Colors.white, Colors.black], //モノクロ
  [Color(0XFFffcccc), Color(0XFFcaabd8)], //ピンク
  [Color(0XFFffe259), Color(0XFFffa751)], //マンゴー
  [Color(0XFFFFFDE4), Color(0XFF005AA7)], //白青
  [Color(0XFFfffbd5), Color(0XFFb20a2c)], //白赤
  [Color(0XFFe4e4d9), Color(0XFF215f00)], //白緑
  [Color(0XFF00ecbc), Color(0XFF007adf)], //風
  [Color(0XFF21D4FD), Color(0XFFB721FF)], //紫グラ
  [Color(0XFFDBE6F6), Color(0XFFC5796D)], //ジュピター
  [Color(0XFF81FBB8), Color(0XFF28C76F)], //鮮緑
  [Color(0XFF4776E6), Color(0XFF8E54E9)], //紫
];

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
  bool check() => _isRecord ? (_titleCheck || _timeCheck) : _titleCheck;

  void changeTitle(String s) {
    _title = s;
    if (_title == "") {
      _titleCheck = true;
    } else {
      _titleCheck = false;
    }
    notifyListeners();
  }

  void changeTime(String s) {
    if (s == "") {
      _timeCheck = true;
    } else {
      int _minute = int.parse(s);
      if (_minute > 1440 || _minute == 0) {
        _timeCheck = true;
      } else {
        _timeCheck = false;
        _time = _minute;
      }
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
    notifyListeners();
  }
}

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

//changeNotifier for userData
class UserDataNotifier with ChangeNotifier {
  String userName = "ゲスト";
  String previousDate = "2020年01月01日";
  String thisMonth = "01";
  int totalPassedDays = 1;

  List<bool> checkM = [false, false, false, false, false];
  List<bool> checkD = [true, false, false, false, false];

  List<bool> _myColors = [
    true,
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> get myColors => _myColors;

  bool readGuide = false;

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

  Future checkGuide() async{
    readGuide = true;
    await Hive.box('userData').put('readGuide', readGuide);
    notifyListeners();
  }
  //ver1.0.0用
  void addGuide() {
    readGuide = true;
    notifyListeners();
  }

  Future checkDay() async {
    for (int i = 0; i < achiveD.length; i++) {
      if (!checkD[i]) {
        if (totalPassedDays >= achiveD[i]) {
          checkD[i] = true;
          myColors[2 * i + 2] = true;
        }
      }
    }
    notifyListeners();
    await Hive.box('userData').put('myColors', _myColors);
    await Hive.box('userData').put('checkD', checkD);
  }

  Future addTheme(int i) async {
    _myColors[i] = true;
    await Hive.box('userData').put('myColors', _myColors);
    notifyListeners();
  }

  void nameChange(s) {
    tmpName = s;
    notifyListeners();
  }

  Future editProfile() async {
    userName = tmpName;
    notifyListeners();
    await Hive.box('userData').put('userName', userName);
  }

  Future dicideCategory() async {
    notifyListeners();
    await Hive.box('userData').put('categories', _categories);
  }

  void editCategoryIcon(int index, int icon) {
    _categories[index][0] = icon;
    notifyListeners();
  }

  void editCategoryTitle(int index, String s) {
    _categories[index][1] = s;
  }

  Future resetCategory(int index) async {
    _categories[index] = [
      57746,
      "",
      [0, 0, 0]
    ];
    notifyListeners();
    await Hive.box('userData').put('categories', _categories);
  }

  Future addShortCuts(List item) async {
    Vib.add();
    keynum += 1;
    _shortCuts.add(item);
    notifyListeners();
    await Hive.box('userData').put('shortCuts', _shortCuts);
    await Hive.box('userData').put('keynum', keynum);
  }

  Future sort(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final model = _shortCuts.removeAt(oldIndex);
    _shortCuts.insert(newIndex, model);
    notifyListeners();
    await Hive.box('userData').put('shortCuts', _shortCuts);
  }

  Future deleteShortCut(int index) async {
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
    for (int i = 0; i < achiveM.length; i++) {
      if (!checkM[i]) {
        if (allTime >= achiveM[i]) {
          checkM[i] = true;
          _myColors[2 * i + 3] = true;
        } else {
          break;
        }
      }
    }
    notifyListeners();
    //保存メソッド
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
    await Hive.box('userData').put('checkM', checkM);
    await Hive.box('userData').put('myColors', _myColors);
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
    //保存メソッド
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
    readGuide = await box.get('readGuide');
    _myColors = await box.get('myColors');
    checkM = await box.get('checkM');
    checkD = await box.get('checkD');
    previousDate = await box.get('previousDate');
    thisMonth = await box.get('thisMonth');
    totalPassedDays = await box.get('totalPassedDays');
    passedDays = await box.get('passedDays');
    keynum = await box.get('keynum');
  }
}
