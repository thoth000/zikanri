//packages
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //全ユーザーID取得
  Future<List<String>> getAllUserID() async {
    List<String> allID;
    final QuerySnapshot result = await db.collection('data/v2/users').get();
    allID = result.docs.map((doc) => doc.id).toList();
    return allID;
  }

  //オススメユーザ取得
  Future<List<Map>> getFeaturedUserData() async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final int getLimit = 5;
    List<Map<String, dynamic>> featuredUsers;
    //日付が今日のデータのみ抽出する
    final QuerySnapshot result = await db
        .collection('data/v2/users')
        .orderBy('todayGood', descending: true)
        .limit(getLimit)
        .get();
    featuredUsers = result.docs.map((doc) {
      final userData = doc.data();
      final Timestamp openTimestamp = userData['openDate'];
      if (openTimestamp.toDate() != today) {
        userData['todayTime'] = 0;
        userData['todayGood'] = 0;
      }
      return userData;
    }).toList();
    return featuredUsers;
  }

  //お気に入りユーザ取得
  Future<List<Map>> getfavoriteUserData(List<String> favoriteIds) async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    List<Map<String, dynamic>> users = [];
    //ユーザ情報取得
    await Future.forEach(favoriteIds, (userID) async {
      final result = await db.collection('data/v2/users').doc('$userID').get();
      if (result.exists) {
        final userData = result.data();
        //データ保存日時の判定
        final Timestamp openTimestamp = userData['openDate'];
        if (openTimestamp.toDate() != today) {
          userData['todayTime'] = 0;
          userData['todayGood'] = 0;
        }
        users.add(userData);
      }
    });
    //GoodTimeでソート
    users.sort((a, b) {
      return b['todayGood'].compareTo(a['todayGood']);
    });
    return users;
  }

  //検索したユーザーを返す
  //検索無効時には[]を返す
  //ユーザーが見つからない場合、userID='noUser'のMapを一つ返す
  Future<List<Map<String, dynamic>>> getSearchedUsers(String text) async {
    if (text.isEmpty) {
      return [];
    }
    //ID検索
    if (text[0] == '@' && text.length > 1) {
      final String userID = text.substring(1);
      final result = await db.collection('data/v2/users').doc('$userID').get();
      if (result.exists) {
        return [result.data()];
      }
      return [
        {
          'userID': 'noUser',
          'myIcon': 58715,
        }
      ];
    }
    //名前検索
    final result = await db
        .collection('data/v2/users')
        .orderBy('name')
        .startAt([text]).endAt([text + '\uf8ff']).get();
    final List<Map<String, dynamic>> searchedUsers =
        result.docs.map((doc) => doc.data()).toList();
    if (searchedUsers.isEmpty) {
      return [
        {
          'userID': 'noUser',
          'myIcon': 58715,
        }
      ];
    }
    return searchedUsers;
  }

  //DBにデータ保存
  Future<String> setData(String userID, Map<String, dynamic> data) async {
    try {
      await db.collection('data/v2/users').doc('$userID').set(data);
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }
}
