import 'dart:io';

import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StatusPreviewScreen extends StatelessWidget {
  const StatusPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final image = ModalRoute.of(context)?.settings.arguments as XFile;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: CommonBackButton(),
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(child: Image.file(File(image.path))),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Row(
                spacing: 10,
                children: [
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
    );
  }
}
