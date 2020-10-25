//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';

class ThemeSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'テーマの変更',
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 20,
          ),
          Center(
            child: _ThemeSampleWidget(),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
          Divider(
            height: displaySize.width/12,
            thickness: 1,
            indent: displaySize.width/35,
            endIndent: displaySize.width/35,
          ),
          _DarkModeChanger(),
          Divider(
            height: displaySize.width/12,
            thickness: 1,
            indent: displaySize.width/35,
            endIndent: displaySize.width/35,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: displaySize.width/35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'テーマ一覧',
                  style: TextStyle(
                    fontSize: FontSize.midium,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: displaySize.width/35,
                ),
                Wrap(
                  children: List.generate(
                    baseColors.length,
                    (index) => _ThemeChanger(index),
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

class _ThemeSampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Container(
      height: displaySize.width / 2.2,
      width: displaySize.width / 1.1,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: theme.themeColors),
        borderRadius: BorderRadius.all(
          Radius.circular(displaySize.width / 12),
        ),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 1.0,
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(10, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: null,
                iconSize: displaySize.width / 15,
                icon: const Icon(null),
              ),
              Text(
                'Good Rate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSize.xlarge,
                  fontWeight: FontWeight.w300,
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: displaySize.width / 15,
                ),
                onPressed: null,
              ),
            ],
          ),
          SizedBox(
            height: displaySize.width / 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displaySize.width / 30),
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  '7777',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.big,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DarkModeChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Container(
      height: displaySize.width / 9,
      width: displaySize.width,
      padding: EdgeInsets.symmetric(horizontal: displaySize.width/35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'ダークモード',
            style: TextStyle(
              fontSize: FontSize.midium,
              fontWeight: FontWeight.bold,
            ),
          ),
          Switch(
            value: theme.isDark,
            onChanged: (boolean) {
              Vib.select();
              theme.changeMode();
            },
            activeColor:
                (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1],
          ),
        ],
      ),
    );
  }
}

class _ThemeChanger extends StatelessWidget {
  const _ThemeChanger(this.i);
  final int i;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    if (userData.myColors[i]) {
      return Padding(
        padding: EdgeInsets.all(displaySize.width/35),
        child: Container(
          height: displaySize.width / 8,
          width: displaySize.width / 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: baseColors[i],
            ),
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Colors.transparent,
            child: const SizedBox(),
            onPressed: () async {
              Vib.select();
              await theme.changeTheme(i);
            },
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
