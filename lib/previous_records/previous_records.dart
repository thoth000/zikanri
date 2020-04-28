import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../items/drawer/drawer.dart';

class PRPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'これまでの記録',
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
          Padding(
            padding: EdgeInsets.all(displaySize.width / 16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: displaySize.width / 2.5,
                width: displaySize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.isDark
                        ? theme.themeColors[0]
                        : theme.themeColors[1],
                    width: 3,
                  ),
                ),
                child: PageView.builder(
                  itemCount: 3,
                  controller: PageController(
                    initialPage: 1,
                  ),
                  itemBuilder: (context, index) {
                    if (index % 3 == 1)
                      return topCard(
                          '総記録時間', userData.allTime.toString() + '分');
                    else if (index % 3 == 0)
                      return topCard(
                          '総価値時間', userData.allGood.toString() + '分');
                    return topCard('価値の割合', userData.allPer.toString() + '%');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget topCard(title, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.bubble_chart,
          size: displaySize.width / 10,
        ),
        Text(
          value,
          style:
              TextStyle(fontSize: FontSize.xlarge, fontWeight: FontWeight.w700),
        ),
        Text(
          title,
          style: TextStyle(fontSize: FontSize.xsmall, color: Colors.grey),
        ),
      ],
    );
  }
}
