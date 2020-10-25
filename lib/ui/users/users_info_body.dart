//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/users_controller.dart';
import 'package:zikanri/ui/users/home_info_list.dart';
import 'package:zikanri/ui/users/search_user_list.dart';

class UsersInfoBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersController usersController =
        Provider.of<UsersController>(context);
    if (usersController.searchWord.isEmpty) {
      return HomeInfoList();
    }
    return SearchUserList();
  }
}
