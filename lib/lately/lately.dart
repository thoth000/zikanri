import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

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
            height: displaySize.width / 2+20,
            child: PageView(
              onPageChanged: (i) {
                userData.setIndex(i);
              },
              controller: PageController(
                initialPage: userData.latelyData.length,
              ),
              children: <Widget>[
                for (var itemList in userData.latelyData) DayData(itemList),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: _dayDone(
              (userData.latelyData.length == 1) ? 0 : userData.index,
              theme,
              userData,
            ),
          ),
          SizedBox(
            height: displaySize.width / 10,
          ),
        ],
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
      padding: const EdgeInsets.symmetric(
        vertical: 8,
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
                  width: displaySize.width / 7,
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

class DayData extends StatelessWidget {
  final l;
  DayData(this.l);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    GlobalKey _globalKey = GlobalKey();
    Future _exportToImage() async {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(
        pixelRatio: 3.0,
      );
      ByteData byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final _pngBytes = byteData.buffer.asUint8List();
      await Share.file('今日の記録', 'today.png',_pngBytes, 'image/png', text: 'これをツイートしたいのに…');
    }

    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        height: displaySize.width/2+20,
        width: displaySize.width,
        color: (theme.isDark) ? Color(0XFF303030) : Color(0XFFFAFAFA),
        child: Padding(
          padding: EdgeInsets.all(10),
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
                  color:
                      theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
                  width: 2,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: displaySize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: displaySize.width / 15,
                        ),
                        Text(
                          l[0], //日付
                          style: TextStyle(
                            fontSize: FontSize.large,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: displaySize.width / 15,
                          width: displaySize.width / 15,
                          child: Stack(
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                size: displaySize.width / 15,
                              ),
                              SizedBox(
                                height: displaySize.width / 15,
                                width: displaySize.width / 15,
                                child: FlatButton(
                                  color: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(),
                                  onPressed: () async {
                                    _exportToImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _widget(
                        '記録時間',
                        l[1].toString()+'分',
                      ),
                      _widget(
                        '価値時間',
                        l[2].toString()+'分',
                      ),
                      _widget(
                        '価値の割合',
                        l[3].toString() + '%',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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
            value,
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
}
