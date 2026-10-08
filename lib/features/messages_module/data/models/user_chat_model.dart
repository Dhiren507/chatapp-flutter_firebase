import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChatModel {
  String? chatId;
  List<String>? members;
  List<UserModel>? profiles;
  UserModel? admin;
  String? groupName;
  String? groupProfileUrl;
  bool? isGroup;
  List<MessageModel>? messages;
  Map<String, int>? unreadCounts;
  Map<String, DateTime>? lastReadAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserChatModel({
    this.chatId,
    this.members,
    this.profiles,
    this.admin,
    this.groupName,
    this.groupProfileUrl,
    this.isGroup,
    this.messages,
    this.unreadCounts,
    this.lastReadAt,
    this.createdAt,
    this.updatedAt,
  });

  UserChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    if (json['members'] != null) {
      members = <String>[];
      json['members'].forEach((v) {
        members!.add(v.toString());
      });
    }
    if (json['profiles'] != null) {
      profiles = <UserModel>[];
      json['profiles'].forEach((v) {
        profiles!.add(UserModel.fromJson(Map<String, dynamic>.from(v)));
      });
    }
    admin = json['admin'] != null
        ? UserModel.fromJson(Map<String, dynamic>.from(json['admin']))
        : null;
    groupName = json['groupName'];
    groupProfileUrl = json['groupProfileUrl'];
    isGroup = json['isGroup'];
    if (json['messages'] != null) {
      messages = <MessageModel>[];
      json['messages'].forEach((v) {
        messages!.add(MessageModel.fromJson(Map<String, dynamic>.from(v)));
      });
    }
    if (json['unreadCounts'] != null) {
      unreadCounts = Map<String, int>.from(json['unreadCounts']);
    }
    if (json['lastReadAt'] != null) {
      lastReadAt = <String, DateTime>{};
      (json['lastReadAt'] as Map).forEach((key, value) {
        if (value is Timestamp) {
          lastReadAt![key.toString()] = value.toDate();
        } else if (value != null) {
          final parsed = DateTime.tryParse(value.toString());
          if (parsed != null) lastReadAt![key.toString()] = parsed;
        }
      });
    }
    createdAt = json['created_at'] != null
        ? (json['created_at'] is Timestamp
            ? (json['created_at'] as Timestamp).toDate()
            : DateTime.tryParse(json['created_at'].toString()))
        : null;
    updatedAt = json['updated_at'] != null
        ? (json['updated_at'] is Timestamp
            ? (json['updated_at'] as Timestamp).toDate()
            : DateTime.tryParse(json['updated_at'].toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['members'] = members;
    if (profiles != null) {
      data['profiles'] = profiles!.map((v) => v.toJson()).toList();
    }
    if (admin != null) {
      data['admin'] = admin!.toJson();
    }
    data['groupName'] = groupName;
    data['groupProfileUrl'] = groupProfileUrl;
    data['isGroup'] = isGroup;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['unreadCounts'] = unreadCounts;
    if (lastReadAt != null) {
      data['lastReadAt'] = lastReadAt;
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // --- Domain Utility Getters & Helpers ---

  int getUnreadCountForUser(String currentUserId) {
    if (messages == null || messages!.isEmpty) return 0;

    final userLastRead = lastReadAt?[currentUserId];

    if (userLastRead != null) {
      return messages!.where((m) {
        return m.senderId != currentUserId &&
            m.createdAt != null &&
            m.createdAt!.isAfter(userLastRead);
      }).length;
    }

    if (unreadCounts != null && unreadCounts!.containsKey(currentUserId)) {
      return unreadCounts![currentUserId] ?? 0;
    }

    return messages!.where((m) => m.senderId != currentUserId).length;
  }

  MessageModel? get lastMessage => messages?.lastOrNull;

  UserModel? getOtherUserProfile(String currentUserId) {
    if (profiles == null || profiles!.isEmpty) return null;

    return profiles!.cast<UserModel?>().firstWhere(
      (profile) => profile?.uid != currentUserId,
      orElse: () => null,
    );
  }
}

class MessageModel {
  String? msgId;
  String? senderId;
  String? senderProfileUrl;
  String? senderName;
  String? messageText;
  List<String>? mediaUrls;
  String? mediaType;
  DateTime? createdAt;
  DateTime? updatedAt;

  MessageModel({
    this.msgId,
    this.senderId,
    this.senderProfileUrl,
    this.senderName,
    this.messageText,
    this.mediaUrls,
    this.mediaType,
    this.createdAt,
    this.updatedAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    msgId = json['msgId'];
    senderId = json['senderId'];
    senderProfileUrl = json['senderProfileUrl'];
    senderName = json['senderName'];
    messageText = json['messageText'];
    if (json['mediaUrls'] != null) {
      mediaUrls = <String>[];
      json['mediaUrls'].forEach((v) {
        mediaUrls!.add(v.toString());
      });
    }
    mediaType = json['mediaType'];
    createdAt = json['created_at'] != null
        ? (json['created_at'] is Timestamp
            ? (json['created_at'] as Timestamp).toDate()
            : DateTime.tryParse(json['created_at'].toString()))
        : null;
    updatedAt = json['updated_at'] != null
        ? (json['updated_at'] is Timestamp
            ? (json['updated_at'] as Timestamp).toDate()
            : DateTime.tryParse(json['updated_at'].toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msgId'] = msgId;
    data['senderId'] = senderId;
    data['senderProfileUrl'] = senderProfileUrl;
    data['senderName'] = senderName;
    data['messageText'] = messageText;
    data['mediaUrls'] = mediaUrls;
    data['mediaType'] = mediaType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
