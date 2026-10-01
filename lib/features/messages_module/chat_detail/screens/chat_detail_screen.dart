import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/utils/image_picker_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_bottom_sheet.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/messages_module/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/widgets/chat_bubble.dart';
import 'package:chatapp_firebase/features/messages_module/widgets/chat_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String otherUserId =
          ModalRoute.of(context)?.settings.arguments as String;

      context.read<ChatDetailBloc>().add(
        ChatDetailFetchRequested(
          otherUserId: otherUserId,
          currentUserid: context.read<AuthRepository>().getCurrentUserId()!,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: CommonBackButton(),
        title: BlocBuilder<ChatDetailBloc, ChatDetailState>(
          builder: (context, state) {
            if (state is ChatLoaded) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.profileScreen);
                },
                child: ChatHeader(
                  imgUrl: state.receiverUserProfile.photoUrl ?? '',
                  status: 'Active Now',
                  userName: state.receiverUserProfile.name ?? '',
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        centerTitle: false,
        actions: [
          CommonSvgContainer(
            containerSize: 30,
            iconPath: AppAssets.chatCallIcon,
            borderColor: Colors.transparent,
            iconSize: 24,
            iconColor: AppColors.textPrimary,
          ),
          const SizedBox(width: 10),
          CommonSvgContainer(
            containerSize: 30,
            iconPath: AppAssets.videoIcon,
            borderColor: Colors.transparent,
            iconColor: AppColors.textPrimary,
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 24),
        titleSpacing: 0,
      ),
      body: BlocBuilder<ChatDetailBloc, ChatDetailState>(
        builder: (context, state) {
          if (state is ChatDetailLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ChatError) {
            return Center(child: Text(state.errorMsg));
          }

          if (state is ChatLoaded) {
            final messages = state.currentChat?.messages ?? [];
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      child: messages.isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                final MessageModel msg = messages[index];
                                bool isMe =
                                    msg.senderId ==
                                    context
                                        .read<AuthRepository>()
                                        .getCurrentUserId()!;
                                return ChatBubble(
                                  isMe: isMe,
                                  message: msg,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 20),
                              itemCount: messages.length,
                            )
                          : Center(child: Text('No Messages Yet!')),
                    ),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        spacing: 10,
                        children: [
                          CommonSvgContainer(
                            containerSize: 24,
                            iconPath: AppAssets.attachmentIcon,
                            onClick: () async {
                              List<XFile> selectedAttachment =
                                  await showModalBottomSheet(
                                    backgroundColor: AppColors.white,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return CommonBottomSheet(
                                        onMediaPressed: () async {
                                          List<XFile> selectedStatusImage =
                                              await ImagePickerUtils.pickImage(
                                                isMultiSelect: true,
                                              );
                                          if (context.mounted) {
                                            Navigator.pop(
                                              context,
                                              selectedStatusImage,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  );
              
                              if (selectedAttachment.isNotEmpty) {
                                print(
                                  'this is an attachment selected in chat screen${selectedAttachment[0].name}',
                                );
                              }
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: _msgController,
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
                          GestureDetector(
                            onTap: () {
                              if(_msgController.text.isNotEmpty){
                                context.read<ChatDetailBloc>().add(
                                  SendMessagePressed(
                                    msgText: _msgController.text.trim(),
                                    currentUserid: context
                                        .read<AuthRepository>()
                                        .getCurrentUserId()!,
                                  ),
                                );
                                _msgController.clear();
                              }
                            },
                            child: CommonSvgContainer(
                              containerSize: 42,
                              iconPath: AppAssets.messageSendIcon,
                              iconColor: AppColors.black,
                              backgroundColor: AppColors.bgGreen,
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
          return SizedBox.shrink();
        },
      ),
    );
  }
}
