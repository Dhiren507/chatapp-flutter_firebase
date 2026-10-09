import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/utils/image_picker_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_bottom_sheet.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/status_module/data/models/user_status.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StatusListView extends StatelessWidget {
  final String currentUserId;
  final UserStatus? currentUserStatus;
  final List<UserStatus> otherUserStatus;

  const StatusListView({
    super.key,
    required this.currentUserStatus,
    required this.otherUserStatus,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> uniqueUserIds = otherUserStatus
        .map((status) => status.userId)
        .whereType<String>()
        .toSet()
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, bottom: 20),
      child: SizedBox(
        height: 92,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          separatorBuilder: (context, index) => const SizedBox(width: 15),
          itemCount: uniqueUserIds.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              final String avatarImgPath =
                  (currentUserStatus?.profileUrl != null && currentUserStatus!.profileUrl!.isNotEmpty)
                  ? currentUserStatus!.profileUrl!
                  : AppAssets.defaultAvatarSvg;

              return Column(
                spacing: 10,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (currentUserStatus != null) {
                            final currentUserSlides = otherUserStatus
                                .where((s) => s.userId == currentUserId)
                                .toList();

                            Navigator.pushNamed(
                              context,
                              AppRoutes.statusViewScreen,
                              arguments: currentUserSlides.isNotEmpty
                                  ? currentUserSlides
                                  : [currentUserStatus!],
                            );
                          }
                        },
                        child: CommonAvatar(
                          imgPath: avatarImgPath,
                          size: 58,
                          borderColor: currentUserStatus != null
                              ? AppColors.highlightYellow
                              : Colors.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: -1,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            List<XFile>? statusImages = await showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CommonBottomSheet(
                                  isStatusScreen: true,
                                  onMediaPressed: () async {
                                    List<XFile> selectedStatusImage = await ImagePickerUtils.pickImage(
                                      isMultiSelect: false,
                                    );
                                    if (context.mounted) {
                                      Navigator.pop(context, selectedStatusImage);
                                    }
                                  },
                                  onCameraPressed: () async {
                                    XFile? capturedImage = await ImagePickerUtils.captureImage();
                                    if (!context.mounted) return;
                                    if (capturedImage != null) {
                                      Navigator.pop(context, <XFile>[capturedImage]);
                                    }
                                  },
                                );
                              },
                            );

                            if (!context.mounted) return;

                            if (statusImages != null && statusImages.isNotEmpty) {
                              XFile? statusImage = statusImages[0];
                              Navigator.pushNamed(
                                context,
                                AppRoutes.statusPreviewScreen,
                                arguments: statusImage,
                              );
                            }
                          },
                          child: CommonSvgContainer(
                            containerSize: 16,
                            backgroundColor: AppColors.white,
                            iconPath: AppAssets.plusIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppStrings.myStatusText,
                    style: AppTextStyles.heading(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            }

            final String targetUserId = uniqueUserIds[index - 1];

            final List<UserStatus> userStatusList = otherUserStatus
                .where((s) => s.userId == targetUserId)
                .toList();

            final UserStatus firstStatus = userStatusList.first;

            bool isAllSeenByMe = userStatusList.every(
              (status) => status.seenBy?.contains(currentUserId) ?? false,
            );

            return Column(
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.statusViewScreen, arguments: userStatusList);
                  },
                  child: CommonAvatar(
                    imgPath: firstStatus.profileUrl ?? '',
                    size: 58,
                    borderColor: isAllSeenByMe ? AppColors.mutedGrey : AppColors.highlightYellow,
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    firstStatus.username ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
