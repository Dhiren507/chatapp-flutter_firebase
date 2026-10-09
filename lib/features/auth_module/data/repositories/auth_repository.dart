import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/auth_module/data/data_providers/firebase_auth_provider.dart';

class AuthRepository {
  final AppAuthProvider _authProvider;

  AuthRepository({required AppAuthProvider provider}) : _authProvider = provider;

  Future<void> loginWithEmailAndPassword({required String email, required String password}) async {
    print('log in api called');
    final credential = await _authProvider.loginWithEmailAndPassword(email: email, password: password);

    final user = credential.user;
    if (user == null) {
      throw Exception('User data not found.');
    }
  }

  Future<void> loginWithGoogle() async {
    print('google log in api called');
    final credential = await _authProvider.loginWithGoogleRaw();

    final user = credential?.user;
    if (credential == null || user == null) {
      throw Exception('User data not found.');
    }
  }

  Future<void> signUpAndCreateUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _authProvider.registerWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('User registration failed.');
    }
  }

  Future<void> logOut() async {
    await _authProvider.signOut();
  }

  String? getCurrentUserId() {
    final user = _authProvider.getCurrentUser();

    return user?.uid;
  }

  Future<UserModel> getCurrentUserProfile() async {
    final profileJson = await _authProvider.getCurrentUserProfile();

    return UserModel.fromJson(profileJson);
  }

  Future<void> updateOnlineStatus(String userId, bool isOnline) async {
    await _authProvider.updateOnlineStatus(userId, isOnline);
  }
}
