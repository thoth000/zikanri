//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/ui/category/category.dart';
import 'package:zikanri/controller/record_notifier.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/record/notification.dart';
import 'package:zikanri/config.dart';

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
                margin: const EdgeInsets.all(12.5),
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
                        const SizedBox(
                          height: 10,
                        ),
                        TitleFieldWidget(),
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

class TitleFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      cursorColor: color,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        fontSize: FontSize.small,
      ),
      decoration: InputDecoration(
        hintText: 'どんな活動？',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(displaySize.width / 30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(30)],
      textInputAction: TextInputAction.go,
      onChanged: (s) {
        Provider.of<RecordNotifier>(context, listen: false).changeTitle(s);
      },
    );
  }
}

class MinuteFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recordNotifier = Provider.of<RecordNotifier>(context, listen: false);
    final theme = Provider.of<ThemeNotifier>(context);
    final color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return TextField(
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
        hintText: '何分？',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(displaySize.width / 30),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      onChanged: (s) => recordNotifier.changeTime(s),
    );
  }
}

class ActivityInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controllers
    final record = Provider.of<RecordNotifier>(context);
    //style
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
              SizedBox(
                height: displaySize.width / 7,
                width: displaySize.width / 2.5,
                child: MinuteFieldWidget(),
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
