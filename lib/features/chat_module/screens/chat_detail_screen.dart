import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/chat_module/widgets/attachment_option_tile.dart';
import 'package:chatapp_firebase/features/chat_module/widgets/chat_header.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Hello World this is message!!'));
                },
                itemCount: 100,
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Row(
                spacing: 10,
                children: [
                  CommonSvgContainer(
                    containerSize: 24,
                    iconPath: AppAssets.attachmentIcon,
                    onClick: () {
                      showModalBottomSheet(
                        backgroundColor: AppColors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SafeArea(
                            bottom: true,
                            child: Column(
                              mainAxisSize: .min,
                              children: [
                                SizedBox(height: 15),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: .center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.close),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: .topCenter,
                                          child: Text(
                                            'Share Content',
                                            style: AppTextStyles.heading(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      AttachmentOptionTile(
                                        iconPath: AppAssets.cameraOpenIcon,
                                        attachmentOption: 'Camera',
                                        onPressed: () {},
                                      ),
                                      const Divider(indent: 50, height: 20),
                                      AttachmentOptionTile(
                                        iconPath: AppAssets.documentIcon,
                                        attachmentOption: 'Document',
                                        attachmentSubtitle: 'Share your files',
                                        onPressed: () {},
                                      ),
                                      const Divider(indent: 50, height: 20),
                                      AttachmentOptionTile(
                                        iconPath: AppAssets.networkIcon,
                                        attachmentOption: 'Create a poll',
                                        attachmentSubtitle:
                                            'Create a poll for any query',
                                        onPressed: () {},
                                      ),
                                      const Divider(indent: 50, height: 20),
                                      AttachmentOptionTile(
                                        iconPath: AppAssets.mediaImageIcon,
                                        attachmentOption: 'Media',
                                        attachmentSubtitle:
                                            'Share photos and videos',
                                        onPressed: () {},
                                      ),
                                      const Divider(indent: 50, height: 20),
                                      AttachmentOptionTile(
                                        iconPath: AppAssets.contactIcon,
                                        attachmentOption: 'Contact',
                                        attachmentSubtitle:
                                            'Share your Contacts',
                                        onPressed: () {},
                                      ),
                                      const Divider(indent: 50, height: 20),
                                      AttachmentOptionTile(
                                        iconPath: AppAssets.locationMarkIcon,
                                        attachmentOption: 'Location',
                                        attachmentSubtitle:
                                            'Share your location',
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
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
                        hintText: 'Type your message here...',
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
    );
  }
}
