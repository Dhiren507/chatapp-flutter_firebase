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

import '../../../messages_module/widgets/chat_header.dart';

class StatusViewScreen extends StatefulWidget {
  const StatusViewScreen({super.key});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userStatusList = ModalRoute.of(context)?.settings.arguments as List<UserStatus>? ?? [];
      if (userStatusList.isNotEmpty) {
        final status = userStatusList[0];
        final currentUserId = context.read<AuthRepository>().getCurrentUserId();

        if (currentUserId != null && status.userId != currentUserId) {
          context.read<ViewStatusBloc>().add(
            MarkStatusAsSeen(statusId: status.id ?? '', currentUserId: currentUserId),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userStatusList = ModalRoute.of(context)?.settings.arguments as List<UserStatus>? ?? [];

    if (userStatusList.isEmpty) {
      return Scaffold(body: Center(child: Text(AppStrings.statusLoadFailedError)));
    }

    final firstStatus = userStatusList.first;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const CommonBackButton(),
        title: ChatHeader(
          userName: firstStatus.username ?? '',
          status: 'Active Now',
          imgUrl: firstStatus.profileUrl ?? '',
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: userStatusList.length,
                onPageChanged: (int index) {
                  final status = userStatusList[index];
                  final currentUserId = context.read<AuthRepository>().getCurrentUserId();

                  if (currentUserId != null && status.userId != currentUserId) {
                    context.read<ViewStatusBloc>().add(
                      MarkStatusAsSeen(statusId: status.id ?? '', currentUserId: currentUserId),
                    );
                  }
                },
                itemBuilder: (context, index) {
                  final status = userStatusList[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: status.statusUrl ?? '',
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                                ),
                              );
                            },
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Center(
                              child: Text(
                                AppStrings.statusLoadFailedError,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (status.captionText != null && status.captionText!.isNotEmpty)
                          Container(
                            color: AppColors.lightBlack,
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Text(
                              status.captionText!,
                              style: AppTextStyles.heading(color: AppColors.white, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
