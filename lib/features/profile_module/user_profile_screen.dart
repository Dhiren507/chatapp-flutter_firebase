import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_image_container.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/profile_module/profile_info_section.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actionsPadding: EdgeInsets.only(right: 24),
          leadingWidth: 65,
          backgroundColor: AppColors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: CommonBackButton(arrowColor: AppColors.white),
          ),
        ),
        body: Column(
          children: [
            // Top Profile Section
            Column(
              children: [
                CommonAvatar(imgPath: AppAssets.userGroupIcon, size: 82),
                const SizedBox(height: 10),
                Text(
                  'John Abraham ',
                  style: AppTextStyles.heading(color: AppColors.white),
                ),

                Text('@jhonabraham', style: AppTextStyles.body(fontSize: 12)),

                const SizedBox(height: 25),

                Row(
                  spacing: 20,
                  mainAxisAlignment: .center,
                  children: [
                    CommonSvgContainer(
                      containerSize: 44,
                      backgroundColor: AppColors.lightBlack,
                      iconPath: AppAssets.messageIcon,
                      iconColor: AppColors.white,
                      iconSize: 26,
                      borderColor: Colors.transparent,
                    ),
                    CommonSvgContainer(
                      containerSize: 44,
                      backgroundColor: AppColors.lightBlack,
                      iconPath: AppAssets.videoIcon,
                      iconColor: AppColors.white,
                      iconSize: 26,
                      borderColor: Colors.transparent,
                    ),
                    CommonSvgContainer(
                      containerSize: 44,
                      backgroundColor: AppColors.lightBlack,
                      iconPath: AppAssets.callIcon,
                      iconColor: AppColors.white,
                      iconSize: 26,
                      borderColor: Colors.transparent,
                    ),
                    CommonSvgContainer(
                      containerSize: 44,
                      backgroundColor: AppColors.lightBlack,
                      iconPath: AppAssets.horizontalMoreIcon,
                      iconColor: AppColors.white,
                      iconSize: 26,
                      borderColor: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

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

                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: 10,
                    children: [
                      const SizedBox(height: 5),
                      Align(
                        alignment: .center,
                        child: Container(
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.mutedGrey,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),

                      ProfileInfoSection(
                        sectionTitle: 'Display Name',
                        sectionValue: 'Jhon Abraham',
                      ),
                      ProfileInfoSection(
                        sectionTitle: 'Email Address',
                        sectionValue: 'hellowworld@gmail.com',
                      ),
                      ProfileInfoSection(
                        sectionTitle: 'Address',
                        sectionValue:
                            '33 Stree whatso ever adress lol toooo long adress ',
                      ),
                      ProfileInfoSection(
                        sectionTitle: 'Phone Number',
                        sectionValue: '(333) 555-0104',
                      ),

                      Row(
                        children: [
                          Text(
                            'Media Shared',
                            style: AppTextStyles.body(
                              fontWeight: FontWeight(450),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'View All',
                            style: AppTextStyles.heading(
                              fontWeight: FontWeight.w600,
                              color: AppColors.bgGreen,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        spacing: 10,
                        children: [
                          CommonImageContainer(
                            imgUrl: 'https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-02.jpg',
                            size: 92,
                          ),
                          CommonImageContainer(
                            imgUrl: 'https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-02.jpg',
                            size: 92,
                          ),

                          Stack(
                            children: [
                              CommonImageContainer(
                                imgUrl: 'https://static01.nyt.com/newsgraphics/2020/11/12/fake-people/4b806cf591a8a76adfc88d19e90c8c634345bf3d/fallbacks/mobile-02.jpg',
                                size: 92,
                              ),
                              Container(
                                alignment: .center,
                                height: 92,
                                width: 92,
                                decoration: BoxDecoration(
                                  color: AppColors.textPrimary.withAlpha(100),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  '255+',
                                  style: AppTextStyles.body(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
