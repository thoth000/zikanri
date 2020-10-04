//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:zikanri/controller/main_page_controller.dart';

//my files
import 'package:zikanri/ui/category/category.dart';
import 'package:zikanri/controller/record_notifier.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/splash.dart';
import 'package:zikanri/config.dart';

void notification(String s, int length) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'Channel ID',
    'Channel title',
    'channel body',
    priority: Priority.Max,
    importance: Importance.Max,
    ticker: 'test',
  );
  IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

  NotificationDetails notificationDetails =
      NotificationDetails(androidNotificationDetails, iosNotificationDetails);
  await flutterNotification.show(
    0,
    '活動',
    (length + 1).toString() + '件目: ' + s,
    notificationDetails,
  );
}

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

class DateChangeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('日付が変わっています'),
      content: const Text('自動的にタイトル画面に戻ります'),
    );
  }
}

class RecordBottomSheet extends StatelessWidget {
  const RecordBottomSheet._({Key key}) : super(key: key);
  static Widget wrapped() {
    return ChangeNotifierProvider(
      create: (_) => RecordNotifier(),
      child: RecordBottomSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);

    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];

    final BoxDecoration _decorationStyle = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    );
    final TextStyle _headlineStyle = TextStyle(
      fontSize: FontSize.small,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 5,
                width: 70,
                margin: EdgeInsets.all(12.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey,
                ),
              ),
              Text(
                '記録の追加',
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SelectModeWidget(),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'タイトル',
                          style: _headlineStyle,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: _decorationStyle,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: color,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                              fontSize: FontSize.small,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'どんな活動？',
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            textInputAction: TextInputAction.go,
                            onChanged: (s) {
                              Provider.of<RecordNotifier>(context,
                                      listen: false)
                                  .changeTitle(s);
                            },
                          ),
                        ),
                      ],
                    ),
                    ActivityInfoWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SaveActivityButton(),
                    ),
                    const Divider(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'カテゴリー',
                          style: _headlineStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SelectCategoryWidget(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectModeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controllers
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //widget
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: displaySize.width / 7.5,
          width: displaySize.width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (record.isRecord) ? color : Colors.grey,
              width: (record.isRecord) ? 3 : 1,
            ),
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('記録する'),
            ),
            onPressed: record.recordMode,
          ),
        ),
        Container(
          height: displaySize.width / 7.5,
          width: displaySize.width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (!record.isRecord) ? color : Colors.grey,
              width: (!record.isRecord) ? 3 : 1,
            ),
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('開始する'),
            ),
            onPressed: record.startMode,
          ),
        ),
      ],
    );
  }
}

class ActivityInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controllers
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    final BoxDecoration _decorationStyle = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    );
    final TextStyle _headlineStyle = TextStyle(
      fontSize: FontSize.small,
      fontWeight: FontWeight.w700,
    );
    //Widget
    if (record.isRecord) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Text(
                '時間(分)',
                style: _headlineStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: displaySize.width / 7,
                width: displaySize.width / 2.5,
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: _decorationStyle,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: color,
                  style: TextStyle(
                    fontSize: FontSize.small,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '何分？',
                  ),
                  onChanged: (s) => record.changeTime(s),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Text(
                '時間の価値',
                style: _headlineStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: displaySize.width / 2.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ValueSelectBloc(
                            boolean: false,
                          ),
                          SizedBox(
                            width: displaySize.width / 50,
                          ),
                          ValueSelectBloc(
                            boolean: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

class ValueSelectBloc extends StatelessWidget {
  ValueSelectBloc({this.boolean});
  final bool boolean;
  @override
  Widget build(BuildContext context) {
    //controllers
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //widget
    return Container(
      height: displaySize.width / 7,
      width: displaySize.width / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (record.isGood == boolean) ? color : Colors.grey,
          width: (record.isGood == boolean) ? 3 : 1,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              (boolean) ? Icons.trending_up : Icons.trending_flat,
              color: (record.isGood == boolean) ? color : Colors.grey,
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
              onPressed: () => record.changeValue(boolean),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class SaveActivityButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controllers
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);

    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];

    return Container(
      height: displaySize.width / 6.5,
      width: displaySize.width / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: record.check()
              ? color.withOpacity(0.5) //opacityを無効時につける
              : color,
          width: 3,
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        onLongPress: record.check()
            ? null
            : () async {
                if (record.isRecord) {
                  Vib.shortCut();
                  userData.addShortCuts(
                    [
                      record.categoryIndex,
                      record.title,
                      record.time,
                      record.isGood,
                      userData.keynum,
                      true,
                    ],
                  );
                  userData.recordDone(
                    [
                      record.categoryIndex,
                      record.title,
                      record.time,
                      record.isGood,
                    ],
                  );
                  Navigator.pop(context);
                } else {
                  notification(
                    record.title,
                    userData.activities.length,
                  );
                  Vib.shortCut();
                  userData.addShortCuts(
                    [
                      record.categoryIndex,
                      record.title,
                      0,
                      false,
                      userData.keynum,
                      false,
                    ],
                  );
                  userData.addActivity(
                    DateTime.now(),
                    record.title,
                    record.categoryIndex,
                  );
                  Navigator.pop(context);
                }
              },
        onPressed: record.check()
            ? null
            : () async {
                if (record.isRecord) {
                  //記録モード
                  Vib.decide();
                  userData.recordDone(
                    [
                      record.categoryIndex,
                      record.title,
                      record.time,
                      record.isGood,
                    ],
                  );
                  //record.reset();
                  Navigator.pop(context);
                } else {
                  notification(
                    record.title,
                    userData.activities.length,
                  );
                  //開始モード
                  Vib.decide();
                  userData.addActivity(
                    DateTime.now(),
                    record.title,
                    record.categoryIndex,
                  );
                  Navigator.pop(context);
                }
              },
        child: Text(
          (record.isRecord) ? '記録する' : '開始する',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class SelectCategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controller
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //widget
    return Wrap(
      children: <Widget>[
        for (int i = 0; i < userData.categories.length; i++)
          (userData.categoryView[i])
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: displaySize.width / 6.5,
                        width: displaySize.width / 6.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: (record.categoryIndex == i)
                                ? color
                                : Colors.grey,
                            width: (record.categoryIndex == i) ? 3 : 1,
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Icon(
                                IconData(
                                  userData.categories[i][0],
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: (theme.isDark)
                                    ? Colors.white
                                    : Colors.black,
                                size: displaySize.width / 15,
                              ),
                            ),
                            SizedBox(
                              height: displaySize.width / 6.5,
                              width: displaySize.width / 6.5,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: const SizedBox(),
                                color: Colors.transparent,
                                onPressed: () => record.changeCategoryIndex(i),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: displaySize.width / 5.1,
                        child: Text(
                          userData.categories[i][1],
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: FontSize.xxsmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: displaySize.width / 5,
              ),
              Container(
                height: displaySize.width / 6.5,
                width: displaySize.width / 6.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.more_horiz,
                        color: (theme.isDark) ? Colors.white : Colors.black,
                        size: displaySize.width / 15,
                      ),
                    ),
                    SizedBox(
                      height: displaySize.width / 6.5,
                      width: displaySize.width / 6.5,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(),
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ShortCutSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 5,
              width: 50,
              margin: EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey,
              ),
            ),
            Text(
              '記録の追加',
              style: TextStyle(
                fontSize: FontSize.large,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'ショートカットモード',
              style: TextStyle(
                fontSize: FontSize.small,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: displaySize.width / 6.5,
                width: displaySize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShortCutsEditPage(),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'ショートカットの編集をする',
                      style: TextStyle(fontSize: FontSize.small),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 1,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  for (var itemList in userData.shortCuts)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: displaySize.width / 6.5,
                          width: displaySize.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () async {
                              if (itemList[5]) {
                                userData.recordDone(itemList);
                              } else {
                                notification(
                                    itemList[1], userData.activities.length);
                                userData.addActivity(
                                    DateTime.now(), itemList[1], itemList[0]);
                              }
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: displaySize.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          IconData(
                                            userData.categories[itemList[0]][0],
                                            fontFamily: 'MaterialIcons',
                                          ),
                                          color: (itemList[3])
                                              ? (theme.isDark)
                                                  ? theme.themeColors[0]
                                                  : theme.themeColors[1]
                                              : Colors.grey,
                                          size: displaySize.width / 10,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            itemList[1],
                                            overflow: TextOverflow.fade,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: FontSize.xsmall,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      (itemList[5]) ? '記録' : '開始',
                                      style: TextStyle(
                                        fontSize: FontSize.small,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShortCutsEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    void deleteCheck(int index) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('削除'),
          content: const Text('ショートカットを削除しますか？'),
          actions: <Widget>[
            FlatButton(
              child: const Text('いいえ'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('はい'),
              onPressed: () {
                userData.deleteShortCut(index);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'ショートカットの編集',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ReorderableListView(
              children: [
                for (int i = 0; i < userData.shortCuts.length; i++)
                  SizedBox(
                    key: Key(userData.shortCuts[i][4].toString()),
                    width: displaySize.width,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Card(
                            child: ListTile(
                              leading: Icon(
                                IconData(
                                  userData.categories[userData.shortCuts[i][0]]
                                      [0],
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: (userData.shortCuts[i][3])
                                    ? (theme.isDark)
                                        ? theme.themeColors[0]
                                        : theme.themeColors[1]
                                    : Colors.grey,
                                size: displaySize.width / 12,
                              ),
                              title: Text(
                                userData.shortCuts[i][1],
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  (userData.shortCuts[i][5]) ? '記録' : '開始',
                                  style: TextStyle(
                                    fontSize: FontSize.small,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                            ),
                            iconSize: displaySize.width / 12,
                            color: theme.isDark
                                ? theme.themeColors[0]
                                : theme.themeColors[1],
                            onPressed: () => deleteCheck(i)),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
              ],
              onReorder: (oldIndex, newIndex) =>
                  userData.sort(oldIndex, newIndex),
            ),
          ),
        ],
      ),
    );
  }
}
