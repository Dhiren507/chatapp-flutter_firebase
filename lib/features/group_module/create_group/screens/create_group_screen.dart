import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Create Group',
            style: AppTextStyles.heading(fontSize: 20, color: AppColors.black),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: CommonBackButton(arrowColor: AppColors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Group Description',
                style: AppTextStyles.heading(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 15),
              TextField(
                keyboardType: .multiline,
                maxLines: 2,
                style: AppTextStyles.body(
                  fontWeight: .w500,
                  fontSize: 40,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Enter your group title in here.....',
                  hintStyle: AppTextStyles.body(
                    fontWeight: .w400,
                    fontSize: 40,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff20a09014).withAlpha(20),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        'Group Work',
                        style: AppTextStyles.body(color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff20a09014).withAlpha(20),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        'Team Relationship',
                        style: AppTextStyles.body(color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Text(
                'Group Admin',
                style: AppTextStyles.heading(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 5),

              Row(
                spacing: 10,
                children: [
                  CommonAvatar(imgPath: AppAssets.chatCallIcon, size: 52),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'John Abraham',
                        style: AppTextStyles.heading(),
                        overflow: .ellipsis,
                      ),
                      Text(
                        'Group Admin',
                        style: AppTextStyles.body(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Text(
                'Invited Members',
                style: AppTextStyles.heading(color: AppColors.textSecondary),
              ),

              Wrap(
                children: [
                  Stack(
                    clipBehavior: .none,
                    children: [
                      CommonAvatar(imgPath: AppAssets.appleIcon, size: 70),
                      Positioned(
                        top: -1,
                        right: -4,
                        child: CommonSvgContainer(
                          containerSize: 24,
                          backgroundColor: AppColors.errorText,
                          iconPath: AppAssets.removeIcon,
                          iconColor: AppColors.white,
                          iconSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 15),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.searchScreen);
                    },
                    child: DottedBorder(
                      options: CircularDottedBorderOptions(
                        color: Color(0xFFCFD3D2),
                        strokeWidth: 2,
                        dashPattern: [12, 7],
                        padding: const EdgeInsets.all(6),
                      ),
                      child: Container(
                        height: 55,
                        width: 55,
                        alignment: .center,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Icon(Icons.add, color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
          child: CommonButton(
            label: 'Create',
            onPressed: () {},
            backgroundColor: AppColors.bgGreen,
            textColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}
