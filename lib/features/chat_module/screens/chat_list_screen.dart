import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/utils/image_picker_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_bottom_sheet.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/chat_module/widgets/chat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leadingWidth: 65,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.chatListScreenTitle,
          style: AppTextStyles.heading(fontSize: 20, color: AppColors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CommonSvgContainer(
            iconPath: AppAssets.searchIcon,
            iconSize: 22,
            containerSize: 44,
            iconColor: AppColors.white,
            borderColor: AppColors.borderGrey,
          ),
        ),
        actions: [
          CommonAvatar(imgPath: AppAssets.appleIcon),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthRepository>().logOut;
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.onboardingScreen,
                (route) => false,
              );
            },
            color: AppColors.bgError,
          ),
        ],
      ),
      body: Column(
        children: [
          // Status Horizontal List
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25, bottom: 20),
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
                              child: GestureDetector(
                                onTap: () async {
                                  List<XFile>?
                                  statusImages = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return CommonBottomSheet(
                                        isStatusScreen: true,
                                        onMediaPressed: () async {
                                          List<XFile> selectedStatusImage =
                                              await ImagePickerUtils.pickImage(
                                                isMultiSelect: false,
                                              );
                                          if (context.mounted) {
                                            Navigator.pop(
                                              context,
                                              selectedStatusImage,
                                            );
                                          }
                                        },
                                        onCameraPressed: () async {
                                          XFile? capturedImage =
                                              await ImagePickerUtils.captureImage();

                                          if (!context.mounted) return;

                                          if (capturedImage != null) {
                                            print(
                                              'this is an captured image from camera' +
                                                  capturedImage.name,
                                            );
                                            Navigator.pop(context, <XFile>[
                                              capturedImage,
                                            ]);
                                          }
                                        },
                                      );
                                    },
                                  );

                                  if (!context.mounted) return;

                                  if (statusImages != null &&
                                      statusImages.isNotEmpty) {
                                    XFile? statusImage = statusImages[0];

                                    print(statusImage.name);

                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.statusPreviewScreen,
                                      arguments: statusImage,
                                    );
                                  }
                                },
                                child: CommonSvgContainer(
                                  containerSize: 16,
                                  backgroundColor: AppColors.white,
                                  iconPath: AppAssets.plusIcon,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          AppStrings.myStatusText,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.statusViewScreen,
                          );
                        },
                        child: CommonAvatar(
                          imgPath: AppAssets.appleIcon,
                          size: 58,
                          borderColor: AppColors.highlightYellow,
                        ),
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.chatDetailScreen,
                            );
                          },
                          child: ChatListTile(),
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
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.crateGroupScreen);
        },
        backgroundColor: AppColors.green,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
