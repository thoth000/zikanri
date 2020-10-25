//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/controller/user_detail_controller.dart';
import 'package:zikanri/controller/users_controller.dart';

class UserDetailPage extends StatelessWidget {
  UserDetailPage._();
  static Widget wrapped(
      {bool isDark,
      bool isFavorite,
      Map<String, dynamic> user,
      Color themeColor}) {
    return ChangeNotifierProvider(
      create: (_) => UserDetailController(
        isFavorite: isFavorite,
        user: user,
        themeColor: themeColor,
        isDark: isDark,
      ),
      child: UserDetailPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: _FavoriteAppBar(),
          body: ListView(
            children: [
              SizedBox(
                height: displaySize.width / 50,
              ),
              _ProfileDataWidget(),
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
              _MyThemesWidget(),
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
                child: _TodayDataWidget(),
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
                child: _AchiveDataWidget(),
              ),
              SizedBox(
                height: displaySize.width / 20,
              ),
            ],
          ),
        ),
        _PageCover(),
      ],
    );
  }
}

class _FavoriteAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final userDetailController = Provider.of<UserDetailController>(context);
    final user = userDetailController.user;
    final isFavorite = userDetailController.isFavorite;
    final themeColor = userDetailController.themeColor;
    final isDark = userDetailController.isDark;
    final userData = Provider.of<UserDataNotifier>(context);

    Future<void> changeIsFavorite(bool isFavorite) async {
      if (!isFavorite) {
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

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        '@' + user['userID'],
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
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
                  await changeIsFavorite(isFavorite);
                  userDetailController.switchFavorite();
                  await Future.delayed(Duration(milliseconds: 100));
                  print(isFavorite);
                },
              )
            : SizedBox(),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: themeColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _PageCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetailController = Provider.of<UserDetailController>(context);
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: userDetailController.hideWidth,
        height: userDetailController.hideHeight,
        curve: Curves.linear,
        decoration: BoxDecoration(
          color: userDetailController.hideColor.withOpacity(0.7),
          borderRadius:
              BorderRadius.circular(userDetailController.borderRadius),
        ),
      ),
    );
  }
}

class _ProfileDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetailController = Provider.of<UserDetailController>(context);
    final user = userDetailController.user;
    final themeColor = userDetailController.themeColor;
    final int iconNumber = user['myIcon'];
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

class _MyThemesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetailController = Provider.of<UserDetailController>(context);
    final colors = userDetailController.user['myColors'];
    return SizedBox(
      height: displaySize.width / 7 + 20,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          colors.length,
          (index) {
            bool isMyColor = colors[index];
            if (isMyColor) {
              return _ThemeChanger(index: index);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _ThemeChanger extends StatelessWidget {
  _ThemeChanger({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userDetailController =
        Provider.of<UserDetailController>(context, listen: false);
    return Container(
      height: displaySize.width / 7,
      width: displaySize.width / 7,
      margin: EdgeInsets.all(displaySize.width / 35),
      child: Stack(
        children: [
          Container(
            height: displaySize.width / 7,
            width: displaySize.width / 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: baseColors[index],
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width / 7,
            width: displaySize.width / 7,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const SizedBox(),
              onPressed: () {
                userDetailController.changeColor(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetailController = Provider.of<UserDetailController>(context);
    final user = userDetailController.user;
    final themeColor = userDetailController.themeColor;
    final int allTime = user['todayTime'];
    final int goodTime = user['todayGood'];
    final int percent = (allTime > 0) ? (goodTime * 100 ~/ allTime) : 0;
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

class _AchiveDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDetailController = Provider.of<UserDetailController>(context);
    final user = userDetailController.user;
    final themeColor = userDetailController.themeColor;
    final int time = user['totalMinute'];
    final int day = user['totalOpen'];
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
    final userDetailController = Provider.of<UserDetailController>(context);
    final themeColor = userDetailController.themeColor;
    return SizedBox(
      height: displaySize.width / 3.5,
      width: displaySize.width / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.bubble_chart,
            color: themeColor,
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
    final userDetailController = Provider.of<UserDetailController>(context);
    final themeColor = userDetailController.themeColor;
    return SizedBox(
      height: displaySize.width / 3.5,
      width: displaySize.width / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.bubble_chart,
            color: themeColor,
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
