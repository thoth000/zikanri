//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/service/firebase_user_service.dart';

class UserDataNotifier with ChangeNotifier {
  //ローカルDB
  final userDataBox = Hive.box('userData');
  //初期値
  String userID = ''; //バックアップ・ランキングに使用
  String backUpCode = ''; //上記と等しい
  String userName = 'ゲスト'; //SNSシェア時に使用
  int myIcon = Icons.access_time.codePoint; //ユーザ情報に出る

  String previousDate = '2020年01月01日'; //日付確認
  String thisMonth = '01'; //今月判定
  int totalPassedDays = 1; //ログイン日数（主に実績用）

  //お気に入りユーザーIDリスト
  List<String> favoriteIDs = [];

  DateTime backUpCanDate = DateTime(2020, 1, 1); //バックアップ可能日付
  //実績
  List<bool> checkM = [false, false, false, false, false];
  List<bool> checkD = [true, false, false, false, false];
  //実績によるテーマ開放
  List<bool> myColors = [
    true,
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  //アプリ初回起動のガイド示唆
  bool readGuide = false;

  //ショートカット区別のキー
  int keynum = 5;
  //データ一覧
  int allTime = 0;
  int allGood = 0;
  int allPer = 0;
  int thisMonthTime = 0;
  int thisMonthGood = 0;
  int thisMonthPer = 0;
  int todayTime = 0;
  int todayGood = 0;
  int todayPer = 0;

  //カテゴリー [[iconNumber,title,data[total,good,percent],...]
  List categories = [];
  //categoryの表示・非表示判定
  List<bool> categoryView = [];
  //日々の記録用 [[date,totaltime,goodtime,percent,donelist],...]
  List latelyData = [];
  //今日の記録配列 [[icon,title,time,isGood],...]
  List todayDoneList = [];
  //shortCut用配列 [icon,title,time,isGood,keynum,isRecord]
  List shortCuts = [];
  //進行中の活動用配列（タイマー配列）[[datetime, bool, title, categoryIndex, tmp, tmp],...]
  List activities = [];

  //配列（リスト）はHive保存のために構造体（Class）に代替しないこととする。
  //プログラムは複雑になるが処理は他の保存・読み込み手段に比べて速いためである。

  //ガイドを一度だけ読むための処理
  Future<void> checkGuide() async {
    readGuide = true;
    await Hive.box('userData').put('readGuide', readGuide);
    notifyListeners();
  }

  Future<void> addFavoriteID(String id) async {
    favoriteIDs.add(id);
    notifyListeners();
    await userDataBox.put('favoriteIDs', favoriteIDs);
  }

  Future<void> removeFavoriteID(String id) async {
    favoriteIDs.remove(id);
    notifyListeners();
    await userDataBox.put('favoriteIDs', favoriteIDs);
  }

  Future<void> editUserName(String name) async {
    userName = name;
    notifyListeners();
    await userDataBox.put('userName', userName);
    //ネットワーク処理
    await setUserData();
  }

  Future<void> editMyIcon(int iconNumber) async {
    myIcon = iconNumber;
    notifyListeners();
    await userDataBox.put('myIcon', myIcon);
    //ネットワーク処理
    await setUserData();
  }

  //カテゴリーのアイコンを変更
  void editCategoryIcon(int index, int icon) {
    categories[index][0] = icon;
    notifyListeners();
    userDataBox.put('categories', categories);
  }

  //カテゴリーの名前を変更
  void editCategoryTitle(int index, String s) {
    categories[index][1] = s;
    notifyListeners();
    userDataBox.put('categories', categories);
  }

  //カテゴリーを表示・非表示を切り替える
  void switchCategoryView(int index) {
    categoryView[index] = !categoryView[index];
    notifyListeners();
    userDataBox.put('categoryView', categoryView);
  }

  //カテゴリーをリセットする
  Future<void> resetCategory(int index) async {
    categories[index] = [
      Icons.access_time.codePoint,
      '',
      [0, 0, 0]
    ];
    categoryView[index] = false;
    notifyListeners();
    await userDataBox.put('categories', categories);
    await userDataBox.put('categoryView', categoryView);
  }

  //ショートカットを追加する
  Future<void> addShortCuts(List item) async {
    keynum += 1;
    shortCuts.add(item);
    notifyListeners();
    await userDataBox.put('shortCuts', shortCuts);
    await userDataBox.put('keynum', keynum);
  }

  //長押し用の並び替え処理
  Future<void> sort(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final model = shortCuts.removeAt(oldIndex);
    shortCuts.insert(newIndex, model);
    notifyListeners();
    await userDataBox.put('shortCuts', shortCuts);
  }

  //ショートカットを削除する
  Future<void> deleteShortCut(int index) async {
    shortCuts.removeAt(index);
    notifyListeners();
    await userDataBox.put('shortCuts', shortCuts);
  }

  //活動を始める
  Future<void> addActivity(
    DateTime startTime,
    String title,
    int categoryIndex,
  ) async {
    activities.add([startTime, false, title, categoryIndex, 1, 1]);
    notifyListeners();
    await userDataBox.put('activities', activities);
  }

  //活動を終了する
  Future<void> finishActivity(int i) async {
    activities.removeAt(i);
    notifyListeners();
    await userDataBox.put('activities', activities);
  }

  //活動の時間を測定・計算する
  Future<void> loopReflesh() async {
    for (int i = 0; i < activities.length; i++) {
      if (activities[i][1]) {
      } else {
        activities[i][5] = activities[i][4] +
            DateTime.now().difference(activities[i][0]).inMinutes;
      }
    }
    notifyListeners();
    await userDataBox.put('activities', activities);
  }

  //活動を再開
  Future<void> startTimer(int i) async {
    activities[i][0] = DateTime.now();
    activities[i][1] = false;
    notifyListeners();
    await userDataBox.put('activities', activities);
  }

  //活動をストップ
  Future<void> stopTimer(int i) async {
    activities[i][1] = true;
    activities[i][4] += DateTime.now().difference(activities[i][0]).inMinutes;
    activities[i][5] = activities[i][4];
    notifyListeners();
    await userDataBox.put('activities', activities);
  }

  //既にある記録に時間を追加する
  Future<void> addTime(int index, int time) async {
    bool isGood = todayDoneList[index][3];
    allTime += time;
    thisMonthTime += time;
    todayTime += time;
    todayDoneList[index][2] += time;
    categories[todayDoneList[index][0]][2][0] += time;
    if (isGood) {
      allGood += time;
      thisMonthGood += time;
      todayGood += time;
      categories[todayDoneList[index][0]][2][1] += time;
    }
    allPer = (allGood * 100 / allTime).round();
    thisMonthPer = (thisMonthGood * 100 / thisMonthTime).round();
    todayPer = (todayGood * 100 / todayTime).round();
    categories[todayDoneList[index][0]][2][2] =
        (categories[todayDoneList[index][0]][2][1] *
                100 /
                categories[todayDoneList[index][0]][2][0])
            .round();
    latelyData[latelyData.length - 1][1] = todayTime;
    latelyData[latelyData.length - 1][2] = todayGood;
    latelyData[latelyData.length - 1][3] = todayPer;
    latelyData[latelyData.length - 1][4] = todayDoneList;
    for (int i = 0; i < achiveM.length; i++) {
      if (!checkM[i]) {
        if (allTime >= achiveM[i]) {
          checkM[i] = true;
          myColors[2 * i + 3] = true;
        } else {
          break;
        }
      }
    }
    notifyListeners();
    //保存メソッド
    await userDataBox.put('userValue', [
      allTime,
      allGood,
      allPer,
      thisMonthTime,
      thisMonthGood,
      thisMonthPer,
      todayTime,
      todayGood,
      todayPer,
    ]);
    await userDataBox.put('categories', categories);
    await userDataBox.put('todayDoneList', todayDoneList);
    await userDataBox.put('latelyData', latelyData);
    await userDataBox.put('checkM', checkM);
    await userDataBox.put('myColors', myColors);
    //ネットワーク処理
    await setUserData();
  }

  //活動を記録する
  Future<void> recordDone(List listData) async {
    int time = listData[2];
    allTime += time;
    thisMonthTime += time;
    todayTime += time;
    categories[listData[0]][2][0] += time;
    if (listData[3]) {
      allGood += time;
      thisMonthGood += time;
      todayGood += time;
      categories[listData[0]][2][1] += time;
    }
    allPer = (allGood * 100 / allTime).round();
    thisMonthPer = (thisMonthGood * 100 / thisMonthTime).round();
    todayPer = (todayGood * 100 / todayTime).round();
    categories[listData[0]][2][2] =
        (categories[listData[0]][2][1] * 100 / categories[listData[0]][2][0])
            .round();
    todayDoneList.add(listData);
    latelyData.removeAt(latelyData.length - 1);
    latelyData.add(
      [
        previousDate,
        todayTime,
        todayGood,
        todayPer,
        todayDoneList,
      ],
    );
    for (int i = 0; i < achiveM.length; i++) {
      if (!checkM[i]) {
        if (allTime >= achiveM[i]) {
          checkM[i] = true;
          myColors[2 * i + 3] = true;
        } else {
          break;
        }
      }
    }
    notifyListeners();
    //ローカル保存メソッド
    await Hive.box('userData').put('userValue', [
      allTime,
      allGood,
      allPer,
      thisMonthTime,
      thisMonthGood,
      thisMonthPer,
      todayTime,
      todayGood,
      todayPer,
    ]);
    await userDataBox.put('categories', categories);
    await userDataBox.put('todayDoneList', todayDoneList);
    await userDataBox.put('latelyData', latelyData);
    await userDataBox.put('checkM', checkM);
    await userDataBox.put('myColors', myColors);
    //ネットワーク処理
    await setUserData();
  }

  //記録削除用メソッド
  Future<void> deleteDone(List listData, int index) async {
    int time = listData[2];
    allTime -= time;
    thisMonthTime -= time;
    todayTime -= time;
    categories[listData[0]][2][0] -= time;
    if (listData[3]) {
      allGood -= time;
      thisMonthGood -= time;
      todayGood -= time;
      categories[listData[0]][2][1] -= time;
    }
    allPer = (allTime == 0) ? 0 : (allGood * 100 / allTime).round();
    thisMonthPer = (thisMonthTime == 0)
        ? 0
        : (thisMonthGood * 100 / thisMonthTime).round();
    todayPer = (todayTime == 0) ? 0 : (todayGood * 100 / todayTime).round();
    categories[listData[0]][2][2] = (categories[listData[0]][2][0] == 0)
        ? 0
        : (categories[listData[0]][2][1] * 100 / categories[listData[0]][2][0])
            .round();
    todayDoneList.removeAt(index);
    latelyData.removeAt(latelyData.length - 1);
    latelyData.add(
      [
        previousDate,
        todayTime,
        todayGood,
        todayPer,
        todayDoneList,
      ],
    );
    for (int i = 0; i < achiveM.length; i++) {
      if (allTime >= achiveM[i]) {
        checkM[i] = true;
        myColors[2 * i + 3] = true;
      } else {
        checkM[i] = false;
        myColors[2 * i + 3] = false;
      }
    }
    notifyListeners();
    //保存メソッド
    await Hive.box('userData').put('userValue', [
      allTime,
      allGood,
      allPer,
      thisMonthTime,
      thisMonthGood,
      thisMonthPer,
      todayTime,
      todayGood,
      todayPer,
    ]);
    await Hive.box('userData').put('todayDoneList', todayDoneList);
    await Hive.box('userData').put('latelyData', latelyData);
    await Hive.box('userData').put('categories', categories);
    //ネットワーク処理
    await setUserData();
  }

  //FireStoreへのデータ保存メソッド
  Future<void> setUserData() async {
    if (userID == '未登録') {
      return;
    }
    final DateTime now = DateTime.now();
    final Timestamp today =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    Map<String, dynamic> uploadData = {
      'userID': userID,
      'backUpCode': backUpCode,
      'name': userName,
      'myIcon': myIcon,
      'myColors': myColors,
      'todayTime': todayTime,
      'todayGood': todayGood,
      'totalMinute': allTime,
      'openDate': today,
      'totalOpen': totalPassedDays,
    };
    try {
      await FirebaseUserService().setData(userID, uploadData);
    } catch (error) {
      print(error);
    }
  }

  //アプリ起動時のデータ読み込み
  Future<void> initialize() async {
    var box = Hive.box('userData');
    var userValue = await box.get('userValue');
    allTime = userValue[0];
    allGood = userValue[1];
    allPer = userValue[2];
    thisMonthTime = userValue[3];
    thisMonthGood = userValue[4];
    thisMonthPer = userValue[5];
    todayTime = userValue[6];
    todayGood = userValue[7];
    todayPer = userValue[8];
    latelyData = await box.get('latelyData');
    todayDoneList = await box.get('todayDoneList');
    categories = await box.get('categories');
    categoryView = await box.get('categoryView');
    shortCuts = await box.get('shortCuts');
    activities = await box.get('activities');
    userID = await box.get('userID');
    backUpCode = await box.get('backUpCode');
    myIcon = await box.get('myIcon');
    favoriteIDs = await box.get('favoriteIDs');
    backUpCanDate = await box.get('backUpCanDate');
    userName = await box.get('userName');
    backUpCode = await box.get('backUpCode');
    readGuide = await box.get('readGuide');
    myColors = await box.get('myColors');
    checkM = await box.get('checkM');
    checkD = await box.get('checkD');
    previousDate = await box.get('previousDate');
    thisMonth = await box.get('thisMonth');
    totalPassedDays = await box.get('totalPassedDays');
    keynum = await box.get('keynum');
  }

  //アプリ初回起動時のデータ処理メソッド
  Future<void> firstOpneDataSet(String version) async {
    final String firstdate = DateFormat('yyyy年MM月dd日').format(DateTime.now());
    final String firstMonth = DateFormat('MM').format(DateTime.now());
    await userDataBox.put('welcome', 'Yey!');
    await userDataBox.put('version', version);
    await userDataBox.put('readGuide', false);
    await userDataBox.put('myColors', [
      true,
      true,
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ]);
    await userDataBox.put('checkM', [false, false, false, false, false]);
    await userDataBox.put('checkD', [true, false, false, false, false]);
    /*
    userValue=[
        all       Time,Good,Per,
        thisMonth Time,Good,Per,
        today     Time,Good,Per,
    ]
    */
    await userDataBox.put('userValue', [0, 0, 0, 0, 0, 0, 0, 0, 0]);
    await userDataBox.put('latelyData', [
      [firstdate, 0, 0, 0, []],
    ]);
    await userDataBox.put('todayDoneList', []);
    await userDataBox.put(
      'shortCuts',
      [],
    );
    await userDataBox.put(
      'categories',
      [
        [
          newIconList[0],
          '指定なし',
          [0, 0, 0]
        ],
        [
          newIconList[0],
          '',
          [0, 0, 0]
        ],
        [
          newIconList[0],
          '',
          [0, 0, 0]
        ],
        [
          newIconList[0],
          '',
          [0, 0, 0]
        ],
        [
          newIconList[0],
          '',
          [0, 0, 0]
        ],
        [
          newIconList[0],
          '',
          [0, 0, 0]
        ],
        [
          newIconList[0],
          '',
          [0, 0, 0]
        ],
        [
          newIconList[0],
          '',
          [0, 0, 0]
        ],
      ],
    );
    await userDataBox.put('categoryView',
        [true, false, false, false, false, false, false, false]);
    await userDataBox.put('keynum', 5);
    await userDataBox.put('activities', []);
    await userDataBox.put('myIcon', Icons.access_time.codePoint);
    await userDataBox.put('backUpCanDate', DateTime.now());
    await userDataBox.put('userName', 'Zikanriゲスト');
    await userDataBox.put('previousDate', firstdate);
    await userDataBox.put('thisMonth', firstMonth);
    await userDataBox.put('passedDays', 1);
    await userDataBox.put('totalPassedDays', 1);
    await initialize();
  }

  //記録時間と実績の照らし合わせ
  Future<void> updateCheckM(int time) async {
    for (int i = 0; i < achiveM.length; i++) {
      if (time >= achiveM[i]) {
        checkM[i] = true;
        myColors[2 * i + 3] = true;
      } else {
        break;
      }
    }
    notifyListeners();
    await userDataBox.put('checkM', checkM);
    await userDataBox.put('myColors', myColors);
  }

  //ログイン日数と実績の照らし合わせ
  Future<void> updateCheckD(int day) async {
    for (int i = 0; i < achiveD.length; i++) {
      if (day >= achiveD[i]) {
        checkD[i] = true;
        myColors[2 * i + 2] = true;
      } else {
        break;
      }
    }
    await userDataBox.put('checkD', checkD);
    await userDataBox.put('myColors', myColors);
  }

  Future<void> changeBackUpCanDate() async {
    backUpCanDate = DateTime.now().add(Duration(days: 30));
    notifyListeners();
    await userDataBox.put('backUpCanDate', backUpCanDate);
  }

  //データ引き継ぎ用メソッド
  Future<void> takeOver(Map<String, dynamic> data) async {
    backUpCanDate = DateTime.now().add(Duration(days: 30));
    checkM = [false, false, false, false, false];
    checkD = [true, false, false, false, false];
    myColors = [
      true,
      true,
      true,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    await updateCheckM(data['allTime']);
    await updateCheckD(data['passDay']);
    //元々Service側で行っていた処理
    List<dynamic> _categories = [];
    for (int i = 0; i < 8; i++) {
      final json = data['category$i'];
      final List<int> listData = json['dataList'].cast<int>();
      final List category = [json['iconNumber'], json['title'], listData];
      _categories.add(category);
    }
    await userDataBox.put('userValue', [
      data['allTime'],
      data['allGood'],
      data['allPer'],
      0,
      0,
      0,
      0,
      0,
      0,
    ]);
    await userDataBox.put('userName', data['name']);
    await userDataBox.put('totalPassedDays', data['passDay']);
    await userDataBox.put('categories', _categories);
    await userDataBox.put('userID', data['userID']);
    await userDataBox.put('backUpCode', data['backUpCode']);
    final List<String> ids = [data['userID']];
    await userDataBox.put('backUpCanDate', backUpCanDate);
    await userDataBox.put('favoriteIDs', ids);
    await userDataBox.put('latelyData', [
      [DateFormat('yyyy年MM月dd日').format(DateTime.now()), 0, 0, 0, []],
    ]);
    await userDataBox.put('todayDoneList', []);
    await userDataBox.put('shortCuts', []);
    await userDataBox.put('keynum', 5);
    await userDataBox.put('activities', []);
    await initialize();
    //バックアップデータをランキングの方のデータに読み込む
    await setUserData();
  }

  //アプリ起動時の初期メソッド
  Future<void> splashFunc() async {
    final date = DateFormat('yyyy年MM月dd日').format(DateTime.now());
    final month = DateFormat('MM').format(DateTime.now());
    if (date != userDataBox.get('previousDate')) {
      await userDataBox.put('previousDate', date);
      await userDataBox.put('todayDoneList', []);
      var latelyData = userDataBox.get('latelyData');
      if (latelyData.length >= 8) {
        latelyData.removeAt(0);
      }
      latelyData.add([date, 0, 0, 0, []]);
      await userDataBox.put('latelyData', latelyData);
      var userValue = userDataBox.get('userValue');
      if (month != userDataBox.get('thisMonth')) {
        userValue[3] = 0;
        userValue[4] = 0;
        userValue[5] = 0;
        await userDataBox.put('thisMonth', month);
        await userDataBox.put('passedDays', 1);
      } else {
        await userDataBox.put('passedDays', userDataBox.get('passedDays') + 1);
      }
      userValue[6] = 0;
      userValue[7] = 0;
      userValue[8] = 0;
      await userDataBox.put('userValue', userValue);
      await userDataBox.put(
          'totalPassedDays', userDataBox.get('totalPassedDays') + 1);
    }
  }

  //旧アプリのアイコンを変更するメソッド（いづれ必要ない）
  Future<void> switchIconNum() async {
    for (int i = 0; i < 8; i++) {
      categories[i][0] = newIconList[iconList.indexOf(categories[i][0])];
    }
    await userDataBox.put('categories', categories);
  }
}
