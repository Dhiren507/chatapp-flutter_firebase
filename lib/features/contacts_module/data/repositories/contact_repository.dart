import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllContacts() async {
    final querySnapshot = await _firebaseDb.collection('users').get();

    print(querySnapshot.docs.first);

    final contactListJson = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    print('this is list of json : $contactListJson');

    return contactListJson.map((contactJson) {
      return UserModel.fromJson(contactJson);
    }).toList();
  }
}
