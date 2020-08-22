//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

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

  Future<List<int>> getUserData(String uid) async {
    final DocumentSnapshot result =
        await firestore.collection('v1/users/$uid').doc('data').get();
    final data = result.data();
    final userDataBox = Hive.box('userData');
    await userDataBox.put('userValue',
        [data['allTime'], data['allGood'], data['allPer'], 0, 0, 0, 0, 0, 0]);
    await userDataBox.put('userName', data['name']);
    await userDataBox.put('totalPassedDays', data['passDay']);
    return [data['allTime'], data['passDay']];
  }

  Future<void> getUserCategory(String uid) async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('v1/users/$uid/data/category').get();
    List categories = [];
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      final Map data = querySnapshot.docs[i].data();
      List<int> listData = data['dataList'].cast<int>();
      final List category = [data['iconNumber'], data['title'], listData];
      categories.add(category);
    }
    final userDataBox = Hive.box('userData');
    await userDataBox.put('categories', categories);
  }
}
