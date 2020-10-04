import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';
import 'package:zikanri/ui/users/user_detail.dart';

class SearchUserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    final usersController = Provider.of<UsersController>(context);
    if (usersController.isSearching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        children: List.generate(usersController.searchedUsers.length, (index) {
          final Map<String, dynamic> user =
              usersController.searchedUsers[index];
          final int iconNumber = user['myIcon'];
          if (user['userID'] == 'noUser') {
            return Center(
              child: Text('ユーザーは見つかりませんでした。'),
            );
          }
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
                    isFavorite: userData.favoriteIDs.contains(user['userID']),
                  ),
                ),
              );
            },
          );
        }),
      );
    }
  }
}
