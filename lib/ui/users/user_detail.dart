//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';

class UserDetailPage extends StatelessWidget {
  UserDetailPage({
    @required this.user,
    @required this.isFavorite,
  });
  final Map<String, dynamic> user;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FavoriteAppBar(
        isFavorite: isFavorite,
        user: user,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: displaySize.width / 50,
          ),
          ProfileDataWidget(user: user),
          SizedBox(
            height: displaySize.width / 20,
          ),
          Row(
            children: [
              SizedBox(
                width: displaySize.width / 50,
              ),
              Text(
                '所持テーマ',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          MyThemesWidget(colors: user['myColors']),
          SizedBox(
            height: displaySize.width / 20,
          ),
          Row(
            children: [
              SizedBox(
                width: displaySize.width / 50,
              ),
              Text(
                '今日の記録',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: displaySize.width / 50,
          ),
          Center(
            child: TodayDataWidget(user: user),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
          Row(
            children: [
              SizedBox(
                width: displaySize.width / 50,
              ),
              Text(
                '実績',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: displaySize.width / 50,
          ),
          Center(
            child: AchiveDataWidget(user: user),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
        ],
      ),
    );
  }
}

class FavoriteAppBar extends StatefulWidget with PreferredSizeWidget {
  FavoriteAppBar({
    @required this.user,
    @required this.isFavorite,
  });
  final Map<String, dynamic> user;
  final bool isFavorite;
  @override
  _FavoriteAppBarState createState() => _FavoriteAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FavoriteAppBarState extends State<FavoriteAppBar> {
  Map<String, dynamic> user;
  bool isFavorite;
  @override
  void initState() {
    setState(() {
      user = widget.user;
      isFavorite = widget.isFavorite;
    });
    super.initState();
  }

  Future<void> changeIsFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite) {
      Provider.of<UsersController>(context, listen: false)
          .addFavoriteUser(user);
      await Provider.of<UserDataNotifier>(context, listen: false)
          .addFavoriteID(user['userID']);
    } else {
      Provider.of<UsersController>(context, listen: false)
          .removeFavoriteUser(user);
      await Provider.of<UserDataNotifier>(context, listen: false)
          .removeFavoriteID(user['userID']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        '@' + user['userID'],
        style: TextStyle(
          color: theme.isDark ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        (user['userID'] != userData.userID)
            ? IconButton(
                icon: Icon(
                  (isFavorite) ? Icons.star : Icons.star_border,
                ),
                color: (isFavorite) ? themeColor : Colors.grey,
                onPressed: () async {
                  await changeIsFavorite();
                },
              )
            : SizedBox(),
      ],
    );
  }
}

class ProfileDataWidget extends StatelessWidget {
  ProfileDataWidget({@required this.user});
  final Map<String, dynamic> user;
  @override
  Widget build(BuildContext context) {
    final int iconNumber = user['myIcon'];
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Row(
      children: [
        SizedBox(
          width: displaySize.width / 20,
        ),
        Container(
          height: displaySize.width / 5,
          width: displaySize.width / 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: themeColor,
              width: 5,
            ),
          ),
          child: Center(
            child: Icon(
              IconData(
                iconNumber,
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 6.5,
              color: themeColor,
            ),
          ),
        ),
        SizedBox(
          width: displaySize.width / 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user['name'],
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: FontSize.large,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '@' + user['userID'],
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyThemesWidget extends StatelessWidget {
  MyThemesWidget({@required this.colors});
  final List<dynamic> colors;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displaySize.width / 7 + 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(colors.length, (index) {
          bool isMyColor = colors[index];
          if (isMyColor) {
            return Padding(
              padding: const EdgeInsets.all(10),
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
          return const SizedBox();
        }),
      ),
    );
  }
}

class TodayDataWidget extends StatelessWidget {
  TodayDataWidget({@required this.user});
  final Map<String, dynamic> user;
  @override
  Widget build(BuildContext context) {
    final int allTime = user['todayTime'];
    final int goodTime = user['todayGood'];
    final int percent = (allTime > 0) ? (goodTime * 100 ~/ allTime) : 0;
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      height: displaySize.width / 2.7,
      width: displaySize.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(displaySize.width / 15),
        border: Border.all(
          color: themeColor,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _MonthlyDataItem(
            dataTitle: '記録時間',
            dataValue: allTime.toString() + '分',
          ),
          verticalLine(),
          _MonthlyDataItem(
            dataTitle: '価値時間',
            dataValue: goodTime.toString() + '分',
          ),
          verticalLine(),
          _MonthlyDataItem(
            dataTitle: '価値の割合',
            dataValue: percent.toString() + '%',
          ),
        ],
      ),
    );
  }

  Widget verticalLine() {
    return Container(
      height: displaySize.width / 3.5,
      width: 1,
      color: Colors.grey,
    );
  }
}

class AchiveDataWidget extends StatelessWidget {
  AchiveDataWidget({@required this.user});
  final Map<String, dynamic> user;
  @override
  Widget build(BuildContext context) {
    final int time = user['totalMinute'];
    final int day = user['totalOpen'];
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      height: displaySize.width / 2.7,
      width: displaySize.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(displaySize.width / 15),
        border: Border.all(
          color: themeColor,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TotalDataItem(
            dataTitle: 'ログイン日数',
            dataValue: day.toString() + '日',
          ),
          verticalLine(),
          _TotalDataItem(
            dataTitle: '総記録時間',
            dataValue: time.toString() + '分',
          ),
        ],
      ),
    );
  }

  Widget verticalLine() {
    return Container(
      height: displaySize.width / 3.5,
      width: 1,
      color: Colors.grey,
    );
  }
}

class _MonthlyDataItem extends StatelessWidget {
  _MonthlyDataItem({@required this.dataTitle, @required this.dataValue});
  final String dataTitle;
  final String dataValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displaySize.width / 3.5,
      width: displaySize.width / 3.5,
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

class _TotalDataItem extends StatelessWidget {
  _TotalDataItem({@required this.dataTitle, @required this.dataValue});
  final String dataTitle;
  final String dataValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displaySize.width / 3.5,
      width: displaySize.width / 2.5,
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
