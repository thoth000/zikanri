import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../items/drawer/drawer.dart';
import 'total_score.dart';
import '../data.dart';
import 'record_button.dart';
import 'this_month.dart';
import 'today.dart';

class HomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String today = DateFormat('yyyy年MM月dd日現在').format(DateTime.now());
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      resizeToAvoidBottomInset:false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ホーム',
          style: TextStyle(
            color: (theme.isDark) ? Colors.white : Colors.black,
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
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              TotalScoreWidget(),
              Divider(
                height: 20,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '今月の情報',
                      style: TextStyle(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      today,
                      style: TextStyle(
                        fontSize:FontSize.xxsmall,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              TMWidget(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      '今日の情報',
                      style: TextStyle(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      today,
                      style: TextStyle(
                        fontSize:FontSize.xxsmall,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              TodayWidget(),
              Container(
                height: displaySize.width / 10,
                width: displaySize.width,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: RButton(),
            ),
          ),
        ],
      ),
    );
  }
}
