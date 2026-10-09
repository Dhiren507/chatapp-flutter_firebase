import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:chatapp_firebase/core/services/cloudinary_service.dart';
import 'package:chatapp_firebase/core/utils/id_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_status.dart';

class StatusRepository {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<void> postStatus({
    required String userId,
    required String imageLocalPath,
    required String imageCaption,
  }) async {
    final String cloudPath = 'chat_app/status/$userId';

    try {
      final downloadUrl = await CloudinaryService.instance
          .uploadImageCustomPath(
            localPath: imageLocalPath,
            uploadFolderPath: cloudPath,
          );

      if (downloadUrl == null) {
        throw Exception('upload error');
      }

      final currentUserProfile = await _firebaseDb
          .collection(AppKeys.userCollectionKey)
          .doc(userId)
          .get();

      final userJson = currentUserProfile.data();

      final statusId = IdUtils.v4id;

      await _firebaseDb
          .collection(AppKeys.statusCollectinKey)
          .doc(statusId)
          .set({
            'id': statusId,
            'userId': userId,
            'username': userJson?['name'],
            'profileUrl': userJson?['photoUrl'],
            'caption': imageCaption,
            'statusUrl': downloadUrl,
            'seenBy': [],
            'createdAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print('error while positing status');
    }
  }


  Stream<List<UserStatus>> streamAllStatus() {
    final DateTime twentyFourHoursAgo = DateTime.now().subtract(const Duration(hours: 24));

    return _firebaseDb
        .collection(AppKeys.statusCollectinKey)
        .where('createdAt', isGreaterThanOrEqualTo: twentyFourHoursAgo)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((docsSnapshot) {
      return [
        for (var doc in docsSnapshot.docs)
          if (doc.exists) UserStatus.fromJson(doc.data()),
      ];
    });
  }

  Future<void> updateSeenBy({
    required String statusId,
    required String currentUserId,
  }) async {
    await _firebaseDb
        .collection(AppKeys.statusCollectinKey)
        .doc(statusId)
        .update({
          'seenBy': FieldValue.arrayUnion([currentUserId]),
        });
  }
}
