//dart
import 'dart:async';

//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:zikanri/controller/activity_notifier.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/splash.dart';

class MinuteMeter extends StatefulWidget {
  @override
  _MinuteMeterState createState() => _MinuteMeterState();
}

class _MinuteMeterState extends State<MinuteMeter> {
  //function
  void initState() {
    super.initState();
    dateCheck();
    loopReflesh();
  }

  Future dateCheck() async {
    var now = DateTime.now();
    if (DateFormat('yyyy年MM月dd日').format(now) !=
        Hive.box('userData').get('previousDate')) {
      await Future.delayed(Duration.zero);
      showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (context) => datecheckDialog(context),
      );
      await pagechange();
    }
  }

  Future pagechange() async {
    await Future.delayed(
      Duration(
        milliseconds: 1500,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SplashPage(),
      ),
    );
  }

  Future loopReflesh() async {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    Future.delayed(Duration.zero, userData.loopReflesh);
    Timer.periodic(Duration(seconds: 10), (t) => userData.loopReflesh());
  }

  @override
  Widget build(BuildContext context) {
    //controller
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    //function
    void checkDelete(int index) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('削除'),
          content: Text('この記録を削除しますか？'),
          actions: <Widget>[
            FlatButton(
                child: Text('いいえ'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
              child: Text('はい'),
              onPressed: () {
                userData.finishActivity(index);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    //widget
    return Column(
      children: <Widget>[
        (userData.activities.length == 0)
            ? SizedBox()
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: displaySize.width / 10,
                      width: displaySize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: displaySize.width / 1.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  IconData(
                                    userData.categories[userData.activities[i]
                                        [3]][0],
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: displaySize.width / 10,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    userData.activities[i][2],
                                    overflow: TextOverflow.ellipsis,
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
                          Expanded(
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
                      child: SizedBox(
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
                                      child: SizedBox(),
                                      onPressed: () async {
                                        if (userData.activities[i][1]) {
                                          userData.startTimer(i);
                                          Scaffold.of(context).showSnackBar(
                                            notifySnackBar('タイマーをスタートさせました'),
                                          );
                                        } else {
                                          userData.stopTimer(i);
                                          Scaffold.of(context).showSnackBar(
                                            notifySnackBar('タイマーをストップさせました'),
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
                                      child: SizedBox(),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        Vib.select();
                                        /*showDialog(
                                          context: context,
                                          builder: (context) =>
                                              FinishActivityDialog.wrapped(i),
                                        );*/
                                        showModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(30),
                                            ),
                                          ),
                                          builder: (context) =>
                                              FinishActivitySheet.wrapped(i),
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
                                      child: SizedBox(),
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

class FinishActivitySheet extends StatelessWidget {
  const FinishActivitySheet._({Key key, this.index}) : super(key: key);

  static Widget wrapped(int index) {
    return ChangeNotifierProvider(
      create: (_) => ActivityNotifier(),
      child: FinishActivitySheet._(index: index),
    );
  }

  final int index;
  //activity[0:datetime 1:bool 2:title 3:categoryIndex 4:tmp 5:tmp]
  @override
  Widget build(BuildContext context) {
    //controller
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final activityController = Provider.of<ActivityNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //value
    final activity = activityController.isRecording
        ? ['', '', '', 0, 0, 0]
        : userData.activities[index];
    String title = activity[2];
    int categoryIndex = activity[3];
    int time = activity[5];
    //widget
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 5,
            width: 70,
            margin: EdgeInsets.all(12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
          ),
          Text(
            '活動の記録',
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          SizedBox(
            height: displaySize.width / 1.35,
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "活動の情報",
                      style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: displaySize.width / 25,
                    ),
                    Icon(
                      IconData(
                        userData.categories[categoryIndex][0],
                        fontFamily: 'MaterialIcons',
                      ),
                      size: displaySize.width / 7,
                    ),
                    SizedBox(
                      width: displaySize.width / 25,
                    ),
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: FontSize.midium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ValueSelectBloc(
                      boolean: false,
                    ),
                    SizedBox(
                      width: displaySize.width / 10,
                    ),
                    ValueSelectBloc(
                      boolean: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: displaySize.width / 20,
                ),
                Center(
                  child: Container(
                    height: displaySize.width / 6.5,
                    width: displaySize.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      border: Border.all(
                        color: color,
                        width: 3,
                      ),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500),
                      ),
                      child: Text(
                        '記録する',
                        style: TextStyle(
                          fontSize: FontSize.midium,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () async {
                        Vib.decide();
                        activityController.startRecord();
                        await userData.recordDone(
                          [
                            categoryIndex,
                            title,
                            time,
                            activityController.isGood,
                          ],
                        );
                        await userData.finishActivity(index);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ValueSelectBloc extends StatelessWidget {
  ValueSelectBloc({this.boolean});
  final bool boolean;
  @override
  Widget build(BuildContext context) {
    //controllers
    final theme = Provider.of<ThemeNotifier>(context);
    final activityController = Provider.of<ActivityNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //widget
    return Container(
      height: displaySize.width / 7,
      width: displaySize.width / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (activityController.isGood == boolean) ? color : Colors.grey,
          width: (activityController.isGood == boolean) ? 3 : 1,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              (boolean) ? Icons.trending_up : Icons.trending_flat,
              color:
                  (activityController.isGood == boolean) ? color : Colors.grey,
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
              onPressed: () => activityController.changeValue(boolean),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
