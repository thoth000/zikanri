import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import '../setting/tutorial.dart';
import '../splash.dart';
import '../data.dart';

class RButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    return Container(
      height: displaySize.width / 5,
      width: displaySize.width / 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: theme.themeColors),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            color: Colors.black38,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              Icons.access_time,
              color: Colors.white,
              size: displaySize.width / 7,
            ),
          ),
          SizedBox(
            height: displaySize.width / 5,
            width: displaySize.width / 5,
            child: FlatButton(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              child: SizedBox(),
              onPressed: () {
                var date = DateFormat("yyyy年MM月dd日").format(DateTime.now());
                if (date != Hive.box('userData').get('previousDate')) {
                  showDialog(
                    barrierDismissible: false,
                    context: (context),
                    builder: (context) => DateChangeDialog(),
                  );
                } else {
                  Vib.select();
                  record.reset();
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => RecordBottomSheet(),
                  );
                }
              },
              onLongPress: () {
                var date = DateFormat("yyyy年MM月dd日").format(DateTime.now());
                if (date != Hive.box('userData').get('previousDate')) {
                  showDialog(
                    barrierDismissible: false,
                    context: (context),
                    builder: (context) => DateChangeDialog(),
                  );
                } else {
                  Vib.decide();
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => ShortCutSheet(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DateChangeDialog extends StatefulWidget {
  @override
  _DateChangeDialogState createState() => _DateChangeDialogState();
}

class _DateChangeDialogState extends State<DateChangeDialog> {
  void initState() {
    super.initState();
    pagechange();
  }

  Future pagechange() async {
    Future.delayed(
      Duration(milliseconds: 1500),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SplashPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('日付が変わっています'),
      content: Text('自動的にタイトル画面に戻ります'),
    );
  }
}

class RecordBottomSheet extends StatefulWidget {
  RecordBottomSheet();
  @override
  _RecordBottomSheetState createState() => _RecordBottomSheetState();
}

class _RecordBottomSheetState extends State<RecordBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    final _decorationStyle = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    );
    final _headlineStyle = TextStyle(
      fontSize: FontSize.small,
      fontWeight: FontWeight.w700,
    );
    Future<void> notification(String s) async {
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        "Channel ID",
        "Channel title",
        "channel body",
        priority: Priority.Max,
        importance: Importance.Max,
        ticker: 'test',
      );
      IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

      NotificationDetails notificationDetails = NotificationDetails(
          androidNotificationDetails, iosNotificationDetails);
      await flutterNotification.show(
          0,
          "活動",
          (userData.activities.length + 1).toString() + "件目: " + s,
          notificationDetails);
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.7,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //ボトムシートの上のグレーのとこ
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.all(12.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey,
                ),
              ),
              Text(
                '記録の追加',
                style: TextStyle(
                    fontSize: FontSize.large, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: displaySize.width / 7.5,
                      width: displaySize.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (record.isRecord)
                              ? (theme.isDark)
                                  ? theme.themeColors[0]
                                  : theme.themeColors[1]
                              : Colors.grey,
                          width: (record.isRecord) ? 3 : 1,
                        ),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('記録する'),
                        ),
                        onPressed: record.recordMode,
                      ),
                    ),
                    Container(
                      height: displaySize.width / 7.5,
                      width: displaySize.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (!record.isRecord)
                              ? (theme.isDark)
                                  ? theme.themeColors[0]
                                  : theme.themeColors[1]
                              : Colors.grey,
                          width: (!record.isRecord) ? 3 : 1,
                        ),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('開始する'),
                        ),
                        onPressed: record.startMode,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 1,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        (record.isRecord)
                            ? (userData.tutorial[1])
                                ? SizedBox()
                                : RecordTutorial()
                            : (userData.tutorial[2])
                                ? SizedBox()
                                : StartTutorial(),
                        Text(
                          'タイトル',
                          style: _headlineStyle,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          decoration: _decorationStyle,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: (theme.isDark)
                                ? theme.themeColors[0]
                                : theme.themeColors[1],
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                              fontSize: FontSize.small,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              //ヒント文:記録モード:開始モード
                              hintText: record.isRecord ? "なにをしたの？" : "なにをするの？",
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            textInputAction: TextInputAction.go,
                            onChanged: (s) => record.changeTitle(s),
                          ),
                        ),
                      ],
                    ),
                    (record.isRecord)
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    '時間(分)',
                                    style: _headlineStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: displaySize.width / 7,
                                    width: displaySize.width / 2.5,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: _decorationStyle,
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      cursorColor: (theme.isDark)
                                          ? theme.themeColors[0]
                                          : theme.themeColors[1],
                                      style: TextStyle(
                                        fontSize: FontSize.small,
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly,
                                      ],
                                      textInputAction: TextInputAction.go,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "何分？",
                                      ),
                                      onChanged: (s) => record.changeTime(s),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    '時間の価値',
                                    style: _headlineStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: displaySize.width / 2.5,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              blocButton(theme, record, false),
                                              SizedBox(
                                                width: displaySize.width / 50,
                                              ),
                                              blocButton(theme, record, true),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: displaySize.width / 6.5,
                          width: displaySize.width / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            border: Border.all(
                              color: (theme.isDark)
                                  ? record.check()
                                      ? theme.themeColors[0]
                                          .withOpacity(0.5) //opacityを無効時につける
                                      : theme.themeColors[0]
                                  : record.check()
                                      ? theme.themeColors[1]
                                          .withOpacity(0.5) //opacityを無効時につける
                                      : theme.themeColors[1],
                              width: 3,
                            ),
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500),
                            ),
                            onLongPress: record.check()
                                ? null
                                : () async {
                                    if (record.isRecord) {
                                      userData.addShortCuts(
                                        [
                                          record.categoryIndex,
                                          record.title,
                                          record.time,
                                          record.isGood,
                                          userData.keynum,
                                          true,
                                        ],
                                      );
                                      userData.recordDone(
                                        [
                                          record.categoryIndex,
                                          record.title,
                                          record.time,
                                          record.isGood,
                                        ],
                                      );
                                      Navigator.pop(context);
                                      record.reset();
                                    } else {
                                      notification(record.title);
                                      userData.addShortCuts(
                                        [
                                          record.categoryIndex,
                                          record.title,
                                          0,
                                          false,
                                          userData.keynum,
                                          false,
                                        ],
                                      );
                                      userData.addActivity(
                                        DateTime.now(),
                                        record.title,
                                        record.categoryIndex,
                                      );
                                      Navigator.pop(context);
                                      record.reset();
                                    }
                                  },
                            onPressed: record.check()
                                ? null
                                : () async {
                                    if (record.isRecord) {
                                      //記録モード
                                      userData.recordDone(
                                        [
                                          record.categoryIndex,
                                          record.title,
                                          record.time,
                                          record.isGood,
                                        ],
                                      );
                                      record.reset();
                                      Navigator.pop(context);
                                    } else {
                                      notification(record.title);
                                      //開始モード
                                      userData.addActivity(DateTime.now(),
                                          record.title, record.categoryIndex);
                                      Navigator.pop(context);
                                      record.reset();
                                    }
                                  },
                            child: Text(
                              (record.isRecord) ? '記録する' : '開始する',
                              style: TextStyle(
                                fontSize: FontSize.midium,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (record.titleCheck && record.clickCheck)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'タイトルを決めてください',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: FontSize.xsmall,
                              ),
                            ),
                          ),
                        if (record.timeCheck && record.clickCheck)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '時間の設定は1日の範囲までです',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: FontSize.xsmall,
                                  ),
                                ),
                                Text(
                                  'その時間は設定できません',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: FontSize.xsmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const Divider(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'カテゴリー',
                          style: _headlineStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          children: <Widget>[
                            for (int i = 0; i < userData.categories.length; i++)
                              (userData.categories[i][1] == "")
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: displaySize.width / 6.5,
                                            width: displaySize.width / 6.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: (record.categoryIndex ==
                                                        i)
                                                    ? (theme.isDark)
                                                        ? theme.themeColors[0]
                                                        : theme.themeColors[1]
                                                    : Colors.grey,
                                                width:
                                                    (record.categoryIndex == i)
                                                        ? 3
                                                        : 1,
                                              ),
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                  child: Icon(
                                                    IconData(
                                                      userData.categories[i][0],
                                                      fontFamily:
                                                          "MaterialIcons",
                                                    ),
                                                    color: (theme.isDark)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    size:
                                                        displaySize.width / 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      displaySize.width / 6.5,
                                                  width:
                                                      displaySize.width / 6.5,
                                                  child: FlatButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: SizedBox(),
                                                    color: Colors.transparent,
                                                    onPressed: () => record
                                                        .changeCategoryIndex(i),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: displaySize.width / 5,
                                            child: Text(
                                              userData.categories[i][1],
                                              textAlign: TextAlign.center,
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: FontSize.xxsmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: displaySize.width / 5,
                                  ),
                                  Container(
                                    height: displaySize.width / 6.5,
                                    width: displaySize.width / 6.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Icon(
                                            Icons.more_horiz,
                                            color: (theme.isDark)
                                                ? Colors.white
                                                : Colors.black,
                                            size: displaySize.width / 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: displaySize.width / 6.5,
                                          width: displaySize.width / 6.5,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(),
                                            color: Colors.transparent,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryEditPage(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget blocButton(theme, record, isGood) {
    return Container(
      height: displaySize.width / 7,
      width: displaySize.width / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (record.isGood == isGood)
              ? (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1]
              : Colors.grey,
          width: (record.isGood == isGood) ? 3 : 1,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              (isGood) ? Icons.trending_up : Icons.trending_flat,
              color: (record.isGood == isGood)
                  ? (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1]
                  : Colors.grey,
              size: displaySize.width / 10,
            ),
          ),
          SizedBox(
            height: displaySize.width / 7,
            width: displaySize.width / 7,
            child: FlatButton(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () => record.changeValue(isGood),
              child: SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class ShortCutSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 5,
              width: 50,
              margin: EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey,
              ),
            ),
            Text(
              "記録の追加",
              style: TextStyle(
                fontSize: FontSize.large,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "ショートカットモード",
              style: TextStyle(
                fontSize: FontSize.small,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: displaySize.width / 6.5,
                width: displaySize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShortCutsEditPage(),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'ショートカットの編集をする',
                      style: TextStyle(fontSize: FontSize.small),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 1,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  for (var itemList in userData.shortCuts)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: displaySize.width / 6.5,
                          width: displaySize.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              if (itemList[5]) {
                                userData.recordDone(itemList);
                              } else {
                                userData.addActivity(
                                    DateTime.now(), itemList[1], itemList[0]);
                              }
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: displaySize.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          IconData(
                                            userData.categories[itemList[0]][0],
                                            fontFamily: "MaterialIcons",
                                          ),
                                          color: (itemList[3])
                                              ? (theme.isDark)
                                                  ? theme.themeColors[0]
                                                  : theme.themeColors[1]
                                              : Colors.grey,
                                          size: displaySize.width / 10,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            itemList[1],
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: FontSize.xsmall,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      (itemList[5]) ? '記録' : '開始',
                                      style: TextStyle(
                                        fontSize: FontSize.small,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShortCutsEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    void deleteCheck(int index) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('削除'),
          content: Text('ショートカットを削除しますか？'),
          actions: <Widget>[
            FlatButton(
              child: Text('いいえ'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('はい'),
              onPressed: () {
                userData.deleteShortCut(index);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'ショートカットの編集',
          style: TextStyle(color: theme.isDark ? Colors.white : Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          (userData.tutorial[5]) ? SizedBox() : ShortCutEditTutorial(),
          Expanded(
            child: ReorderableListView(
              children: [
                for (int i = 0; i < userData.shortCuts.length; i++)
                  SizedBox(
                    key: Key(userData.shortCuts[i][4].toString()),
                    width: displaySize.width,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Card(
                            child: ListTile(
                              leading: Icon(
                                IconData(
                                  userData.categories[userData.shortCuts[i][0]]
                                      [0],
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: (userData.shortCuts[i][3])
                                    ? (theme.isDark)
                                        ? theme.themeColors[0]
                                        : theme.themeColors[1]
                                    : Colors.grey,
                                size: displaySize.width / 12,
                              ),
                              title: Text(
                                userData.shortCuts[i][1],
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  (userData.shortCuts[i][5]) ? '記録' : '開始',
                                  style: TextStyle(
                                    fontSize: FontSize.small,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                            ),
                            iconSize: displaySize.width / 12,
                            color: theme.isDark
                                ? theme.themeColors[0]
                                : theme.themeColors[1],
                            onPressed: () =>
                                deleteCheck(i) //userData.deleteShortCut(i),
                            ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
              ],
              onReorder: (oldIndex, newIndex) =>
                  userData.sort(oldIndex, newIndex),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'カテゴリーの編集',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            (userData.tutorial[8]) ? SizedBox() : CategoryEditTutorial(),
            for (int i = 1; i < 8; i++) CategoryCard(i)
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final int index;
  CategoryCard(this.index);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    void resetCheck(int index) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('リセット'),
          content: Text('このカテゴリーの記録が全てリセットされます。\nそれでもよろしいですか？'),
          actions: <Widget>[
            FlatButton(
              child: Text('いいえ'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('はい'),
              onPressed: () {
                userData.resetCategory(index);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: displaySize.width / 3,
      width: displaySize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: displaySize.width / 1.7,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    (index).toString() + '.',
                    style: TextStyle(
                      fontSize: FontSize.midium,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                          height: displaySize.width / 8,
                          width: displaySize.width / 8,
                          child: Icon(
                            IconData(userData.categories[index][0],
                                fontFamily: "MaterialIcons"),
                            size: displaySize.width / 8,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          userData.categories[index][1],
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: FontSize.small,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: displaySize.width / 8,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text('変更'),
                  color: theme.isDark ? Color(0XFF424242) : Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectIconPage(index),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: displaySize.width / 8,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  color: Colors.red,
                  child: Text(
                    'リセット',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => resetCheck(index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectIconPage extends StatelessWidget {
  final int index;
  SelectIconPage(this.index);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'アイコンの選択',
          style: TextStyle(color: theme.isDark ? Colors.white : Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await userData.dicideCategory();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(displaySize.width / 20),
            width: displaySize.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'タイトル',
                  style: TextStyle(
                    fontSize: FontSize.midium,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: displaySize.width / 2,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      hintText: '入力',
                      border: InputBorder.none,
                    ),
                    cursorColor: theme.isDark
                        ? theme.themeColors[0]
                        : theme.themeColors[1],
                    inputFormatters: [LengthLimitingTextInputFormatter(18)],
                    style: TextStyle(fontSize: FontSize.small),
                    onChanged: (s) {
                      userData.editCategoryTitle(index, s);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: displaySize.width / 20,
              ),
              Text(
                'アイコン',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: displaySize.width / 25,
              mainAxisSpacing: 10,
              children: <Widget>[
                for (int i = 0; i < iconList.length; i++)
                  SizedBox(
                    height: displaySize.width / 4,
                    child: IconButton(
                      tooltip: iconHintList[i],
                      icon: Icon(
                        IconData(
                          iconList[i],
                          fontFamily: "MaterialIcons",
                        ),
                        color: (userData.categories[index][0] == iconList[i])
                            ? (theme.isDark)
                                ? theme.themeColors[0]
                                : theme.themeColors[1]
                            : Colors.grey,
                        size: displaySize.width / 8,
                      ),
                      onPressed: () => userData.editCategoryIcon(
                        index,
                        iconList[i],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
