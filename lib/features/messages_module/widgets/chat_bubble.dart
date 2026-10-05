import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/utils/date_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_image_container.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
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
    final double maxBubbleWidth =
        (MediaQuery.of(context).size.width - 48) * 0.7;

    final bool hasImages =
        message.mediaUrls != null &&
        message.mediaUrls!.isNotEmpty &&
        message.mediaType == 'image';

    final bool hasText =
        message.messageText != null && message.messageText!.isNotEmpty;

    final bool showAvatarAndTitle = isGroup && !isSameSender;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe && isGroup) ...[
            showAvatarAndTitle
                ? CommonAvatar(
                    imgPath: message.senderProfileUrl ?? '',
                    size: 40,
                  )
                : const SizedBox(width: 40),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isGroup) ...[
                  const SizedBox(height: 5),
                  if (showAvatarAndTitle)
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                      child: Text(
                        message.senderName ?? '',
                        style: AppTextStyles.body(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
                if (hasText)
                  Container(
                    constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 8,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? AppColors.bgGreen
                          : AppColors.senderChatBubbleBg,
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
                          style: AppTextStyles.body(
                            color: isMe
                                ? AppColors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          formatToMsgTimestamp(message.createdAt!),
                          style: AppTextStyles.body(
                            fontSize: 10,
                            color: isMe
                                ? AppColors.mutedGrey
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (hasImages) ...[
                  if (hasText) const SizedBox(height: 4),
                  Container(
                    constraints: BoxConstraints(maxWidth: maxBubbleWidth),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isMe
                          ? AppColors.bgGreen
                          : AppColors.senderChatBubbleBg,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.zero,
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: message.mediaUrls?.length == 1
                        ? CommonImageContainer(
                            size: maxBubbleWidth,
                            imgUrl: message.mediaUrls!.first,
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  childAspectRatio: 1,
                                ),
                            itemCount: message.mediaUrls!.length > 3
                                ? 4
                                : message.mediaUrls?.length,
                            itemBuilder: (context, index) {
                              if (message.mediaUrls!.length > 4 && index == 3) {
                                return Stack(
                                  children: [
                                    const CommonImageContainer(
                                      size: 120,
                                      imgUrl: 'https://gstatic.com',
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.textSecondary
                                            .withAlpha(100),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '+${message.mediaUrls!.length - 4}',
                                        style: AppTextStyles.body(
                                          color: AppColors.textPrimary,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const CommonImageContainer(
                                  imgUrl: 'https://gstatic.com',
                                  borderRadius: 10,
                                );
                              }
                            },
                          ),
                  ),
                ],
              ],
            ),
          ),

          if (isMe && isGroup) ...[
            const SizedBox(width: 8),
            showAvatarAndTitle
                ? CommonAvatar(
                    imgPath: message.senderProfileUrl ?? '',
                    size: 40,
                  )
                : const SizedBox(width: 40),
          ],
        ],
      ),
    );
  }
}
