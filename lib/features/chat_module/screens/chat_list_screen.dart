import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/common_app_bar_icon.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leadingWidth: 65,
        backgroundColor: Colors.transparent,
        title: Text(
          'Home',
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
        actions: [CommonAvatar(imgPath: AppAssets.appleIcon)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: .horizontal,
                clipBehavior: .none,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      spacing: 10,
                      children: [
                        Stack(
                          clipBehavior: .none,
                          children: [
                            CommonAvatar(
                              imgPath: AppAssets.appleIcon,
                              size: 58,
                              borderColor: AppColors.highlightYellow,
                            ),
                            Positioned(
                              bottom: -1,
                              right: 0,
                              child: CommonImageContainer(
                                containerSize: 16,
                                backgroundColor: AppColors.white,
                                iconPath: AppAssets.plusIcon,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'My status',
                          style: AppTextStyles.heading(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    spacing: 10,
                    children: [
                      CommonAvatar(
                        imgPath: AppAssets.appleIcon,
                        size: 58,
                        borderColor: AppColors.highlightYellow,
                      ),
                      Text(
                        'Hellow',
                        style: AppTextStyles.heading(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemCount: 15,
              ),
            ),
          ),

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

                  const SizedBox(height: 30),

                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Stack(
                              clipBehavior: .none,
                              children: [
                                CommonAvatar(
                                  imgPath: AppAssets.appleIcon,
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
                                    'Alex Linderson no way home how are you doing this lol',
                                    style: AppTextStyles.heading(fontSize: 20),
                                    overflow: .ellipsis,
                                  ),
                                  Text(
                                    'Hellow how are you doing this no way home how are you freaking doing this lol',
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.green,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
