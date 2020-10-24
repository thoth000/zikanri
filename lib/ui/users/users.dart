//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/register/after_register.dart';
import 'package:zikanri/ui/users/search_field.dart';
import 'package:zikanri/ui/users/users_info_body.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    if (userData.userID == '未登録') {
      return AfterRegisterPage.wrapped();
    }
    return ListView(
      children: [
        SizedBox(
          height: displaySize.width / 20,
        ),
        SearchField(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        UsersInfoBody(),
      ],
    );
  }
}
