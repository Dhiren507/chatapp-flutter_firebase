import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/messages_module/chat_listing/bloc/chat_list_bloc.dart';
import 'package:chatapp_firebase/features/messages_module/chat_listing/widgets/status_list_view.dart';
import 'package:chatapp_firebase/features/messages_module/widgets/chat_list_tile.dart';
import 'package:chatapp_firebase/features/settings_module/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      final currentUserId = context.read<AuthRepository>().getCurrentUserId()!;

      context.read<ChatListBloc>().add(
        ChatListFetchRequested(currentUserId: currentUserId),
      );
      context.read<SettingBloc>().add(SettingProfileFetchRequested());
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
          child: GestureDetector(
            onTap: () {
              bool isGroupSearch = true;
              Navigator.of(context)
                  .pushNamed(AppRoutes.searchScreen, arguments: isGroupSearch);
            },
            child: CommonSvgContainer(
              iconPath: AppAssets.searchIcon,
              iconSize: 22,
              containerSize: 44,
              iconColor: AppColors.white,
              borderColor: AppColors.borderGrey,
            ),
          ),
        ),
        actions: [
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              final photoUrl = state.userProfile?.photoUrl ?? '';

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.profileScreen);
                },
                child: CommonAvatar(imgPath: photoUrl, size: 44),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if (state.status == ChatListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.green),
            );
          }

          if (state.status == ChatListStatus.error) {
            return Center(child: Text(state.errorMsg));
          }

          if (state.status == .loaded) {
            final currentUserId = state.currentUserId!;
            final chatList = state.chatList;
            final otherUserStatusList = state.statusList;
            final currentUserStatus = state.currentUserStatus;

            return Column(
              children: [
                // Status Horizontal List
                StatusListView(
                  currentUserStatus: currentUserStatus,
                  otherUserStatus: otherUserStatusList,
                  currentUserId: currentUserId,
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
                          child: chatList.isNotEmpty
                              ? ListView.separated(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  itemBuilder: (context, index) {
                                    final chatTileData = state.chatList[index];

                                    print(
                                      ' is this groupChat : ${chatTileData.isGroup}',
                                    );

                                    final otherUserProfile = chatTileData
                                        .getOtherUserProfile(
                                          state.currentUserId!,
                                        );

                                    return GestureDetector(
                                      behavior: .opaque,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.chatDetailScreen,
                                          arguments:
                                              chatTileData.isGroup ?? false
                                              ? chatTileData.chatId
                                              : otherUserProfile,
                                        );
                                      },
                                      child: ChatListTile(
                                        chatListData: chatTileData,
                                        currentUserId: state.currentUserId!,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 20),
                                  itemCount: state.chatList.length,
                                )
                              : const Center(child: Text('No Chats Yet!')),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
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
