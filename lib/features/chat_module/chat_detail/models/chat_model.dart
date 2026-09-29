class ChatModel {
  final String chatId;
  final List<String> members;

  ChatModel({required this.chatId, required this.members});

  Map<String, dynamic> toMap() => {'chatId': chatId, 'members': members};

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] ?? '',
      members: List<String>.from(map['members'] ?? []),
    );
  }
}


class MessageModel {
  final String msgId;
  final String senderId;
  final String messageText;
  final String mediaUrl;
  final String createdAt;
  final String updatedAt;

  MessageModel({
    required this.msgId,
    required this.senderId,
    required this.messageText,
    required this.mediaUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'msgId': msgId,
      'senderId': senderId,
      'messageText': messageText,
      'mediaUrl': mediaUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      msgId: map['msgId'] ?? '',
      senderId: map['senderId'] ?? '',
      messageText: map['messageText'] ?? '',
      mediaUrl: map['mediaUrl'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }
}
