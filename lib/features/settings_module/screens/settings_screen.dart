import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          actionsPadding: EdgeInsets.only(right: 24),
          leadingWidth: 65,
          backgroundColor: Colors.transparent,
          title: Text(
            AppStrings.settingsScreenTitle,
            style: AppTextStyles.heading(fontSize: 20, color: AppColors.white),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: CommonBackButton(arrowColor: AppColors.white),
          ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          CommonAvatar(
                            imgPath: AppAssets.appleIcon,
                            size: 60,
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
      
                          const Spacer(),
      
                          SvgPicture.asset(AppAssets.qrCodeIcon),
                        ],
                      ),
                    ),
      
                    Divider(),
      
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        child: ListView.separated(
                          clipBehavior: .none,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final option = AppStrings.settingsOptions[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  option['navigateTo'],
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      color: AppColors.bgGrey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      option['leadingIcon'],
                                      height: 16,
                                      width: 16,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: .start,
                                    children: [
                                      Text(
                                        option['optionText'],
                                        style: AppTextStyles.heading(),
                                      ),
                                      if (option['subtitle'] != '')
                                        Text(
                                          option['subtitle'],
                                          style: AppTextStyles.body(),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 25),
                          itemCount: AppStrings.settingsOptions.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
