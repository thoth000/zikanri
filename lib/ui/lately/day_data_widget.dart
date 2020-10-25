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
import 'package:zikanri/controller/user_data_notifier.dart';

class DayDataWidget extends StatelessWidget {
  DayDataWidget({this.itemList});
  final List itemList;

  @override
  Widget build(BuildContext context) {
    //controller
    final theme = Provider.of<ThemeNotifier>(context);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
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
      String uid = Provider.of<UserDataNotifier>(context).userID;
      uid = (uid != '未登録') ? '\nID:@$uid' : '';
      await Share.file(
        '毎日の記録を共有',
        'image.png',
        _pngBytes,
        'image/png',
        text: '毎日の記録$uid\n#ジカンリ',
      );
    }

    //widget
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        height: displaySize.width / 2 + displaySize.width/17,
        width: displaySize.width,
        color:
            (theme.isDark) ? const Color(0XFF303030) : const Color(0XFFFAFAFA),
        child: Padding(
          padding: EdgeInsets.all(displaySize.width/35),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              height: displaySize.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
                  _DataList(itemList: itemList),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DataList extends StatelessWidget {
  _DataList({@required this.itemList});
  final List itemList;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _DataWidget(
          dataTitle: '記録時間',
          dataValue: itemList[1].toString() + '分',
        ),
        _DataWidget(
          dataTitle: '価値時間',
          dataValue: itemList[2].toString() + '分',
        ),
        _DataWidget(
          dataTitle: '価値の割合',
          dataValue: itemList[3].toString() + '%',
        ),
      ],
    );
  }
}

class _DataWidget extends StatelessWidget {
  _DataWidget({@required this.dataTitle, @required this.dataValue});
  final String dataTitle;
  final String dataValue;
  @override
  Widget build(BuildContext context) {
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
            dataValue,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            dataTitle,
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
