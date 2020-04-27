import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../previous_records/previous_records.dart';
import '../../lately/lately.dart';
import '../../Setting/Setting.dart';
import '../../home/home.dart';
import '../../data.dart';
import 'drawer_header.dart';

class SlideMenu extends StatelessWidget {
  Route _createRoute(page) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Drawer(
      child: Stack(
        children: <Widget>[
          _drawerListView(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: displaySize.width / 8 + 10.0),
              child: Divider(height: 1,thickness: 1,),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom:5.0,left: 10),
              child: IconButton(
                iconSize: displaySize.width/11,
                icon: Icon(Icons.settings),
                color: Colors.grey[700],
                onPressed: () async{
                  Navigator.pop(context);
                  await Navigator.push(context,_createRoute(SettingPage()));
                }
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: resisterButton(context, theme, userData),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerListView(
    context,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: displaySize.width / 8 + 20.0),
      child: ListView(
        children: <Widget>[
          DHWidget(),
          FlatButton(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: displaySize.width / 8,
                    color: Colors.grey[700],
                  ),
                  Text(
                    '  ホーム',
                    style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.today,
                    size: displaySize.width / 8,
                    color: Colors.grey[700],
                  ),
                  Text(
                    '  最近の記録',
                    style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            onPressed: () async{
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LatelyPage(),
                ),
              );
            },
          ),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.assessment,
                    size: displaySize.width / 8,
                    color: Colors.grey[700],
                  ),
                  Text(
                    ' これまでの記録',
                    style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PRPage(),
                ),
              );
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            endIndent: 20,
          ),
        ],
      ),
    );
  }

  Widget isDarkButton(theme,context) {
    return IconButton(
      icon: Icon(Icons.lightbulb_outline),
      iconSize: displaySize.width / 11,
      color: Colors.grey[700],
      onPressed: (){
        Navigator.pop(context);
        theme.changeMode();
        },
    );
  }

  Widget resisterButton(context, theme, userData) {
    if (userData.registerCheck == false) {
      return Container(
        height: displaySize.width / 8,
        width: displaySize.width / 3,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: theme.themeColors),
          borderRadius:
              BorderRadius.all(Radius.circular(100)),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                'アカウント登録',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.xsmall,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: displaySize.width/8,
              width: displaySize.width/3,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: null,//TODO:登録ページ
                child: Container(),
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
