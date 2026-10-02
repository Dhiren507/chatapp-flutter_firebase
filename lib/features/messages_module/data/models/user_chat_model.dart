import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChatModel {
  final String? chatId;
  final List<String>? members;
  final List<UserModel>? profiles;
  final UserModel? admin;
  final String? groupName;
  final String? groupProfileUrl;
  final bool? isGroup;
  final List<MessageModel>? messages;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserChatModel({
    this.chatId,
    this.groupName,
    this.groupProfileUrl,
    this.admin,
    this.members,
    this.isGroup,
    this.profiles,
    this.messages,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'members': members,
      'admin': admin?.toJson(),
      'groupName': groupName,
      'groupProfileUrl': groupProfileUrl,
      'isGroup': isGroup,
      'messages': messages?.map((msg) => msg.toJson()).toList(),
      'profiles': profiles?.map((profile) => profile.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory UserChatModel.fromJson(Map<String, dynamic> json) {
    return UserChatModel(
      chatId: json['chatId'] ?? '',
      groupName: json['groupName'] ?? '',
      groupProfileUrl: json['groupProfileUrl'] ?? '',
      admin: json['admin'] != null
          ? UserModel.fromJson(Map<String, dynamic>.from(json['admin']))
          : null,
      members: json['members'] != null
          ? List<String>.from(json['members'])
          : [],
      profiles: (json['profiles'] as List?)
          ?.map((profile) =>
          UserModel.fromJson(Map<String, dynamic>.from(profile)))
          .toList() ??
          [],
      isGroup: json['isGroup'] ?? false,
      messages: (json['messages'] as List?)
          ?.map((msg) =>
          MessageModel.fromJson(Map<String, dynamic>.from(msg)))
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
  final String? senderProfileUrl;
  final String? senderName;
  final String? messageText;
  final List<String>? mediaUrls;
  final String? mediaType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel({
    required this.msgId,
    required this.senderId,
    required this.messageText,
    required this.senderName,
    required this.senderProfileUrl,
    this.mediaUrls,
    this.mediaType,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'msgId': msgId,
      'senderId': senderId,
      'senderProfileUrl': senderProfileUrl,
      'senderName': senderName,
      'messageText': messageText,
      'mediaUrls': mediaUrls,
      'mediaType': mediaType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      msgId: json['msgId'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderProfileUrl: json['senderProfileUrl'] ?? '',
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