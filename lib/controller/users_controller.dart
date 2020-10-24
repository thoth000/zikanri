//packages
import 'package:flutter/material.dart';
//my files
import 'package:zikanri/service/firebase_user_service.dart';

class UsersController with ChangeNotifier {
  List<Map<String, dynamic>> searchedUsers = [];
  //
  String inputText = '';
  //検索文字
  String searchWord = '';
  //検索中か
  bool isSearching = false;
  List<Map<String, dynamic>> favoriteUsers = [];
  //フォローを取得済みか
  bool isGetFavorite = false;
  List<Map<String, dynamic>> featuredUsers = [];
  //オススメを取得済みか
  bool isGetFeatured = false;

  void changeText(String text) {
    if (text.isEmpty) {
      inputText = '';
    } else {
      inputText = text;
    }
    notifyListeners();
  }

  Future<void> searchUsers(String text) async {
    searchWord = text;
    isSearching = true;
    notifyListeners();
    searchedUsers = await FirebaseUserService().getSearchedUsers(text);
    isSearching = false;
  }

  //お気に入り（フォロー）を取得
  Future<void> getFavoriteUsers(List<String> favoriteIds) async {
    isGetFavorite = false;
    notifyListeners();
    favoriteUsers =
        await FirebaseUserService().getfavoriteUserData(favoriteIds);
    isGetFavorite = true;
    notifyListeners();
  }

  //オススメのユーザーを取得
  Future<void> getFeaturedUsers() async {
    isGetFeatured = false;
    notifyListeners();
    featuredUsers = await FirebaseUserService().getFeaturedUserData();
    isGetFeatured = true;
    notifyListeners();
  }

  //お気に入りに追加
  void addFavoriteUser(Map<String, dynamic> newUser) {
    if (favoriteUsers.contains(newUser)) {
      return;
    }
    favoriteUsers.add(newUser);
    //並び替え
    favoriteUsers.sort((a, b) {
      return b['todayGood'] - a['todayGood'];
    });
    notifyListeners();
  }

  void removeFavoriteUser(Map<String, dynamic> user) {
    favoriteUsers.remove(user);
    notifyListeners();
  }

  void resetSearch() {
    searchWord = '';
    searchedUsers = [];
    notifyListeners();
  }
}
