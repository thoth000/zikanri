import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class AchievePage extends StatefulWidget {
  @override
  _AchievePageState createState() => _AchievePageState();
}

class _AchievePageState extends State<AchievePage> {
  bool page = true;
  void change(b) {
    setState(() {
      page = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          '実績',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: displaySize.width / 7.5,
                width: displaySize.width / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (page)
                        ? (theme.isDark)
                            ? theme.themeColors[0]
                            : theme.themeColors[1]
                        : Colors.grey,
                    width: (page) ? 3 : 1,
                  ),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('記録'),
                  ),
                  onPressed: () => change(true),
                ),
              ),
              Container(
                height: displaySize.width / 7.5,
                width: displaySize.width / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (!page)
                        ? (theme.isDark)
                            ? theme.themeColors[0]
                            : theme.themeColors[1]
                        : Colors.grey,
                    width: (!page) ? 3 : 1,
                  ),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('ログイン'),
                  ),
                  onPressed: () => change(false),
                ),
              ),
            ],
          ),
          Expanded(
            child: (page) ? AchiveMiniteWidget() : AchiveDayWidget(),
          ),
        ],
      ),
    );
  }
}

class AchiveMiniteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            '記録時間',
            style: TextStyle(fontSize: FontSize.small),
          ),
          Text(
            userData.allTime.toString() + '分',
            style: TextStyle(
              fontSize: FontSize.xxlarge,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (int i = 0; i < achiveM.length; i++)
            achive(i, userData.checkM[i]),
        ],
      ),
    );
  }

  Widget achive(int i, check) {
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: displaySize.width / 4,
          width: displaySize.width / 1.2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  achiveM[i].toString() + '分',
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: displaySize.width / 4,
                  height: displaySize.width / 9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: check
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '達成',
                              style: TextStyle(
                                fontSize: FontSize.xsmall,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.lightGreen,
                              size: displaySize.width / 15,
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            '未達成',
                            style: TextStyle(
                              fontSize: FontSize.xsmall,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AchiveDayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            'ログイン日数',
            style: TextStyle(fontSize: FontSize.small),
          ),
          Text(
            userData.totalPassedDays.toString() + '日',
            style: TextStyle(
              fontSize: FontSize.xxlarge,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (int i = 0; i < achiveD.length; i++)
            achive(i, userData.checkD[i]),
        ],
      ),
    );
  }

  Widget achive(int i, check) {
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: displaySize.width / 4,
          width: displaySize.width / 1.2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  achiveD[i].toString() + '日',
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  width: displaySize.width / 4,
                  height: displaySize.width / 9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: check
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '達成',
                              style: TextStyle(
                                fontSize: FontSize.xsmall,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.lightGreen,
                              size: displaySize.width / 15,
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            '未達成',
                            style: TextStyle(
                              fontSize: FontSize.xsmall,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}