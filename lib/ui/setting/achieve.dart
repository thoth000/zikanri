//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/achieve_controller.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';

class AchievePage extends StatelessWidget {
  AchievePage._();
  static Widget wrapped() {
    return ChangeNotifierProvider(
      create: (_) => AchieveController(),
      child: AchievePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: '実績',
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _RecordAchieveButton(),
              _DayAchieveButton(),
            ],
          ),
          _AchieveBody(),
        ],
      ),
    );
  }
}

class _RecordAchieveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final achieveController = Provider.of<AchieveController>(context);
    return Container(
      height: displaySize.width / 7.5,
      width: displaySize.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (achieveController.isRecord)
              ? (theme.isDark)
                  ? theme.themeColors[0]
                  : theme.themeColors[1]
              : Colors.grey,
          width: (achieveController.isRecord) ? 3 : 1,
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text('記録'),
        ),
        onPressed: () => achieveController.changeAchieve(true),
      ),
    );
  }
}

class _DayAchieveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final achieveController = Provider.of<AchieveController>(context);
    return Container(
      height: displaySize.width / 7.5,
      width: displaySize.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (!achieveController.isRecord)
              ? (theme.isDark)
                  ? theme.themeColors[0]
                  : theme.themeColors[1]
              : Colors.grey,
          width: (!achieveController.isRecord) ? 3 : 1,
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text('日数'),
        ),
        onPressed: () => achieveController.changeAchieve(false),
      ),
    );
  }
}

class _AchieveBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final achieveController = Provider.of<AchieveController>(context);
    return Expanded(
      child: (achieveController.isRecord)
          ? _AchieveMiniteWidget()
          : _AchieveDayWidget(),
    );
  }
}

class _AchieveMiniteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 35,
          ),
          Text(
            '記録時間',
            style: TextStyle(fontSize: FontSize.small),
          ),
          Text(
            userData.allTime.toString() + '分',
            style: TextStyle(
              fontSize: FontSize.xxlarge,
              fontWeight: FontWeight.w700,
            ),
          ),
          _AchieveMinuteList(),
        ],
      ),
    );
  }
}

class _AchieveMinuteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(achiveM.length, (index) {
        return _AchieveBox(
            index: index, check: userData.checkM[index], tail: '分');
      }),
    );
  }
}

class _AchieveDayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 35,
          ),
          Text(
            'ログイン日数',
            style: TextStyle(
              fontSize: FontSize.small,
            ),
          ),
          Text(
            userData.totalPassedDays.toString() + '日',
            style: TextStyle(
              fontSize: FontSize.xxlarge,
              fontWeight: FontWeight.w700,
            ),
          ),
          _AchieveDayList(),
        ],
      ),
    );
  }
}

class _AchieveDayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(achiveD.length, (index) {
        return _AchieveBox(
            index: index, check: userData.checkD[index], tail: '日');
      }),
    );
  }
}

class _AchieveBox extends StatelessWidget {
  _AchieveBox(
      {@required this.index, @required this.check, @required this.tail});
  final int index;
  final bool check;
  final String tail;
  @override
  Widget build(BuildContext context) {
    final int colorIndex = (tail == '分') ? index * 2 + 3 : index * 2 + 2;
    final String text = (tail == '分')
        ? achiveM[index].toString() + tail
        : achiveD[index].toString() + tail;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: displaySize.width / 20,
        vertical: displaySize.width / 35,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: displaySize.width / 4,
          width: displaySize.width / 1.2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _ColorBox(
                  index: colorIndex,
                  isGetTheme: check,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  _ColorBox({@required this.index, @required this.isGetTheme});
  final int index;
  final bool isGetTheme;
  @override
  Widget build(BuildContext context) {
    if (index == 2) {
      return Row(
        children: List.generate(3, (_index) {
          return Padding(
            padding: EdgeInsets.only(right: displaySize.width / 50),
            child: Container(
              height: displaySize.width / 7,
              width: displaySize.width / 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: baseColors[_index],
                ),
              ),
            ),
          );
        }),
      );
    }
    if (isGetTheme) {
      return Padding(
        padding: EdgeInsets.only(right: displaySize.width / 50),
        child: Container(
          height: displaySize.width / 7,
          width: displaySize.width / 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: baseColors[index],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(right: displaySize.width / 50),
      child: Tooltip(
        message: '未達成',
        child: Container(
          height: displaySize.width / 7,
          width: displaySize.width / 7,
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              "？",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: FontSize.large,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
