//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/activity_notifier.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/bottom_sheet_bar.dart';

class FinishActivitySheet extends StatelessWidget {
  const FinishActivitySheet._({Key key, this.index}) : super(key: key);

  static Widget wrapped(int index) {
    return ChangeNotifierProvider(
      create: (_) => ActivityNotifier(),
      child: FinishActivitySheet._(index: index),
    );
  }

  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          BottomSheetBar(),
          Text(
            '活動の記録',
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          SizedBox(
            height: displaySize.width / 1.35,
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                _ActivityInfo(index: index),
                SizedBox(
                  height: displaySize.width / 30,
                ),
                _SelectValueBlocList(),
                SizedBox(
                  height: displaySize.width / 15,
                ),
                Center(
                  child: _RecordActivityButton(
                    index: index,
                  ),
                ),
                SizedBox(
                  height: displaySize.width / 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityInfo extends StatelessWidget {
  _ActivityInfo({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    final activityController = Provider.of<ActivityNotifier>(context);
    //value
    final activity = activityController.isRecording
        ? ['', '', '', 0, 0, 0]
        : userData.activities[index];
    String title = activity[2];
    int categoryIndex = activity[3];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "活動の情報",
          style: TextStyle(
            fontSize: FontSize.small,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: displaySize.width / 50,
            ),
            Icon(
              IconData(
                userData.categories[categoryIndex][0],
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 6,
            ),
            SizedBox(
              width: displaySize.width / 50,
            ),
            Flexible(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: FontSize.large,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SelectValueBlocList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _SelectValueBloc(
          boolean: false,
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
        _SelectValueBloc(
          boolean: true,
        ),
      ],
    );
  }
}

class _SelectValueBloc extends StatelessWidget {
  _SelectValueBloc({this.boolean});
  final bool boolean;
  @override
  Widget build(BuildContext context) {
    //controllers
    final theme = Provider.of<ThemeNotifier>(context);
    final activityController = Provider.of<ActivityNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //widget
    return Container(
      height: displaySize.width / 7,
      width: displaySize.width / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (activityController.isGood == boolean) ? color : Colors.grey,
          width: (activityController.isGood == boolean) ? 3 : 1,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              (boolean) ? Icons.trending_up : Icons.trending_flat,
              color:
                  (activityController.isGood == boolean) ? color : Colors.grey,
              size: displaySize.width / 10,
            ),
          ),
          SizedBox(
            height: displaySize.width / 7,
            width: displaySize.width / 7,
            child: FlatButton(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                Vib.select();
                activityController.changeValue(boolean);
              },
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordActivityButton extends StatelessWidget {
  _RecordActivityButton({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final activityController = Provider.of<ActivityNotifier>(context);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //value
    final activity = activityController.isRecording
        ? ['', '', '', 0, 0, 0]
        : userData.activities[index];
    String title = activity[2];
    int categoryIndex = activity[3];
    int time = activity[5];
    return Container(
      height: displaySize.width / 6.5,
      width: displaySize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: color,
          width: 3,
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        child: Text(
          '記録する',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () async {
          Vib.decide();
          activityController.startRecord();
          await userData.recordDone(
            [
              categoryIndex,
              title,
              time,
              activityController.isGood,
            ],
          );
          await userData.finishActivity(index);
          Navigator.pop(context);
        },
      ),
    );
  }
}
