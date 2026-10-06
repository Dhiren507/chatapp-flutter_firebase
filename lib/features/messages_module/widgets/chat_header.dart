import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  final String imgUrl;
  final String userName;
  final String status;

  const ChatHeader({super.key, required this.imgUrl, required this.userName, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: .none,
          children: [
            CommonAvatar(imgPath: imgUrl, size: 44, borderColor: Colors.transparent),
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

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(userName, style: AppTextStyles.heading(fontSize: 16), overflow: .ellipsis),
              Text(status, style: AppTextStyles.body(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
