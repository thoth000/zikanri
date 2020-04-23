import 'package:flutter/material.dart';
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
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: theme.themeColors)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'MyIcon',
            child: Container(
              width: displaySize.width / 4,
              height: displaySize.width / 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: (theme.isDark) ? Color(0XFF303030) : Colors.white,
                  width: 5,
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: userIcon,
                ),
              ),
              child: SizedBox(
                height: displaySize.width / 4,
                width: displaySize.width / 4,
                child: FlatButton(
                  color: Colors.transparent,
                  shape: CircleBorder(),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyIconPage(),
                    ),
                  ),
                  child: Container(),
                ),
              ),
            ),
          ),
          SizedBox(
            width: displaySize.width / 20,
          ),
          Flexible(
            child: Text(
              '${userData.userName}',
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.large, //12.5
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyIconPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: 'MyIcon',
          child: Image(
            image: userIcon,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
