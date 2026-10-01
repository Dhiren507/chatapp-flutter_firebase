import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<UserModel> fetchUserProfile(String uid) async {
    final querySnapshot = await _firebaseDb
        .collection(AppKeys.userCollectionKey)
        .doc(uid)
        .get();

    final userProfileJson = querySnapshot.data()!;

    print('this is the userProfile json : $userProfileJson');
    return UserModel.fromJson(userProfileJson);
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required bool isGroupChat,
    required String text,
  }) async {
    final newMessage = MessageModel(
      msgId: DateTime.now().microsecondsSinceEpoch.toString(),
      senderId: senderId,
      messageText: text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final newMessageJson = newMessage.toJson();

    final chatRef = _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .doc(chatId);

    final chatSnapshot = await chatRef.get();

    if (!chatSnapshot.exists) {
      final currentUserData = await _firebaseDb
          .collection(AppKeys.userCollectionKey)
          .doc(senderId)
          .get();

      final otherUserData = await _firebaseDb
          .collection(AppKeys.userCollectionKey)
          .doc(receiverId)
          .get();

      await chatRef.set({
        'chatId': chatId,
        'isGroup': isGroupChat,
        'members': [senderId, receiverId],
        'messages': [newMessageJson],
        'profiles': [currentUserData.data(), otherUserData.data()],
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } else {
      await chatRef.update({
        'messages': FieldValue.arrayUnion([newMessageJson]),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<UserChatModel?> fetchChatSession(String chatId) async {
    final docSnapshot = await _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .doc(chatId)
        .get();

    final chatData = docSnapshot.data();

    print('this is the current_chat data response : $chatData');

    if (chatData == null) {
      return null;
    }

    return UserChatModel.fromJson(chatData);
  }

  Future<List<UserChatModel>?> fetchChatList(String userId) async {
    final chatsQuerySnapshot = await _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .where('members', arrayContains: userId)
        .get();

    final chatListJson = chatsQuerySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    print('this is the response of fetching chatLists $chatListJson');

    if (chatListJson.isNotEmpty) {
      return chatListJson.map((chatJson) {
        return UserChatModel.fromJson(chatJson);
      }).toList();
    }

    return [];
  }
}
