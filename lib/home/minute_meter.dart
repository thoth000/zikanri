import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../data.dart';
import '../splash.dart';

class MinuteMeter extends StatefulWidget {
  @override
  _MinuteMeterState createState() => _MinuteMeterState();
}

class _MinuteMeterState extends State<MinuteMeter> {
  void initState() {
    super.initState();
    dateCheck();
    loopReflesh();
  }

  void dateCheck() async {
    var now = DateTime.now();
    if (DateFormat("yyyy年MM月dd日").format(now) !=
        Hive.box('userData').get('previousDate')) {
      await Future.delayed(Duration());
      showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (context) => datecheckDialog(context),
      );
      await pagechange();
    }
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

  Future loopReflesh() async {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    Timer.periodic(Duration(seconds: 10), (t) => userData.loopReflesh());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    void checkDelete(int index){
      showDialog(context: context,
      builder: (context)=>AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text('削除'),
        content: Text('この記録を削除しますか？'),
        actions: <Widget>[
          FlatButton(
            child: Text('いいえ'),
            onPressed: (){Navigator.pop(context);}
          ),
          FlatButton(
            child: Text('はい'),
            onPressed: (){
              userData.finishActivity(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      );
    }
    return Column(
      children: <Widget>[
        (userData.activities.length == 0)
            ? Container()
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '今の活動',
                      style: TextStyle(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
        for (int i = 0; i < userData.activities.length; i++)
          Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: displaySize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: displaySize.width / 10,
                        width: displaySize.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: displaySize.width / 1.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    IconData(
                                        userData.categories[userData.activities[i][3]][0],
                                        fontFamily: "MaterialIcons"),
                                    size: displaySize.width / 10,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      userData.activities[i][2],
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: FontSize.small,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: displaySize.width / 5.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    userData.activities[i][5].toString() + '分',
                                    style: TextStyle(fontSize: FontSize.midium),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: displaySize.width / 36,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: displaySize.width / 125),
                        child: Container(
                          width: displaySize.width / 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                height: displaySize.width / 12,
                                width: displaySize.width / 12,
                                child: Stack(
                                  children: <Widget>[
                                    Icon(
                                      (userData.activities[i][1])
                                          ? Icons.play_circle_outline
                                          : Icons.pause_circle_outline,
                                      color: theme.isDark
                                          ? theme.themeColors[0]
                                          : theme.themeColors[1],
                                      size: displaySize.width / 12,
                                    ),
                                    SizedBox(
                                      height: displaySize.width / 12,
                                      width: displaySize.width / 12,
                                      child: FlatButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(),
                                        onPressed: () async {
                                          if (userData.activities[i][1]) {
                                            userData.startTimer(i);
                                            Scaffold.of(context).showSnackBar(
                                              notifySnackBar("タイマーをスタートさせました"),
                                            );
                                          } else {
                                            userData.stopTimer(i);
                                            Scaffold.of(context).showSnackBar(
                                              notifySnackBar("タイマーをストップさせました"),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: displaySize.width / 12,
                                width: displaySize.width / 12,
                                child: Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: theme.isDark
                                          ? theme.themeColors[0]
                                          : theme.themeColors[1],
                                      size: displaySize.width / 12,
                                    ),
                                    SizedBox(
                                      height: displaySize.width / 12,
                                      width: displaySize.width / 12,
                                      child: FlatButton(
                                        child: Container(),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () {
                                          Vib.select();
                                          int time = userData.activities[i][4] +
                                              DateTime.now()
                                                  .difference(
                                                      userData.activities[i][0])
                                                  .inMinutes;
                                          record.copyData(
                                              userData.activities[i][3],
                                              userData.activities[i][2],
                                              time,);
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                FinishRecordDialog(i),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: displaySize.width / 12,
                                width: displaySize.width / 12,
                                child: Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.remove_circle_outline,
                                      color: theme.isDark
                                          ? theme.themeColors[0]
                                          : theme.themeColors[1],
                                      size: displaySize.width / 12,
                                    ),
                                    SizedBox(
                                      height: displaySize.width / 12,
                                      width: displaySize.width / 12,
                                      child: FlatButton(
                                        child: Container(),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () => checkDelete(i),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        SizedBox(
          height: (activities.length == 0) ? 0 : 20,
        ),
      ],
    );
  }

  Widget notifySnackBar(String s) {
    return SnackBar(
      duration: Duration(seconds: 1),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      content: Text(
        s,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget datecheckDialog(context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('日付が変わっています'),
      content: Text('自動的にタイトル画面に戻ります'),
    );
  }
}

class FinishRecordDialog extends StatelessWidget {
  final index;
  //activity[0:datetime 1:bool 2:title 3:categoryIndex 4:tmp 5:tmp]
  FinishRecordDialog(this.index);
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: displaySize.width,
        width: displaySize.width / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                IconData(
                  userData.categories[record.categoryIndex][0],
                  fontFamily: 'MaterialIcons',
                ),
                size: displaySize.width / 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  record.title,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: FontSize.midium,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Divider(
                height: displaySize.width / 30,
              ),
              Text(
                '時間の価値',
                style: TextStyle(
                  fontSize: FontSize.small,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: displaySize.width / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  blocButton(theme, record, false),
                  blocButton(theme, record, true),
                ],
              ),
              SizedBox(
                height: displaySize.width / 30,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 5,
                child: SizedBox(
                  height: displaySize.width / 7,
                  width: displaySize.width / 3,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '記録する',
                      style: TextStyle(fontSize: FontSize.xsmall),
                    ),
                    onPressed: () async {
                      userData.recordDone(
                        [
                          record.categoryIndex,
                          record.title,
                          record.time,
                          record.isGood,
                        ],
                      );
                      userData.finishActivity(index);
                      Navigator.pop(context);
                    },
                  ),
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
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}