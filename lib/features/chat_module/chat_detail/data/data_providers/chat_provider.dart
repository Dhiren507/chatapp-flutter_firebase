import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchUserProfileByUid(String uid) async {
    final querySnapshot = await _firebaseDb
        .collection(AppKeys.userCollectionKey)
        .doc(uid)
        .get();

    return querySnapshot.data()!;
  }

  // Future<Map<String,dynamic>> fetchChatDetailByUid(String uid) async {
  //
  // }


}
