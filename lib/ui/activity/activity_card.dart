//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/activity/finish_activity_sheet.dart';

class ActivityCard extends StatelessWidget {
  ActivityCard({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: displaySize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(displaySize.width / 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _ActivityInfo(index: index),
            SizedBox(
              height: displaySize.width / 35,
            ),
            _ActivityActionButtonList(index: index),
          ],
        ),
      ),
    );
  }
}

class _ActivityInfo extends StatelessWidget {
  _ActivityInfo({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return SizedBox(
      height: displaySize.width / 10,
      width: displaySize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconData(
              userData.categories[userData.activities[index][3]][0],
              fontFamily: 'MaterialIcons',
            ),
            size: displaySize.width / 10,
            color: Colors.grey,
          ),
          SizedBox(
            width: displaySize.width / 35,
          ),
          Expanded(
            child: Text(
              userData.activities[index][2],
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                fontSize: FontSize.small,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: displaySize.width / 35,
          ),
          Text(
            userData.activities[index][5].toString() + '分',
            style: TextStyle(fontSize: FontSize.midium),
          ),
        ],
      ),
    );
  }
}

class _ActivityActionButtonList extends StatelessWidget {
  _ActivityActionButtonList({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return SizedBox(
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
                  (userData.activities[index][1])
                      ? Icons.play_circle_outline
                      : Icons.pause_circle_outline,
                  color: color,
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
                      if (userData.activities[index][1]) {
                        Vib.select();
                        userData.startTimer(index);
                        Scaffold.of(context).showSnackBar(
                          notifySnackBar('タイマーをスタートさせました'),
                        );
                      } else {
                        Vib.select();
                        userData.stopTimer(index);
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
                  color: color,
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
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        builder: (context) =>
                            FinishActivitySheet.wrapped(index),
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
                  color: color,
                  size: displaySize.width / 12,
                ),
                SizedBox(
                  height: displaySize.width / 12,
                  width: displaySize.width / 12,
                  child: FlatButton(
                    child: const SizedBox(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => _RemoveActivityDialog(
                        index: index,
                      ),
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
}

class _RemoveActivityDialog extends StatelessWidget {
  _RemoveActivityDialog({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return AlertDialog(
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
          },
        ),
        FlatButton(
          child: Text('はい'),
          onPressed: () {
            userData.finishActivity(index);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
