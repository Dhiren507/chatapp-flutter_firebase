import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatus {
  final String? userId;
  final String? username;
  final String? profileUrl;
  final String? statusUrl;
  final String? captionText;
  final List<String>? seenBy;
  final DateTime? createdAt;

  UserStatus({
    this.userId,
    this.username,
    this.profileUrl,
    this.statusUrl,
    this.captionText,
    this.seenBy,
    this.createdAt,
  });

  factory UserStatus.fromJson(Map<String, dynamic> json) {
    return UserStatus(
      userId: json['userId'],
      username: json['username'],
      profileUrl: json['profileUrl'],
      statusUrl: json['statusUrl'],
      captionText: json['captionText'],
      seenBy: List<String>.from(json['seenBy'] ?? []),
      createdAt: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : null,
    );
  }
}
