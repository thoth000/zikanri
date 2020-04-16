import 'package:flutter/material.dart';
import '../../Setting/Setting.dart';
import '../../data.dart';
import 'package:provider/provider.dart';

class DHWidget extends StatefulWidget {
  @override
  _DHWidgetState createState() => new _DHWidgetState();
}

class _DHWidgetState extends State<DHWidget> {
  Widget build(BuildContext context) {
    @override
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return DrawerHeader(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: theme.themeColors)),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  shape: CircleBorder(),
                  child: Container(
                      width: displaySize.width / 4,
                      height: displaySize.width / 4,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color:(theme.isDark)? Color(0XFF303030) : Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            displaySize.width,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: userIcon
                              )
                          )
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingPage(),
                      ),
                    );
                  },
                ),
                (userData.registerCheck)?
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 3.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "@${userData.userID}",
                        style: TextStyle(
                          fontSize: displaySize.width / 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                )
                :Text(' ',style: TextStyle(fontSize: displaySize.width/17),),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, right: displaySize.width / 5,bottom: 1.0),
                child: Text(
                  '${userData.userName}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: displaySize.width / 13,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ));
  }
}
