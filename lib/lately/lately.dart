import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zikanri/data.dart';

class LatelyPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Text(
            '最近の記録',
            style: TextStyle(
              fontSize: FontSize.xlarge,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: displaySize.width / 2.5,
          child: PageView(
            onPageChanged: (i) => userData.setIndex(i),
            controller: PageController(initialPage: userData.latelyData.length),
            children: <Widget>[
              for (var itemList in userData.latelyData)
                _dayData(itemList, theme),
            ],
          ),
        ),
        SizedBox(
          height: displaySize.width / 20,
        ),
        _dayDone(
          (userData.latelyData.length == 1) ? 0 : userData.index,
          theme,
          userData,
        ),
        SizedBox(
          height: displaySize.width / 10,
        ),
      ],
    );
  }

  Widget _dayData(List l, theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
                color:
                    theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
                width: 2),
          ),
          child: Column(
            children: <Widget>[
              Text(
                l[0],
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '記録時間',
                        style: TextStyle(),
                      ),
                      Text(
                        l[1].toString() + '分',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '総ポイント',
                        style: TextStyle(),
                      ),
                      Text(
                        l[2].toString() + 'pt',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '時間価値',
                        style: TextStyle(),
                      ),
                      Text(
                        l[3].toString() + 'pt',
                        style: TextStyle(),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayDone(i, theme, userData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(
                color:
                    theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
                width: 2),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  '記録',
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Divider(
                  height: 5,
                ),
                for (int j = 0; j < userData.latelyDoneData[i].length; j++)
                  _dayDoneList(userData.latelyDoneData[i][j], j),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: (userData.latelyDoneData[i].length == 0)
                          ? displaySize.width / 5
                          : 0,
                    ),
                    child: Text(
                      (userData.latelyDoneData[i].length == 0)
                          ? 'この日の記録はありません'
                          : '',
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

  Widget _dayDoneList(List itemList, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              IconData(
                int.parse(itemList[0]),
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 12,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemList[1],
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: FontSize.xsmall,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: displaySize.width / 2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Text(
                          itemList[2] + '分 × ' + itemList[3] + 'pt',
                          style: TextStyle(
                            fontSize: FontSize.xxsmall,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Text(
                            '→',
                            style: TextStyle(
                              fontSize: FontSize.small,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          itemList[4] + 'pt',
                          style: TextStyle(
                            fontSize: FontSize.xxsmall,
                          ),
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
    );
  }
}
