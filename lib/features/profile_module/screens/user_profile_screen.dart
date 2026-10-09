import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_image_container.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/profile_module/widgets/profile_info_section.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argsList = ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    final UserChatModel? currentChat = argsList.last;
    final UserModel otherUserProfile = argsList.length > 1 ? argsList.first : null;

    final List<String> listOfMediaUrls = [];

    final messages = currentChat?.messages;

    if (messages != null && messages.isNotEmpty) {
      for (final message in messages) {
        final mediaUrls = message.mediaUrls;
        if (mediaUrls != null && mediaUrls.isNotEmpty) {
          listOfMediaUrls.addAll(mediaUrls);
        }
      }
    }

    void showAllImagesGridView() {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog.fullscreen(
            child: Scaffold(
              backgroundColor: AppColors.black,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        IconButton(
                          constraints: BoxConstraints(),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          icon: Icon(Icons.close, color: AppColors.white),
                        ),
                        Expanded(
                          child: Center(
                            child: Text('Chat Media', style: AppTextStyles.heading(color: AppColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        final selectedImage = listOfMediaUrls[index];

                        return CommonImageContainer(
                          imgUrl: selectedImage,
                          borderColor: Colors.transparent,
                          fit: .cover,
                          borderRadius: 0,
                        );
                      },
                      itemCount: listOfMediaUrls.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.black,
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
              CommonAvatar(imgPath: otherUserProfile.photoUrl ?? '', size: 82),
              const SizedBox(height: 10),
              Text(otherUserProfile.name ?? '', style: AppTextStyles.heading(color: AppColors.white)),

              Text('@${otherUserProfile.name}', style: AppTextStyles.body(fontSize: 12)),

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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                      sectionValue: otherUserProfile.name ?? '',
                    ),
                    ProfileInfoSection(
                      sectionTitle: 'Email Address',
                      sectionValue: otherUserProfile.email ?? '',
                    ),
                    ProfileInfoSection(
                      sectionTitle: 'Address',
                      sectionValue: '33 Stree whatso ever adress lol toooo long adress ',
                    ),
                    ProfileInfoSection(sectionTitle: 'Phone Number', sectionValue: '(333) 555-0104'),

                    Row(
                      children: [
                        Text(
                          AppStrings.profileMediaSharedText,
                          style: AppTextStyles.body(fontWeight: FontWeight(450)),
                        ),
                        const Spacer(),
                        Text(
                          AppStrings.profileViewAllText,
                          style: AppTextStyles.heading(
                            fontWeight: FontWeight.w600,
                            color: AppColors.bgGreen,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    listOfMediaUrls.isNotEmpty
                        ? SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: .horizontal,
                              itemBuilder: (context, index) {
                                if (index == 3) {
                                  return Stack(
                                    children: [
                                      CommonImageContainer(imgUrl: listOfMediaUrls[3], size: 92),
                                      GestureDetector(
                                        onTap: () {
                                          showAllImagesGridView();
                                        },
                                        child: Container(
                                          alignment: .center,
                                          height: 92,
                                          width: 92,
                                          decoration: BoxDecoration(
                                            color: AppColors.textPrimary.withAlpha(100),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '+${listOfMediaUrls.length - 4}',
                                            style: AppTextStyles.body(color: AppColors.white, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                final url = listOfMediaUrls[index];
                                return CommonImageContainer(imgUrl: url, size: 92);
                              },
                              separatorBuilder: (context, index) => const SizedBox(width: 10),
                              itemCount: listOfMediaUrls.length > 4 ? 4 : listOfMediaUrls.length,
                            ),
                          )
                        : const Text('No Media Shared!'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
