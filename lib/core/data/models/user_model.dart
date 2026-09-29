import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? photoUrl;
  String? bioText;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.bioText,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    bioText = json['bio_text'];
    createdAt = (json['created_at'] as Timestamp).toDate();
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    photoUrl = json['photoUrl'];
    uid = json['uid'];
    updatedAt = (json['updated_at'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['bio_text'] = bioText;
    data['created_at'] = createdAt;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['photoUrl'] = photoUrl;
    data['uid'] = uid;
    data['updated_at'] = updatedAt;

    return data;
  }
}
