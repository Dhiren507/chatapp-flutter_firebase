import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/chat_list_model.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final ChatListModel chatListData;

  const ChatListTile({super.key, required this.chatListData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: .none,
          children: [
            CommonAvatar(
              imgPath: chatListData.otherUserProfile?.photoUrl ?? chatListData.groupProfile!,
              size: 55,
              borderColor: Colors.transparent,
            ),
            Positioned(
              bottom: -0,
              right: 5,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: AppColors.activeGreen,
                  shape: BoxShape.circle,
                ),
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
                chatListData.otherUserProfile?.name ?? chatListData.groupName!,
                style: AppTextStyles.heading(fontSize: 20),
                overflow: .ellipsis,
              ),
              Text(
                chatListData.lastMessage?.messageText ?? '',
                style: AppTextStyles.body(fontSize: 12),
                overflow: .ellipsis,
              ),
            ],
          ),
        ),

        Column(
          crossAxisAlignment: .end,
          children: [
            Text('2 min ago', style: AppTextStyles.body()),
            Container(
              height: 22,
              width: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.bgError,
                shape: BoxShape.circle,
              ),
              child: Text(
                '3',
                style: AppTextStyles.body(fontSize: 12, color: AppColors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
