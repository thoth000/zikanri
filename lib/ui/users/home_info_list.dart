//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';
import 'package:zikanri/ui/users/user_detail.dart';

class HomeInfoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: displaySize.width / 50,
            ),
            Text(
              'フォローとランキング',
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            FavoriteRefleshButton(),
          ],
        ),
        FavoriteUserList(),
        Row(
          children: [
            SizedBox(
              width: displaySize.width / 50,
            ),
            Text(
              'オススメのユーザー　',
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            FeaturedRefleshButton(),
          ],
        ),
        FeaturedUserList(),
        SizedBox(
          height: displaySize.width / 10,
        ),
      ],
    );
  }
}

class FavoriteRefleshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final usersController = Provider.of<UsersController>(context);
    return IconButton(
      icon: Icon(Icons.refresh),
      iconSize: displaySize.width / 14,
      onPressed: (usersController.isGetFavorite)
          ? () async {
              await usersController.getFavoriteUsers(
                userData.favoriteIDs,
              );
            }
          : null,
    );
  }
}

class FeaturedRefleshButton extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    final usersController = Provider.of<UsersController>(context);
    return IconButton(
      icon: Icon(Icons.refresh),
      iconSize: displaySize.width / 14,
      onPressed: (usersController.isGetFeatured)
          ? () async {
              await usersController.getFeaturedUsers();
            }
          : null,
    );
  }
}

class FavoriteUserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final usersController = Provider.of<UsersController>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: displaySize.width / 50),
      child: Card(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: displaySize.width / 1.73,
          ),
          child: (usersController.isGetFavorite)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: usersController.favoriteUsers.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> user =
                        usersController.favoriteUsers[index];
                    return ListTile(
                      leading: Container(
                        height: displaySize.width / 8,
                        width: displaySize.width / 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: themeColor,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontSize: FontSize.small,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        user['name'],
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '@' + user['userID'],
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(user['todayGood'].toString() + '分'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailPage(
                              user: user,
                              isFavorite:
                                  userData.favoriteIDs.contains(user['userID']),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : SizedBox(
                  height: displaySize.width / 3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}

class FeaturedUserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersController = Provider.of<UsersController>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: displaySize.width / 50),
      child: Card(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: displaySize.width / 1.73,
          ),
          child: (usersController.isGetFeatured)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: usersController.featuredUsers.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> user =
                        usersController.featuredUsers[index];
                    final int iconNumber = user['myIcon'];
                    return ListTile(
                      leading: Container(
                        height: displaySize.width / 8,
                        width: displaySize.width / 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: themeColor,
                            width: 3,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            IconData(
                              iconNumber,
                              fontFamily: 'MaterialIcons',
                            ),
                            size: displaySize.width / 10,
                            color: themeColor,
                          ),
                        ),
                      ),
                      title: Text(
                        user['name'],
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '@' + user['userID'],
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(user['todayGood'].toString() + '分'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailPage(
                              user: user,
                              isFavorite:
                                  userData.favoriteIDs.contains(user['userID']),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : SizedBox(
                  height: displaySize.width / 3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
