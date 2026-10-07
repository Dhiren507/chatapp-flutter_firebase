import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/utils/date_format_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final UserChatModel chatListData;
  final String currentUserId;

  const ChatListTile({super.key, required this.chatListData, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final isGroup = chatListData.isGroup ?? false;

    final otherUserProfile = chatListData.getOtherUserProfile(currentUserId);

    final unreadCount = chatListData.getUnreadCountForUser(currentUserId);

    return Row(
      children: [
        Stack(
          clipBehavior: .none,
          children: [
            CommonAvatar(
              imgPath: (isGroup ? chatListData.groupProfileUrl! : otherUserProfile?.photoUrl) ?? '',
              size: 55,
              borderColor: Colors.transparent,
            ),
            Positioned(
              bottom: -0,
              right: 5,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(color: AppColors.activeGreen, shape: BoxShape.circle),
              ),
            ),
          ],
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                (isGroup ? chatListData.groupName! : otherUserProfile?.name) ?? '',
                style: AppTextStyles.heading(fontSize: 18),
                overflow: .ellipsis,
              ),
              Text(
                chatListData.lastMessage?.mediaType == 'image'
                    ? 'Sent an Image'
                    : (chatListData.lastMessage?.messageText ?? ''),
                style: AppTextStyles.body(fontSize: 12),
                overflow: .ellipsis,
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: .end,
          children: [
            Text(DateFormatUtils.calculateTimeAgo(chatListData.updatedAt!), style: AppTextStyles.body()),
            if (unreadCount > 0)
              Container(
                height: 22,
                width: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.bgError, shape: BoxShape.circle),
                child: Text('$unreadCount', style: AppTextStyles.body(fontSize: 12, color: AppColors.white)),
              ),
          ],
        ),
      ],
    );
  }
}
