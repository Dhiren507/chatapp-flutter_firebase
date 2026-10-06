import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatus {
  final String? id;
  final String? userId;
  final String? username;
  final String? profileUrl;
  final String? statusUrl;
  final String? captionText;
  List<String>? seenBy;
  final DateTime? createdAt;

  UserStatus({
    this.id,
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
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      profileUrl: json['profileUrl'],
      statusUrl: json['statusUrl'],
      captionText: json['caption'],
      seenBy: List<String>.from(json['seenBy'] ?? []),
      createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'profileUrl': profileUrl,
      'statusUrl': statusUrl,
      'seenBy': seenBy,
      'caption': captionText,
      'created_at': createdAt,
    };
  }
}
