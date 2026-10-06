import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/utils/date_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/widgets/message_image_container.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final bool isSameSender;
  final bool isGroup;
  final MessageModel message;

  const ChatBubble({
    super.key,
    required this.isMe,
    this.isSameSender = false,
    required this.message,
    this.isGroup = false,
  });

  @override
  Widget build(BuildContext context) {
    final double maxBubbleWidth = (MediaQuery.of(context).size.width - 48) * 0.7;

    final bool hasImages = message.mediaType == 'image';

    final bool hasText = message.messageText != null && message.messageText!.isNotEmpty;

    final bool showAvatarAndTitle = isGroup && !isSameSender;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe && isGroup) ...[
            showAvatarAndTitle
                ? CommonAvatar(imgPath: message.senderProfileUrl ?? '', size: 40)
                : const SizedBox(width: 40),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isGroup) ...[
                  const SizedBox(height: 5),
                  if (showAvatarAndTitle)
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                      child: Text(
                        message.senderName ?? '',
                        style: AppTextStyles.body(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ),
                ],
                if (hasImages) ...[
                  MessageImageContainer(mediaUrls: message.mediaUrls ?? [], isMe: isMe, size: maxBubbleWidth),
                  if (hasText) const SizedBox(height: 4),
                ],
                if (hasText)
                  Container(
                    constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 4),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.bgGreen : AppColors.senderChatBubbleBg,
                      borderRadius: BorderRadius.only(
                        topLeft: isMe ? Radius.circular(12) : Radius.zero,
                        topRight: isMe ? Radius.zero : Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Wrap(
                      alignment: isMe ? .start : .end,
                      spacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Text(
                          message.messageText!,
                          style: AppTextStyles.body(color: isMe ? AppColors.white : AppColors.textPrimary),
                        ),
                        Text(
                          formatToMsgTimestamp(message.createdAt!),
                          style: AppTextStyles.body(
                            fontSize: 10,
                            color: isMe ? AppColors.mutedGrey : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          if (isMe && isGroup) ...[
            const SizedBox(width: 8),
            showAvatarAndTitle
                ? CommonAvatar(imgPath: message.senderProfileUrl ?? '', size: 40)
                : const SizedBox(width: 40),
          ],
        ],
      ),
    );
  }
}
