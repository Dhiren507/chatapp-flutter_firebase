import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_status.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../messages_module/widgets/chat_header.dart';

class StatusViewScreen extends StatelessWidget {
  const StatusViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final status = ModalRoute.of(context)?.settings.arguments as UserStatus;

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
          child: ChatHeader(
            userName: status.username ?? '',
            status: '',
            imgUrl: status.profileUrl ?? '',
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Center(
              child: Stack(
                clipBehavior: .none,
                children: [
                  CachedNetworkImage(
                    imageUrl: status.statusUrl ?? '',
                    placeholder: (context, url) {
                      return Center(child: CircularProgressIndicator());
                    },
                  ),

                  Positioned(
                    bottom: -25,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: AppColors.lightBlack,
                      alignment: .center,
                      child: Text(
                        status.captionText ?? 'Demo Caption',
                        style: AppTextStyles.heading(color: AppColors.white),
                      ),
                    ),
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
