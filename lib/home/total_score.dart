import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import 'package:share/share.dart';

class TotalScoreWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    Size displaySize;
    displaySize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: displaySize.width / 2,
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
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(displaySize.width / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      null,
                      size: displaySize.width / 10,
                    ),
                    Text(
                      'Total Point',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: displaySize.width / 12.5,
                          fontWeight: FontWeight.w300),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: displaySize.width / 12.5,
                      ),
                      onPressed: () {
                        Share.share(
                          "ユーザーID:${userData.userID}\n${userData.totalPointScore}ポイントに到達しました！\n#ジカンリ",
                        );
                      },
                    ),
                  ],
                ),
              ),
              Text(
                userData.totalPointScore.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: displaySize.width / 5.5,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
