//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:zikanri/controller/main_page_controller.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/ui/record/date_change_dialog.dart';
import 'package:zikanri/ui/record/record_bottom_sheet.dart';
import 'package:zikanri/ui/short_cut/short_cut_sheet.dart';
import 'package:zikanri/ui/splash.dart';
import 'package:zikanri/config.dart';

class RButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final int pageindex = Provider.of<MainPageController>(context).currentIndex;
    Future<void> pagechange() async {
      await Future.delayed(
        Duration(
          milliseconds: 1500,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashPage(),
        ),
      );
    }

    //widget
    if (pageindex == 4 || pageindex == 3) {
      return Container();
    }
    return Container(
      height: displaySize.width / 5,
      width: displaySize.width / 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: theme.themeColors),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            color: Colors.black38,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              Icons.access_time,
              color: Colors.white,
              size: displaySize.width / 7,
            ),
          ),
          SizedBox(
            height: displaySize.width / 5,
            width: displaySize.width / 5,
            child: FlatButton(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              child: SizedBox(),
              onPressed: () async {
                var date = DateFormat('yyyy年MM月dd日').format(DateTime.now());
                if (date != Hive.box('userData').get('previousDate')) {
                  showDialog(
                    barrierDismissible: false,
                    context: (context),
                    builder: (context) => DateChangeDialog(),
                  );
                  await pagechange();
                } else {
                  Vib.select();
                  //record.reset();
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => RecordBottomSheet.wrapped(),
                  );
                }
              },
              onLongPress: () async {
                var date = DateFormat('yyyy年MM月dd日').format(DateTime.now());
                if (date != Hive.box('userData').get('previousDate')) {
                  showDialog(
                    barrierDismissible: false,
                    context: (context),
                    builder: (context) => DateChangeDialog(),
                  );
                  await pagechange();
                } else {
                  Vib.decide();
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => ShortCutSheet(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
