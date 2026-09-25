import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_image_container.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final List<String> mediaUrls;
  final String mediaType;
  final String messageText;

  const ChatBubble({
    super.key,
    required this.isMe,
    required this.mediaType,
    required this.mediaUrls,
    required this.messageText,
  });

  @override
  Widget build(BuildContext context) {
    final double maxBubbleWidth =
        (MediaQuery.of(context).size.width - 48) * 0.8;
    final bool hasImages = mediaUrls.isNotEmpty && mediaType == 'image';
    final bool hasText = messageText != '';

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? .end : .start,
        children: [
          if (hasText)
            Container(
              constraints: BoxConstraints(maxWidth: maxBubbleWidth),
              padding: EdgeInsetsGeometry.only(
                left: 12,
                right: 12,
                top: 8,
                bottom: 4,
              ),
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
                alignment: WrapAlignment.end,
                spacing: 12,
                crossAxisAlignment: .end,
                children: [
                  Text(
                    'Hello',
                    style: AppTextStyles.body(
                      color: isMe ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '9: 30 AM',
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
          if (hasImages) const SizedBox(height: 10),
          Container(
            constraints: BoxConstraints(maxWidth: maxBubbleWidth),
            padding: EdgeInsetsGeometry.all(8),
            decoration: BoxDecoration(
              color: AppColors.senderChatBubbleBg,
              borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(12) : Radius.zero,
                topRight: isMe ? Radius.zero : Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),

            child: mediaUrls.length == 1
                ? CommonImageContainer(
                    size: maxBubbleWidth,
                    imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS5DKzdprfHmIYRpEfNNPVRYPDfh0Bvjjw_Ud_yRIwSw&s=10',
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 1,
                    ),
                    itemCount: mediaUrls.length > 3 ? 4 : mediaUrls.length,
                    itemBuilder: (context, index) {
                      if (mediaUrls.length > 4 && index == 3) {
                        return Stack(
                          children: [
                            CommonImageContainer(
                              size: 120,
                              imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS5DKzdprfHmIYRpEfNNPVRYPDfh0Bvjjw_Ud_yRIwSw&s=10',
                            ),
                            Container(
                              alignment: .center,
                              decoration: BoxDecoration(
                                color: AppColors.textSecondary.withAlpha(100),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '+${mediaUrls.length - 4}',
                                style: AppTextStyles.body(
                                  color: AppColors.textPrimary,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return CommonImageContainer(
                          imgUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS5DKzdprfHmIYRpEfNNPVRYPDfh0Bvjjw_Ud_yRIwSw&s=10',
                          borderRadius: 10,
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
