import 'package:chatapp_firebase/features/auth_module/data/data_providers/firebase_auth_provider.dart';

class AuthRepository {
  final FirebaseAuthProvider _authProvider;

  AuthRepository({required FirebaseAuthProvider provider})
    : _authProvider = provider;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print('log in api called');
    final credential = await _authProvider.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('User data not found.');
    }
  }

  Future<void> loginWithGoogle() async {
    print('google log in api called');
    final credential = await _authProvider.loginWithGoogleRaw();

    final user = credential?.user;
    if (user == null) {
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
    _authProvider.getCurrentUser();

    final user = _authProvider.getCurrentUser();

    return user?.uid;
  }
}
