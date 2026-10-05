import 'dart:io';

import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/status_module/bloc/status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class StatusPreviewScreen extends StatefulWidget {
  const StatusPreviewScreen({super.key});

  @override
  State<StatusPreviewScreen> createState() => _StatusPreviewScreenState();
}

class _StatusPreviewScreenState extends State<StatusPreviewScreen> {
  final TextEditingController _captionController = TextEditingController();

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
                      controller: _captionController,
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
                  BlocConsumer<StatusBloc, StatusState>(
                    listener: (context, state) {
                      if (state is StatusPosted) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.mainScreen,
                        );
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context.read<StatusBloc>().add(
                            StatusPostPressed(
                              userId: context
                                  .read<AuthRepository>()
                                  .getCurrentUserId()!,
                              statusImagePath: image.path,
                              statusCaption: _captionController.text.trim(),
                            ),
                          );
                        },
                        child: state is StatusLoading
                            ? CircularProgressIndicator()
                            : CommonSvgContainer(
                                containerSize: 42,
                                iconPath: AppAssets.messageSendIcon,
                                iconColor: AppColors.white,
                                backgroundColor: AppColors.bgGreen,
                              ),
                      );
                    },
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
