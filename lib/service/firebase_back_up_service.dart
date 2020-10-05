import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBackUpService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> uploadData(
      String userID, Map<String, dynamic> data, List categories) async {
    for (int i = 0; i < categories.length; i++) {
      final Map<String, dynamic> categoryData = {
        'title': categories[i][1],
        'iconNumber': categories[i][0],
        'dataList': categories[i][2],
      };
      data['category$i'] = categoryData;
    }
    try {
      await db.collection('data/v2/users/$userID/backup').doc('data').set(data);
      return 'success';
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  Future<Map<String, dynamic>> getUserData(String userID, String text) async {
    final DocumentSnapshot result =
        await db.collection('data/v2/users/$userID/backup').doc('data').get();
    if (result.exists) {
      final Map<String, dynamic> data = result.data();
      final code = data['backUpCode'];
      if (code == text) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
