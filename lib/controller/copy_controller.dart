//packages
import 'package:flutter/material.dart';
//my files
import 'package:zikanri/service/firebase_back_up_service.dart';

class CopyController with ChangeNotifier {
  CopyController({this.nowID});
  String nowID = '未登録';
  String userID = '';
  String code = '';
  String checkUserID = 'ユーザーIDは6文字以上です。';
  bool isTapID = false;
  bool isTapCode = false;
  bool checkCode = false;

  void tapID() {
    isTapID = true;
    notifyListeners();
  }

  void tapCode() {
    isTapCode = true;
    notifyListeners();
  }

  void changeUserID(String text) {
    if (text.isEmpty) {
      userID = '';
    } else {
      userID = text;
    }
    if (userID.length >= 6) {
      if (userID == nowID) {
        checkUserID = '同じIDのデータは引き継げません。';
      } else {
        checkUserID = '';
      }
    } else {
      checkUserID = 'ユーザーIDは6文字以上です。';
    }
    notifyListeners();
  }

  void changeCode(String text) {
    if (text.isEmpty) {
      code = '';
    } else {
      code = text;
    }
    if (code.length == 6) {
      checkCode = true;
    } else {
      checkCode = false;
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> getCopyData() async {
    final Map<String, dynamic> user =
        await FirebaseBackUpService().getUserData(userID, code);
    return user;
  }
}
