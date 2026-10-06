part of 'chat_detail_bloc.dart';

sealed class ChatDetailEvent {}

class ChatDetailFetchRequested extends ChatDetailEvent {
  final UserModel? otherUserProfile;
  final UserModel? currentUserProfile;
  final String? groupChatId;

  ChatDetailFetchRequested({this.otherUserProfile, this.currentUserProfile, this.groupChatId});
}

class SendMessagePressed extends ChatDetailEvent {
  final List<XFile>? selectedAttachment;
  final String? msgText;

  SendMessagePressed({this.msgText, this.selectedAttachment});
}

class ChatDocumentUpdated extends ChatDetailEvent {
  final UserChatModel? chatData;
  final UserModel currentUserProfile;
  final UserModel? otherUserProfile;
  final String chatId;

  ChatDocumentUpdated({
    required this.chatData,
    required this.chatId,
    required this.currentUserProfile,
    this.otherUserProfile,
  });
}

// user will click on the attachment select multiple files or single one
// add a new event attachmentSelected which will take the list of x files or local path of each file
// redirect to a preview full screen dialog box  with page view builder with caption text below
// just use the current screen bloc send message function in that dialog box thats it
