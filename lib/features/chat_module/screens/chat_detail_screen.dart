import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/utils/image_picker_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_bottom_sheet.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/chat_module/widgets/chat_bubble.dart';
import 'package:chatapp_firebase/features/chat_module/widgets/chat_header.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: CommonBackButton(),
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profileScreen);
          },
          child: ChatHeader(),
        ),
        centerTitle: false,
        actions: [
          CommonSvgContainer(
            containerSize: 30,
            iconPath: AppAssets.chatCallIcon,
            borderColor: Colors.transparent,
            iconSize: 24,
            iconColor: AppColors.textPrimary,
          ),
          const SizedBox(width: 10),
          CommonSvgContainer(
            containerSize: 30,
            iconPath: AppAssets.videoIcon,
            borderColor: Colors.transparent,
            iconColor: AppColors.textPrimary,
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 24),
        titleSpacing: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    bool isMe = index % 2 == 0;
                    return ChatBubble(
                      isMe: isMe,
                      mediaType: 'image',
                      mediaUrls: ['', '', '', '', '', '', '', '', ''],
                      messageText: 'hi',
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: 100,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  spacing: 10,
                  children: [
                    CommonSvgContainer(
                      containerSize: 24,
                      iconPath: AppAssets.attachmentIcon,
                      onClick: () async {
                        List<XFile> selectedAttachment =
                            await showModalBottomSheet(
                              backgroundColor: AppColors.white,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return CommonBottomSheet(
                                  onMediaPressed: () async {
                                    List<XFile> selectedStatusImage =
                                        await ImagePickerUtils.pickImage(
                                          isMultiSelect: true,
                                        );
                                    if (context.mounted) {
                                      Navigator.pop(
                                        context,
                                        selectedStatusImage,
                                      );
                                    }
                                  },
                                );
                              },
                            );

                        if (selectedAttachment.isNotEmpty) {
                          print(
                            'this is an attachment selected in chat screen${selectedAttachment[0].name}',
                          );
                        }
                      },
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: .multiline,
                        style: AppTextStyles.body(
                          fontWeight: .w500,
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.bgDisables,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          isDense: true,
                          hintText: AppStrings.chatMessageHintText,
                          hintStyle: AppTextStyles.body(
                            fontWeight: .w400,
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    CommonSvgContainer(
                      containerSize: 42,
                      iconPath: AppAssets.messageSendIcon,
                      iconColor: AppColors.white,
                      backgroundColor: AppColors.bgGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
