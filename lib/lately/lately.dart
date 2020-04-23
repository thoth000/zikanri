import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zikanri/data.dart';
import 'package:zikanri/items/drawer/drawer.dart';

class LatelyPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '最近の記録',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: SlideMenu(),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 15,
          ),
          SizedBox(
            height: displaySize.width / 2,
            child: PageView(
              onPageChanged: (i) => userData.setIndex(i),
              controller:
                  PageController(initialPage: userData.latelyData.length),
              children: <Widget>[
                for (var itemList in userData.latelyData)
                  _dayData(itemList, theme),
              ],
            ),
          ),
          SizedBox(
            height: displaySize.width / 15,
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
      ),
    );
  }

  Widget _widget(
    String title,
    var value,
  ) {
    return Container(
      height: displaySize.width / 3.5,
      width: displaySize.width / 3.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.bubble_chart,
          ),
          Text(
            value.toString(),
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: FontSize.xxsmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayData(List l, theme) {
    //lはlatelyDataのリストアイテム
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: displaySize.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            border: Border.all(
              color: theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
              width: 2,
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                l[0], //日付
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _widget(
                    '記録時間',
                    l[1],
                  ),
                  _widget(
                    '価値時間',
                    l[2],
                  ),
                  _widget(
                    '価値の割合',
                    l[3],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayDone(i, theme, userData) {
    //iは日付に対応したindex
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            border: Border.all(
              color: theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
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
                for (int j = 0; j < userData.latelyData[i][4].length; j++)
                  _dayDoneList(userData.latelyData[i][4][j], theme),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: (userData.latelyData[i][4].length == 0)
                          ? displaySize.width / 7
                          : 0,
                    ),
                    child: Text(
                      (userData.latelyData[i][4].length == 0)
                          ? 'この日の記録はありません'
                          : '',
                      style: TextStyle(
                        fontSize: FontSize.xsmall,
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

  Widget _dayDoneList(List itemList, theme) {
    //itemListは各日のDoneListの中の記録
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Icon(
              IconData(
                int.parse(itemList[0]),
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 12,
              color: (itemList[3])
                  ? (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1]
                  : Colors.grey,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    itemList[1], //タイトル
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: FontSize.midium,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: displaySize.width/7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        itemList[2].toString() + '分',
                        style: TextStyle(
                          fontSize: FontSize.xsmall,
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
