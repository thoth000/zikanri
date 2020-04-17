import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import 'package:share/share.dart';

class TotalScoreWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: displaySize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: theme.themeColors),
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed:null,
                  iconSize: displaySize.width/12,
                  icon: Icon(null),
                ),
                Text(
                  'Total Point',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.xlarge,//12.5
                    fontWeight: FontWeight.w300
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: displaySize.width / 12,
                  ),
                  onPressed: () {
                    Share.share(
                      "ユーザーID:${userData.userID}\n${userData.totalPointScore}ポイントに到達しました！\n#ジカンリ",
                    );
                  },
                ),
              ],
            ),
            Text(
              userData.totalPointScore.toString(),
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.big,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
