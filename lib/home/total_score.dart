import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import 'package:share/share.dart';

class TotalScoreWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 20),
      child: Container(
        height: displaySize.width / 2.2,
        width: displaySize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: theme.themeColors),
          borderRadius:
              BorderRadius.all(Radius.circular(displaySize.width / 12)),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: displaySize.width / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: null,
                  iconSize: displaySize.width / 15,
                  icon: Icon(null),
                ),
                Text(
                  'Total Point',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.xlarge, //12.5
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: displaySize.width / 15,
                  ),
                  onPressed: () {
                    Share.share(
                      "ユーザー:${userData.userName}\n${userData.totalPointScore}ポイントに到達しました！\n#ジカンリ",
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: displaySize.width / 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: displaySize.width / 30),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    userData.totalPointScore.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.big,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
