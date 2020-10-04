import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zikanri/service/firebase_user_service.dart';

class RegisterController with ChangeNotifier {
  RegisterController() {
    Future(() async {
      existID = await FirebaseUserService().getAllUserID();
      isLoadingID = false;
      notifyListeners();
    });
  }

  String userID = '';
  String message = '6文字以上のIDを設定してください';
  List<String> existID;
  bool isLoadingID = true;
  bool isCanRegister = false;
  bool isTap = false;

  void onTap() {
    isTap = true;
    notifyListeners();
  }

  void changeID(String text) {
    if (text.isEmpty) {
      userID = '';
    } else {
      userID = text;
    }
    notifyListeners();
    if (userID.length < 6) {
      isCanRegister = false;
      message = '6文字以上のIDを設定してください';
    } else if (existID.contains(userID)) {
      isCanRegister = false;
      message = 'そのIDは既に使われています。';
    } else {
      isCanRegister = true;
      message = '問題ありません。';
    }
    notifyListeners();
  }

  Future<String> register() async {
    final now = DateTime.now();
    final Timestamp today =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    final String backUpCode = randomString(6);
    final Map<String, dynamic> uploadData = {
      'userID': userID,
      'backUpCode': backUpCode,
      'name': 'Zikanriゲスト',
      'myIcon': Icons.access_time.codePoint,
      'myColors': [
        true,
        true,
        true,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ],
      'openDate': today,
      'todayTime': 0,
      'todayGood': 0,
      'totalOpen': 1,
      'totalMinute': 0,
    };
    try {
      await FirebaseUserService().setData(userID, uploadData);
      await Hive.box('userData').put('userID', userID);
      await Hive.box('userData').put('backUpCode', backUpCode);
      List<String> favoriteIds = [userID];
      await Hive.box('userData').put('favoriteIDs', favoriteIds);
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> afterRegister(Map<String, dynamic> data) async {
    final now = DateTime.now();
    final Timestamp today =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    final String backUpCode = randomString(6);
    //エラー対策の前準備
    final int myIcon = data['myIcon'];
    final List<bool> myColors = data['myColors'];
    final int todayTime = data['todayTime'];
    final int todayGood = data['todayGood'];
    final int totalOpen = data['totalOpen'];
    final int totalMinute = data['totalMinute'];
    final Map<String, dynamic> uploadData = {
      'userID': userID,
      'backUpCode': backUpCode,
      'name': data['name'],
      'myIcon': myIcon,
      'myColors': myColors,
      'openDate': today,
      'todayTime': todayTime,
      'todayGood': todayGood,
      'totalOpen': totalOpen,
      'totalMinute': totalMinute,
    };
    try {
      await FirebaseUserService().setData(userID, uploadData);
      await Hive.box('userData').put('userID', userID);
      await Hive.box('userData').put('backUpCode', backUpCode);
      await Hive.box('userData').put('backUpCanDate', DateTime.now());
      List<String> favoriteIds = [userID];
      await Hive.box('userData').put('favoriteIDs', favoriteIds);
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }

  String randomString(int len) {
    var r = Random();
    const _chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
    final String randomString =
        List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    return randomString;
  }
}
