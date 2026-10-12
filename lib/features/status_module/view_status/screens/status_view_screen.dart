import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/utils/date_format_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
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
      final userStatusList =
          ModalRoute.of(context)?.settings.arguments as List<UserStatus>? ?? [];
      if (userStatusList.isNotEmpty) {
        final status = userStatusList[0];
        final currentUserId = context.read<AuthRepository>().getCurrentUserId();

        if (currentUserId != null && status.userId != currentUserId) {
          context.read<ViewStatusBloc>().add(
            MarkStatusAsSeen(
              statusId: status.id ?? '',
              currentUserId: currentUserId,
            ),
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

  void _confirmDelete(BuildContext context, String statusId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Delete Status',
            style: AppTextStyles.heading(fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to delete this status? This cannot be undone.',
            style: AppTextStyles.body(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: AppTextStyles.body(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<ViewStatusBloc>().add(
                  DeleteStatus(statusId: statusId),
                );
              },
              child: Text(
                'Delete',
                style: AppTextStyles.body(
                  color: AppColors.bgError,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showViewersBottomSheet(BuildContext context, List<String> viewerIds) {
    final bloc = context.read<ViewStatusBloc>();
    bloc.add(FetchStatusViewers(viewerIds: viewerIds));

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: bloc,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.mutedGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Viewed by (${viewerIds.length})',
                  style: AppTextStyles.heading(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: '',
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<ViewStatusBloc, ViewStatusState>(
                    builder: (context, state) {
                      if (state.isLoadingViewers) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.green,
                          ),
                        );
                      }

                      if (state.viewers.isEmpty) {
                        return Center(
                          child: Text(
                            'No views yet',
                            style: AppTextStyles.body(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.viewers.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: AppColors.dividerColor,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final viewer = state.viewers[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CommonAvatar(
                              imgPath: viewer.photoUrl ?? '',
                              size: 42,
                            ),
                            title: Text(
                              viewer.name ?? 'User',
                              style: AppTextStyles.heading(fontSize: 14),
                            ),
                            subtitle: Text(
                              viewer.email ?? '',
                              style: AppTextStyles.body(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userStatusList =
        ModalRoute.of(context)?.settings.arguments as List<UserStatus>? ?? [];

    if (userStatusList.isEmpty) {
      return Scaffold(
        body: Center(child: Text(AppStrings.statusLoadFailedError)),
      );
    }

    final firstStatus = userStatusList.first;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const CommonBackButton(),
        title: BlocBuilder<ViewStatusBloc, ViewStatusState>(
          builder: (context, state) {
            final currentStatus = (state.currentIndex < userStatusList.length)
                ? userStatusList[state.currentIndex]
                : firstStatus;
            final timeAgo = currentStatus.createdAt != null
                ? DateFormatUtils.calculateTimeAgo(currentStatus.createdAt!)
                : 'Active Now';

            return ChatHeader(
              userName: currentStatus.username ?? '',
              status: timeAgo,
              imgUrl: currentStatus.profileUrl ?? '',
            );
          },
        ),
        titleSpacing: 0,
        actions: [
          BlocBuilder<ViewStatusBloc, ViewStatusState>(
            builder: (context, state) {
              final currentStatus = (state.currentIndex < userStatusList.length)
                  ? userStatusList[state.currentIndex]
                  : firstStatus;
              final currentUserId = context
                  .read<AuthRepository>()
                  .getCurrentUserId();
              final isMyStatus =
                  currentUserId != null &&
                  currentStatus.userId == currentUserId;

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (userStatusList.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${state.currentIndex + 1} of ${userStatusList.length}',
                        style: AppTextStyles.body(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  if (isMyStatus)
                    state.isDeleting
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.bgError,
                              ),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AppColors.bgError,
                            ),
                            tooltip: 'Delete Status',
                            onPressed: () =>
                                _confirmDelete(context, currentStatus.id ?? ''),
                          ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocListener<ViewStatusBloc, ViewStatusState>(
        listener: (context, state) {
          if (state.isDeleted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Status deleted')));
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: userStatusList.length,
                  onPageChanged: (int index) {
                    context.read<ViewStatusBloc>().add(
                      StatusIndexChanged(index: index),
                    );

                    final status = userStatusList[index];
                    final currentUserId = context
                        .read<AuthRepository>()
                        .getCurrentUserId();

                    if (currentUserId != null &&
                        status.userId != currentUserId) {
                      context.read<ViewStatusBloc>().add(
                        MarkStatusAsSeen(
                          statusId: status.id ?? '',
                          currentUserId: currentUserId,
                        ),
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
                            child: InteractiveViewer(
                              minScale: 1.0,
                              maxScale: 4.0,
                              child: CachedNetworkImage(
                                imageUrl: status.statusUrl ?? '',
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.green,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.broken_image_outlined,
                                        color: AppColors.borderGrey,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        AppStrings.statusLoadFailedError,
                                        style: AppTextStyles.body(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (status.captionText != null &&
                              status.captionText!.isNotEmpty)
                            Container(
                              color: AppColors.lightBlack,
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: Text(
                                status.captionText!,
                                style: AppTextStyles.heading(
                                  color: AppColors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<ViewStatusBloc, ViewStatusState>(
                builder: (context, state) {
                  final currentStatus =
                      (state.currentIndex < userStatusList.length)
                      ? userStatusList[state.currentIndex]
                      : firstStatus;
                  final currentUserId = context
                      .read<AuthRepository>()
                      .getCurrentUserId();
                  final isMyStatus =
                      currentUserId != null &&
                      currentStatus.userId == currentUserId;

                  if (!isMyStatus) return const SizedBox.shrink();

                  final seenCount = currentStatus.seenBy?.length ?? 0;

                  return GestureDetector(
                    onTap: () => _showViewersBottomSheet(
                      context,
                      currentStatus.seenBy ?? [],
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12, top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlack,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.visibility_outlined,
                            color: AppColors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$seenCount ${seenCount == 1 ? 'view' : 'views'}',
                            style: AppTextStyles.body(
                              color: AppColors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: '',
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.keyboard_arrow_up,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
