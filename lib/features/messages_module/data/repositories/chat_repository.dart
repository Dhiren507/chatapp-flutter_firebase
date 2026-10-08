import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/core/utils/id_utils.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<UserModel?> fetchUserProfile(String uid) async {
    final userDocSnapshot = await _firebaseDb.collection(AppKeys.userCollectionKey).doc(uid).get();

    final userProfileJson = userDocSnapshot.data();
    if (userProfileJson == null) return null;

    return UserModel.fromJson(userProfileJson);
  }

  Future<void> markChatAsRead({required String chatId, required String currentUserId}) async {
    final chatRef = _firebaseDb.collection(AppKeys.chatCollectionKey).doc(chatId);

    await chatRef.update({
      'lastReadAt.$currentUserId': FieldValue.serverTimestamp(),
    });
  }

  Future<void> sendMessage({
    required String chatId,
    required UserModel sender,
    UserModel? receiver,
    required bool isGroupChat,
    required String text,
    required List<String> mediaUrls,
    required String mediaType,
  }) async {
    final newMessage = MessageModel(
      msgId: IdUtils.v4id,
      senderId: sender.uid,
      senderName: sender.name,
      senderProfileUrl: sender.photoUrl,
      messageText: text,
      mediaType: mediaType,
      mediaUrls: mediaUrls,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final newMessageJson = newMessage.toJson();

    final chatRef = _firebaseDb.collection(AppKeys.chatCollectionKey).doc(chatId);

    final chatSnapshot = await chatRef.get();

    if (!chatSnapshot.exists && !isGroupChat) {
      await chatRef.set({
        'chatId': chatId,
        'isGroup': isGroupChat,
        'members': [sender.uid, receiver?.uid],
        'messages': [newMessageJson],
        'lastReadAt': {
          if (sender.uid != null) sender.uid!: FieldValue.serverTimestamp(),
        },
        'profiles': [sender.toJson(), receiver?.toJson()],
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } else {
      await chatRef.update({
        'messages': FieldValue.arrayUnion([newMessageJson]),
        if (sender.uid != null) 'lastReadAt.${sender.uid}': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<UserChatModel?> fetchChatSession(String chatId) async {
    final docSnapshot = await _firebaseDb.collection(AppKeys.chatCollectionKey).doc(chatId).get();

    final chatData = docSnapshot.data();

    print('this is the current_chat data response : $chatData');

    if (chatData == null) {
      return null;
    }

    return UserChatModel.fromJson(chatData);
  }

  Future<List<UserChatModel>> fetchUserChatList(String userId) async {
    final chatsQuerySnapshot = await _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .where('members', arrayContains: userId)
        .get();

    final List<UserChatModel> chatList = [];

    for (final doc in chatsQuerySnapshot.docs) {
      final data = doc.data();
      chatList.add(UserChatModel.fromJson(data));
    }

    return chatList;
  }

  Stream<List<UserChatModel>> streamChatList(String userId) {
    return _firebaseDb
        .collection(AppKeys.chatCollectionKey)
        .where('members', arrayContains: userId)
        .snapshots()
        .map((querySnapshots) {
          return [
            for (var doc in querySnapshots.docs)
              if (doc.exists) UserChatModel.fromJson(doc.data()),
          ];
        });
  }

  Stream<UserChatModel?> streamCurrentChatSession(String chatId) {
    final snapshots = _firebaseDb.collection(AppKeys.chatCollectionKey).doc(chatId).snapshots();

    return snapshots.map((chatDocSnapshot) {
      if (!chatDocSnapshot.exists || chatDocSnapshot.data() == null) {
        return null;
      }
      return UserChatModel.fromJson(chatDocSnapshot.data()!);
    });
  }

  Future<void> createNewGroup(
    String groupId,
    String groupName,
    UserModel adminProfile,
    List<UserModel> members,
  ) async {
    final chatRef = _firebaseDb.collection(AppKeys.chatCollectionKey).doc(groupId);

    List<Map<String, dynamic>> membersJson = members.map((member) => member.toJson()).toList();

    List<String> memberUids = members.map((m) => m.uid!).toList();
    memberUids.add(adminProfile.uid!);

    await chatRef.set({
      'chatId': groupId,
      'groupName': groupName,
      'groupProfileUrl': 'https://cdn-icons-png.flaticon.com/256/8184/8184182.png',
      'isGroup': true,
      'messages': [],
      'members': memberUids,
      'admin': adminProfile.toJson(),
      'profiles': membersJson,
      'lastReadAt': {
        if (adminProfile.uid != null) adminProfile.uid!: FieldValue.serverTimestamp(),
      },
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
