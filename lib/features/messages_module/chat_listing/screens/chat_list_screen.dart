import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/utils/image_picker_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_bottom_sheet.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/messages_module/chat_listing/bloc/chat_list_bloc.dart';
import 'package:chatapp_firebase/features/messages_module/widgets/chat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatListBloc>().add(
        ChatListFetchRequested(
          currentUserId: context.read<AuthRepository>().getCurrentUserId()!,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leadingWidth: 65,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.chatListScreenTitle,
          style: AppTextStyles.heading(fontSize: 20, color: AppColors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CommonSvgContainer(
            iconPath: AppAssets.searchIcon,
            iconSize: 22,
            containerSize: 44,
            iconColor: AppColors.white,
            borderColor: AppColors.borderGrey,
          ),
        ),
        actions: [CommonAvatar(imgPath: AppAssets.appleIcon)],
      ),
      body: Column(
        children: [
          // Status Horizontal List
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25, bottom: 20),
            child: SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: .horizontal,
                clipBehavior: .none,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      spacing: 10,
                      children: [
                        Stack(
                          clipBehavior: .none,
                          children: [
                            CommonAvatar(
                              imgPath: AppAssets.appleIcon,
                              size: 58,
                              borderColor: AppColors.highlightYellow,
                            ),
                            Positioned(
                              bottom: -1,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  List<XFile>?
                                  statusImages = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return CommonBottomSheet(
                                        isStatusScreen: true,
                                        onMediaPressed: () async {
                                          List<XFile> selectedStatusImage =
                                              await ImagePickerUtils.pickImage(
                                                isMultiSelect: false,
                                              );
                                          if (context.mounted) {
                                            Navigator.pop(
                                              context,
                                              selectedStatusImage,
                                            );
                                          }
                                        },
                                        onCameraPressed: () async {
                                          XFile? capturedImage =
                                              await ImagePickerUtils.captureImage();

                                          if (!context.mounted) return;

                                          if (capturedImage != null) {
                                            Navigator.pop(context, <XFile>[
                                              capturedImage,
                                            ]);
                                          }
                                        },
                                      );
                                    },
                                  );

                                  if (!context.mounted) return;

                                  if (statusImages != null &&
                                      statusImages.isNotEmpty) {
                                    XFile? statusImage = statusImages[0];

                                    print(statusImage.name);

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
                  return Column(
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.statusViewScreen,
                          );
                        },
                        child: CommonAvatar(
                          imgPath: 'lskjfs',
                          size: 58,
                          borderColor: AppColors.highlightYellow,
                        ),
                      ),
                      Text(
                        'Hellow',
                        style: AppTextStyles.heading(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemCount: 15,
              ),
            ),
          ),

          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 3,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.mutedGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: BlocBuilder<ChatListBloc, ChatListState>(
                      builder: (context, state) {
                        if (state is ChatListLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (state is ChatListError) {
                          Center(child: Text(state.errorMsg));
                        }

                        if (state is ChatListLoaded) {
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            itemBuilder: (context, index) {
                              final chatTileData = state.chatList[index];

                              print(
                                'this is the chat tile data ${chatTileData.chatId}',
                              );
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.chatDetailScreen,
                                    arguments:
                                        chatTileData.otherUserProfile?.uid,
                                  );
                                },
                                child: ChatListTile(chatListData: chatTileData),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemCount: state.chatList.length,
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.crateGroupScreen);
        },
        backgroundColor: AppColors.green,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
