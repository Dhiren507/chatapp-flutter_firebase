import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDataProvider {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchUserProfileByUid(String uid) async {
    final querySnapshot = await _firebaseDb
        .collection(AppKeys.userCollectionKey)
        .doc(uid)
        .get();

    return querySnapshot.data()!;
  }

  Future<void> createDocOrSendMessage(
    String chatId,
    String senderId,
    String receiverId,
    bool isGroupChat,
    Map<String, dynamic> msgJsonData,
  ) async {
    final chatRef = _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .doc(chatId);

    final chatSnapshot = await chatRef.get();

    if (!chatSnapshot.exists) {
      final currentUserData = await fetchUserProfileByUid(senderId);

      final otherUserData = await fetchUserProfileByUid(receiverId);

      await chatRef.set({
        'chatId': chatId,
        'isGroup': isGroupChat,
        'members': [senderId, receiverId],
        'messages': [msgJsonData],
        'profiles' : [currentUserData, otherUserData],
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });

    } else {
      await chatRef.update({
        'messages': FieldValue.arrayUnion([msgJsonData]),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<Map<String, dynamic>?> fetchChatData(String chatId) async {
    final docSnapshot = await _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .doc(chatId)
        .get();

    return docSnapshot.data();
  }

  Future<List<Map<String, dynamic>>?> fetchChatList(String uid) async {
    final chatsQuerySnapshot = await _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .where('members', arrayContains: uid)
        .get();

    return chatsQuerySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}
