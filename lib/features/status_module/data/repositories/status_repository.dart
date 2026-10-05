import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:chatapp_firebase/core/services/cloudinary_service.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusRepository {
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;

  Future<void> postStatus({
    required String userId,
    required String imageLocalPath,
    required String imageCaption,
  }) async {
    final String cloudPath = 'chat_app/status/$userId';

    print('upload functiuon called');

    print(cloudPath);

    try {
      final downloadUrl = await CloudinaryService.instance
          .uploadImageCustomPath(
            localPath: imageLocalPath,
            uploadFolderPath: cloudPath,
          );

      final currentUserProfile = await _firebaseDb
          .collection(AppKeys.userCollectionKey)
          .doc(userId)
          .get();

      final userJson = currentUserProfile.data();

      await _firebaseDb.collection(AppKeys.statusCollectinKey).doc(userId).set({
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

  Future<List<UserStatus>> getAllStatus() async {
    final statusQuerySnapshot = await _firebaseDb
        .collection(AppKeys.statusCollectinKey)
        .get();

    print('this is the status json ${statusQuerySnapshot.docs}');

    final List<UserStatus> statusList = [];

    for (final doc in statusQuerySnapshot.docs) {
      statusList.add(UserStatus.fromJson(doc.data()));
    }

    return statusList;
  }
}
