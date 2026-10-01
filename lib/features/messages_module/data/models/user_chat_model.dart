import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChatModel {
  final String? chatId;
  final List<String>? members;
  final List<UserModel>? profiles;
  final bool? isGroup;
  final List<MessageModel>? messages;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserChatModel({
    required this.chatId,
    required this.members,
    required this.isGroup,
    required this.profiles,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'members': members,
      'isGroup': isGroup,
      'messages': messages?.map((msg) => msg.toJson()).toList(),
      'profiles': profiles?.map((profile) => profile.toJson()).toList(),
      'createdAt': createdAt,
    };
  }

  factory UserChatModel.fromJson(Map<String, dynamic> json) {
    return UserChatModel(
      chatId: json['chatId'] ?? '',
      members: List<String>.from(json['members'] ?? []),
      profiles:
          (json['profiles'] as List?)
              ?.map(
                (profile) =>
                    UserModel.fromJson(Map<String, dynamic>.from(profile)),
              )
              .toList() ??
          [],
      isGroup: json['isGroup'] ?? false,
      messages:
          (json['messages'] as List?)
              ?.map(
                (msg) => MessageModel.fromJson(Map<String, dynamic>.from(msg)),
              )
              .toList() ??
          [],
      createdAt: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : null,
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }
}

class MessageModel {
  final String? msgId;
  final String? senderId;
  final String? messageText;
  final List<String>? mediaUrls;
  final String? mediaType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel({
    required this.msgId,
    required this.senderId,
    required this.messageText,
    this.mediaUrls,
    this.mediaType,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'msgId': msgId,
      'senderId': senderId,
      'messageText': messageText,
      'mediaUrl': mediaUrls,
      'mediaType': mediaType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      msgId: json['msgId'] ?? '',
      senderId: json['senderId'] ?? '',
      messageText: json['messageText'] ?? '',
      mediaUrls: json['mediaUrls'] != null
          ? List<String>.from(json['mediaUrls'])
          : null,
      mediaType: json['mediaType'],
      createdAt: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : null,
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }
}
