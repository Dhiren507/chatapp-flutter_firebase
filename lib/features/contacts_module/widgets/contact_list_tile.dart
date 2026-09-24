import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonAvatar(
          imgPath: AppAssets.appleIcon,
          size: 55,
          borderColor: Colors.transparent,
        ),

        const SizedBox(width: 15),

        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'John Abraham',
              style: AppTextStyles.heading(fontSize: 18),
              overflow: .ellipsis,
            ),
            Text(
              'Life is going good af...',
              style: AppTextStyles.body(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
