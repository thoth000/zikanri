import 'dart:typed_data';
import 'dart:ui' as ui;
//packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class TotalScoreWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    GlobalKey _globalKey = GlobalKey();

    Future _exportToImage() async {
      Vib.decide();
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(
        pixelRatio: 3.0,
      );
      ByteData byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final _pngBytes = byteData.buffer.asUint8List();
      String uid = (userData.userID != '未登録') ? '\nID:@${userData.userID}' : '';
      await Share.file(
        '価値時間を共有',
        'goodRate.png',
        _pngBytes,
        'image/png',
        text: '${userData.userName}さんの価値時間が${userData.allGood}分に到達！$uid\n#ジカンリ',
      );
    }

    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        height: displaySize.width / 2.2 + displaySize.width / 10,
        width: displaySize.width,
        color:
            (theme.isDark) ? const Color(0XFF303030) : const Color(0XFFFAFAFA),
        child: Padding(
          padding: EdgeInsets.all(displaySize.width / 20),
          child: Container(
            height: displaySize.width / 2.2,
            width: displaySize.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: theme.themeColors),
              borderRadius:
                  BorderRadius.all(Radius.circular(displaySize.width / 12)),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 1,
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
                        fontSize: FontSize.xlarge, //12.5
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
                      onPressed: () async {
                        await _exportToImage();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: displaySize.width / 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: displaySize.width / 30,
                  ),
                  child: SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        userData.allGood.toString(),
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
          ),
        ),
      ),
    );
  }
}
