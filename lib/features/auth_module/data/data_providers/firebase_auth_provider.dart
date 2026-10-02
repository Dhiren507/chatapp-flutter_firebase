import 'package:chatapp_firebase/core/constants/app_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppAuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseDb = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?> loginWithGoogleRaw() async {
    final List<String> scopes = ['email', 'profile'];

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
      scopeHint: scopes,
    );

    final googleAuth = await googleUser.authorizationClient.authorizeScopes(
      scopes,
    );

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleUser.authentication.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth
        .signInWithCredential(credential);

    if (userCredential.additionalUserInfo?.isNewUser == true) {
      await _firebaseDb
          .collection(AppKeys.userCollectionKey)
          .doc(userCredential.user!.uid)
          .set({
            'uid': userCredential.user!.uid,
            'name': userCredential.additionalUserInfo!.profile?['name'],
            'email': userCredential.user!.email,
            'phone': '',
            'photoUrl': userCredential.additionalUserInfo!.profile?['picture'],
            'bio_text': '',
            'created_at': FieldValue.serverTimestamp(),
            'updated_at': FieldValue.serverTimestamp(),
          });
    }

    return userCredential;
  }

  Future<UserCredential> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      await _firebaseDb
          .collection(AppKeys.userCollectionKey)
          .doc(credential.user!.uid)
          .set({
            'uid': credential.user!.uid,
            'name': name,
            'email': email,
            'phone': '',
            'photoUrl': '',
            'bio_text': '',
            'created_at': FieldValue.serverTimestamp(),
            'updated_at': FieldValue.serverTimestamp(),
          });
    }

    return credential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<Map<String, dynamic>> getCurrentUserProfile() async {
    final currentUserId = _firebaseAuth.currentUser?.uid;

    final userDocSnapshot = await _firebaseDb
        .collection(AppKeys.userCollectionKey)
        .doc(currentUserId)
        .get();

    final userProfileJson = userDocSnapshot.data()!;

    print('this is the userProfile json : $userProfileJson');
    return userProfileJson;
  }
}
