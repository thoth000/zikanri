import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zikanri/data.dart';

//changeNotifier for userData
class UserDataNotifier with ChangeNotifier {
  String userName = "ゲスト";
  String previousDate = "2020年01月01日";
  String thisMonth = "01";
  int totalPassedDays = 1;
  //実績
  List<bool> checkM = [false, false, false, false, false];
  List<bool> checkD = [true, false, false, false, false];
  //実績によるテーマ開放
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
  //アプリ初回起動のガイド示唆
  bool readGuide = false;
  //ログイン日数
  int passedDays = 1;
  //ショートカット区別のキー
  int keynum = 5;
  //データ一覧
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

  //最近の記録用の日数判定
  int index = 0;
  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  //category[]
  List _categories = [];
  List get categories => _categories;
  //categoryの表示・非表示判定
  List<bool> categoryView = [];
  //日々の記録用配列[todayDoneList,...]
  List _latelyData = [];
  List get latelyData => _latelyData;
  //今日の記録配列
  List _todayDoneList = [];
  List get todayDoneList => _todayDoneList;
  //shortCut用配列
  List _shortCuts = [];
  List get shortCuts => _shortCuts;
  //進行中の活動用配列（タイマー配列）
  List _activities = [];
  List get activities => _activities;

  //リストはHive保存のため構造体（Class）に代替しない。プログラムは複雑になるが処理は他の保存・読み込み手段に比べて速い。

  Future checkGuide() async {
    readGuide = true;
    await Hive.box('userData').put('readGuide', readGuide);
    notifyListeners();
  }

  //ver1.0.0用,変数追加関数
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

  Future editProfile(String name) async {
    userName = name;
    notifyListeners();
    await Hive.box('userData').put('userName', userName);
  }

  Future dicideCategory() async {
    notifyListeners();
    await Hive.box('userData').put('categories', _categories);
    await Hive.box('userData').put('categoryView', categoryView);
  }

  void editCategoryIcon(int index, int icon) {
    _categories[index][0] = icon;
    notifyListeners();
    Hive.box('userData').put('categories', _categories);
  }

  void editCategoryTitle(int index, String s) {
    _categories[index][1] = s;
    notifyListeners();
    Hive.box('userData').put('categories', _categories);
  }

  void switchCategoryView(int index) {
    categoryView[index] = !categoryView[index];
    notifyListeners();
    Hive.box('userData').put('categoryView', categoryView);
  }

  Future resetCategory(int index) async {
    _categories[index] = [
      57746,
      "",
      [0, 0, 0]
    ];
    categoryView[index] = false;
    notifyListeners();
    await Hive.box('userData').put('categories', _categories);
    await Hive.box('userData').put('categoryView', categoryView);
  }

  Future addShortCuts(List item) async {
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

  /*ListDataとカテゴリーのインデックスを渡す。
  つまりカテゴリーのインデックスの変数を作る必要がある。
  つまりカテゴリーの変数ではなくて
  カテゴリーインデックスからcategoriesにアクセスをして
  アイコンデータを取得して表示する必要がある。*/
  Future<void> addTime(
    int index,
    int time,
  ) async {
    //0:category 1:title 2:time 3:isGood
    bool isGood = _todayDoneList[index][3];
    _allTime += time;
    _thisMonthTime += time;
    _todayTime += time;
    _todayDoneList[index][2] += time;
    _categories[_todayDoneList[index][0]][2][0] += time;
    if (isGood) {
      _allGood += time;
      _thisMonthGood += time;
      _todayGood += time;
      _categories[_todayDoneList[index][0]][2][1] += time;
    }
    _allPer = (_allGood * 100 / _allTime).round();
    _thisMonthPer = (_thisMonthGood * 100 / _thisMonthTime).round();
    _todayPer = (_todayGood * 100 / _todayTime).round();
    _categories[_todayDoneList[index][0]][2][2] =
        (_categories[_todayDoneList[index][0]][2][1] *
                100 /
                _categories[_todayDoneList[index][0]][2][0])
            .round();
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

  Future<void> recordDone(
    List listData,
  ) async {
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
        if (_allTime >= achiveM[i]) {
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
    categoryView = await box.get('categoryView');
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