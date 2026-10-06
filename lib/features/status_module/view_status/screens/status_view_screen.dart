import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/status_module/data/models/user_status.dart';
import 'package:chatapp_firebase/features/status_module/view_status/bloc/view_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../messages_module/widgets/chat_header.dart';

class StatusViewScreen extends StatefulWidget {
  const StatusViewScreen({super.key});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final status = ModalRoute.of(context)?.settings.arguments as UserStatus;

      final currentUserId = context.read<AuthRepository>().getCurrentUserId()!;

      if (status.userId != currentUserId) {
        context.read<ViewStatusBloc>().add(
          MarkStatusAsSeen(statusId: status.id!, currentUserId: currentUserId),
        );
      }
    });
  }

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
            status: 'Active now',
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
            CachedNetworkImage(
              imageUrl: status.statusUrl ?? '',
              placeholder: (context, url) {
                return Center(child: CircularProgressIndicator());
              },
              errorWidget: (context, url, error) {
                return Text(error.toString());
              },
            ),
            if (status.captionText != '')
              Container(
                color: AppColors.lightBlack,
                alignment: .center,
                child: Text(
                  status.captionText ?? 'Demo Caption',
                  style: AppTextStyles.heading(color: AppColors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
