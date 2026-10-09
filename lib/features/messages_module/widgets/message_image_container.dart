import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_image_container.dart';
import 'package:flutter/material.dart';

class MessageImageContainer extends StatelessWidget {
  final List<String> mediaUrls;
  final double size;
  final bool isMe;

  const MessageImageContainer({super.key, required this.mediaUrls, required this.size, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          useSafeArea: false,
          context: context,
          builder: (dialogContext) {
            return Dialog.fullscreen(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                      icon: Icon(Icons.close, color: AppColors.black),
                    ),

                    Expanded(
                      child: PageView.builder(
                        itemBuilder: (context, index) {
                          final selectedImage = mediaUrls[index];

                          return CommonImageContainer(imgUrl: selectedImage, borderColor: Colors.transparent);
                        },
                        itemCount: mediaUrls.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(maxWidth: size),
        decoration: BoxDecoration(
          color: isMe ? AppColors.bgGreen : AppColors.senderChatBubbleBg,
          borderRadius: BorderRadius.only(
            topLeft: isMe ? const Radius.circular(12) : Radius.zero,
            topRight: isMe ? Radius.zero : const Radius.circular(12),
            bottomLeft: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
          ),
        ),
        child: mediaUrls.length == 1
            ? CommonImageContainer(imgUrl: mediaUrls.first, size: size, fit: .cover)
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1,
                ),
                itemCount: mediaUrls.length > 3 ? 4 : mediaUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = mediaUrls[index];

                  if (mediaUrls.length > 4 && index == 3) {
                    return Stack(
                      children: [
                        CommonImageContainer(size: 120, imgUrl: imageUrl, fit: .cover),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.textSecondary.withAlpha(100),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '+${mediaUrls.length - 4}',
                            style: AppTextStyles.body(color: AppColors.white, fontSize: 30),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CommonImageContainer(imgUrl: imageUrl, fit: .cover);
                  }
                },
              ),
      ),
    );
  }
}
