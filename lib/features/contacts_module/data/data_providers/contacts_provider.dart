import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsProvider {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAllContactsJson() async {
    final querySnapshot = await _firebaseDb.collection('users').get();

    print(querySnapshot.docs.first);

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return data;
    }).toList();
  }
}
