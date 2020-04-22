import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../data.dart';
import '../splash.dart';
import 'home.dart';

class MinuteMeter extends StatefulWidget {
  @override
  _MinuteMeterState createState() => _MinuteMeterState();
}

class _MinuteMeterState extends State<MinuteMeter> {
  void initState() {
    super.initState();
    reflesh();
  }

  void reflesh() async {
    var now = DateTime.now();
    if (DateFormat("yyyy年MM月dd日").format(now) !=
        Hive.box('userData').get('previousDate')) {
      await Future.delayed(Duration());
      showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (context) => datecheckDialog(context),
      );
    } else {
      setState(() {
        for (int i = 0; i < activities.length; i++) {
          var activity = activities[i];
          if (activity[1]) {
          } else {
            activity[5] = activity[4] + now.difference(activity[0]).inMinutes;
          }
        }
      });
    }
  }

  Future startTimer(int i) async {
    setState(() {
      activities[i][0] = DateTime.now();
      activities[i][1] = false;
    });
    await Hive.box('userData').put('activities', activities);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
        content: Text(
          'タイマーをスタートさせました',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future stopTimer(int i) async {
    //スタート時刻を更新して、時間に差分を加える
    setState(() {
      activities[i][4] += DateTime.now().difference(activities[i][0]).inMinutes;
      activities[i][5] = activities[i][4];
      activities[i][1] = true;
    });
    await Hive.box('userData').put('activities', activities);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
        content: Text(
          'タイマーをストップさせました',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future finishActivity(i) async {
    //これして
    setState(() => activities.removeAt(i));
    await Hive.box('userData').put('activities', activities);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Column(
      children: <Widget>[
        (activities.length == 0)
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
                    SizedBox(
                      height: displaySize.width / 12,
                      width: displaySize.width / 12,
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.refresh,
                            size: displaySize.width / 12,
                          ),
                          SizedBox(
                            height: displaySize.width / 12,
                            width: displaySize.width / 12,
                            child: FlatButton(
                              color: Colors.transparent,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(),
                              onPressed: reflesh,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        for (int i = 0; i < activities.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
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
                //TODO:ここからメイン
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              width: displaySize.width / 1.65,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    IconData(int.parse(activities[i][3]),
                                        fontFamily: "MaterialIcons"),
                                    size: displaySize.width / 10,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      activities[i][2],
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
                            Text(
                              activities[i][5].toString() + '分',
                              style: TextStyle(fontSize: FontSize.midium),
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
                                      (activities[i][1])
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
                                        onPressed: () => (activities[i][1])
                                            ? startTimer(i)
                                            : stopTimer(i),
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
                                          var activity = activities[i];
                                          int time = activity[4] +
                                              DateTime.now()
                                                  .difference(activity[0])
                                                  .inMinutes;
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                FinishRecordDialog(
                                                    activity, time, i),
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
                                        onPressed: () => finishActivity(i),
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

  Widget datecheckDialog(context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text('日付が変わっています'),
      content: Text('タイトル画面に戻ります'),
      actions: <Widget>[
        FlatButton(
          child: Text('はい'),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SplashPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class FinishRecordDialog extends StatelessWidget {
  final activity;
  final time;
  final index;
  //activity[0:datetime 1:bool 2:title 3:category 4:tmp 5:tmp]
  FinishRecordDialog(this.activity, this.time, this.index);
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
        height: displaySize.width + 20,
        width: displaySize.width / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                IconData(
                  int.parse(activity[3]),
                  fontFamily: 'MaterialIcons',
                ),
                size: displaySize.width / 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  activity[2],
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
                  for (int i = 0; i < 3; i++) numberBloc(theme, record, i),
                ],
              ),
              SizedBox(
                height: displaySize.width / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  for (int i = 3; i < 6; i++) numberBloc(theme, record, i),
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
                    onPressed: () {
                      userData.recordDone(
                        [
                          activity[3],
                          activity[2],
                          time.toString(),
                          record.rating.toString(),
                          (time * record.rating).toString(),
                        ],
                      );
                      activities.removeAt(index);
                      Hive.box('userData').put('activities', activities);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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

  Widget numberBloc(theme, record, i) {
    return SizedBox(
      height: displaySize.width / 8,
      width: displaySize.width / 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: (record.rating == i)
                ? (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1]
                : Colors.grey,
            width: (record.rating == i) ? 3 : 1,
          ),
        ),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () => record.changeValue(i),
          child: Text(
            i.toString(),
            style: TextStyle(
              fontSize: FontSize.xsmall,
            ),
          ),
        ),
      ),
    );
  }
}
