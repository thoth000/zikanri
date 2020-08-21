import 'package:cloud_firestore/cloud_firestore.dart';

class StoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadData(
      String uid, Map<String, dynamic> data, List categories) async {
    try {
      await firestore.collection('v1/users/$uid').doc('data').set(data);
      for (int i = 0; i < categories.length; i++) {
        final category = {
          'iconNumber': categories[i][0],
          'title': categories[i][1],
          'dataList': categories[i][2],
        };
        await firestore
            .collection('v1/users/$uid/data/category')
            .doc('$i')
            .set(category);
      }
      return 'success';
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  Future<Map> getUserData(String uid) async {
    final DocumentSnapshot result =
        await firestore.collection('v1/users/$uid').doc('data').get();
    final data = result.data();
    return data;
  }

  Future<Map> getUserCategory(String uid, int i) async {
    final DocumentSnapshot result = await firestore
        .collection('v1/users/$uid/data/category')
        .doc('$i')
        .get();
    final data = result.data();
    return data;
  }
}
