import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/status_module/data/models/user_status.dart';
import 'package:chatapp_firebase/features/status_module/view_status/bloc/view_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../messages_module/widgets/chat_header.dart';

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
            status: 'Active Now',
            imgUrl: status.profileUrl ?? '',
          ),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 24),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: status.statusUrl ?? '',
                  imageBuilder: (context, imageProvider) {
                    final currentUserId = context.read<AuthRepository>().getCurrentUserId();

                    if (currentUserId != null && status.userId != currentUserId) {
                      context.read<ViewStatusBloc>().add(
                        MarkStatusAsSeen(statusId: status.id ?? '', currentUserId: currentUserId),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                      ),
                    );
                  },
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Center(child: Text(AppStrings.statusLoadFailedError)),
                ),
              ),
              const SizedBox(height: 10),
              if (status.captionText != '')
                Container(
                  color: AppColors.lightBlack,
                  width: .maxFinite,
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 6),
                    child: Text(
                      status.captionText ?? '',
                      style: AppTextStyles.heading(color: AppColors.white, fontSize: 18),
                      textAlign: .center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
