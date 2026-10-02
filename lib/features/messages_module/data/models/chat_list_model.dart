import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';

class ChatListModel {
  final String? chatId;
  final UserModel? otherUserProfile;
  final String? groupName;
  final String? groupProfile;
  final bool? isGroup;
  final MessageModel? lastMessage;
  final DateTime? lastMessageTimestamp;

  ChatListModel({
    this.chatId,
    this.otherUserProfile,
    this.groupName,
    this.isGroup = false,
    this.groupProfile,
    this.lastMessage,
    this.lastMessageTimestamp,
  });
}
