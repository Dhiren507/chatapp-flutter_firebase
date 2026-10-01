
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  final String profileUrl;
  final String contactName;
  final String contactBio;

  const ContactListTile({
    super.key,
    required this.profileUrl,
    required this.contactName,
    required this.contactBio,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonAvatar(
          imgPath: profileUrl,
          size: 55,
          borderColor: Colors.transparent,
        ),

        const SizedBox(width: 15),

        Flexible(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                contactName,
                style: AppTextStyles.heading(fontSize: 18),
                overflow: .ellipsis,
              ),
              if(contactBio != '')
                Text(contactBio, style: AppTextStyles.body(fontSize: 12), overflow: .ellipsis,),
            ],
          ),
        ),
      ],
    );
  }
}
