import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/widgets/common_app_bar_icon.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leadingWidth: 65,
        backgroundColor: Colors.transparent,
        title: Text(
          'Contacts',
          style: AppTextStyles.heading(fontSize: 20, color: AppColors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CommonImageContainer(
            iconPath: AppAssets.searchIcon,
            iconSize: 22,
            containerSize: 44,
            iconColor: AppColors.white,
          ),
        ),
        actions: [
          CommonImageContainer(
            iconPath: AppAssets.addContactIcon,
            iconSize: 22,
            containerSize: 44,
            iconColor: AppColors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 3,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.mutedGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: Text(
                        'My Contacts',
                        style: AppTextStyles.heading(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemBuilder: (context, index) {
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
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
