import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/chat_module/data/data_providers/chat_provider.dart';
import 'package:chatapp_firebase/features/chat_module/data/models/user_chat_model.dart';

class ChatRepository {
  final ChatDataProvider _chatProvider;

  ChatRepository({ChatDataProvider? provider})
    : _chatProvider = provider ?? ChatDataProvider();

  Future<UserModel> fetchUserProfile(String uid) async {
    final userProfileJson = await _chatProvider.fetchUserProfileByUid(uid);

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

    await _chatProvider.createDocOrSendMessage(
      chatId,
      senderId,
      receiverId,
      isGroupChat,
      newMessageJson,
    );
  }

  Future<UserChatModel?> fetchChatSession(String chatId) async {
    final chatData = await _chatProvider.fetchChatData(chatId);

    print('this is the current_chat data response : $chatData');

    if (chatData == null) {
      return null;
    }

    return UserChatModel.fromJson(chatData);
  }

  Future<List<UserChatModel>?> fetchChatList(String userId) async {
    final chatListJson = await _chatProvider.fetchChatList(userId);

    print('this is the response of fetching chatLists $chatListJson');

    if (chatListJson != null) {
      return chatListJson.map((chatJson) {
        return UserChatModel.fromJson(chatJson);
      }).toList();
    }

    return [];
  }
}
