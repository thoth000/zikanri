//dart
import 'dart:typed_data';
import 'dart:ui' as ui;

//packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/config.dart';

class DayDataWidget extends StatelessWidget {
  DayDataWidget({this.itemList});
  final List itemList;

  @override
  Widget build(BuildContext context) {
    //controller
    final theme = Provider.of<ThemeNotifier>(context);
    //style
    Color color = theme.isDark ? theme.themeColors[0] : theme.themeColors[1];
    //key
    final GlobalKey _globalKey = GlobalKey();
    //function
    Future _exportToImage() async {
      Vib.decide();
      final RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      final ui.Image image = await boundary.toImage(
        pixelRatio: 3,
      );
      ByteData byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final _pngBytes = byteData.buffer.asUint8List();
      await Share.file(
        'ジカンリ',
        'image.png',
        _pngBytes,
        'image/png',
        text: '毎日の記録　#ジカンリ',
      );
    }
    //widget
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        height: displaySize.width / 2 + 20,
        width: displaySize.width,
        color:
            (theme.isDark) ? Colors.white : const Color(0XFFFAFAFA),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              height: displaySize.width / 2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                border: Border.all(
                  color: color,
                  width: 2,
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: displaySize.width / 10,
                    width: displaySize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: displaySize.width / 15,
                        ),
                        Text(
                          itemList[0], //日付
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
                                  child: const SizedBox(),
                                  onPressed: () async {
                                    await _exportToImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      valueItem(
                        '記録時間',
                        itemList[1].toString() + '分',
                      ),
                      valueItem(
                        '価値時間',
                        itemList[2].toString() + '分',
                      ),
                      valueItem(
                        '価値の割合',
                        itemList[3].toString() + '%',
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

  //記録時間・価値時間・価値の割合
  Widget valueItem(
    String title,
    String value,
  ) {
    return SizedBox(
      height: displaySize.width / 3.5,
      width: displaySize.width / 3.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
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
