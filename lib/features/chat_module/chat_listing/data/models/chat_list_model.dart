import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/chat_module/data/models/user_chat_model.dart';

class ChatListModel {
  final String? chatId;
  final UserModel? otherUserProfile;
  final MessageModel? lastMessage;
  final DateTime? lastMessageTimestamp;

  ChatListModel({
    this.chatId,
    this.otherUserProfile,
    this.lastMessage,
    this.lastMessageTimestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'otherUserProfile': otherUserProfile?.toJson(),
      'lastMessage': lastMessage?.toJson(),
      'lastMessageTimestamp': lastMessageTimestamp,
    };
  }

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      chatId: json['chatId'],
      otherUserProfile: json['otherUserProfile'] != null
          ? UserModel.fromJson(json['otherUserProfile'])
          : null,
      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson(json['lastMessage'])
          : null,
      lastMessageTimestamp: json['lastMessageTimestamp'] != null
          ? DateTime.tryParse(json['lastMessageTimestamp'].toString())
          : null,
    );
  }
}
