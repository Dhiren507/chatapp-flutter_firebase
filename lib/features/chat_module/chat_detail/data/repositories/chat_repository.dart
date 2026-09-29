import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/chat_module/chat_detail/data/data_providers/chat_provider.dart';

class ChatRepository {
  final ChatProvider _chatProvider;

  ChatRepository({ChatProvider? provider})
    : _chatProvider = provider ?? ChatProvider();

  Future<UserModel> fetchUserProfile(String uid) async {
    final userProfileJson = await _chatProvider.fetchUserProfileByUid(uid);

    print('this is the userProfile json $userProfileJson');
    return UserModel.fromJson(userProfileJson);
  }
}
