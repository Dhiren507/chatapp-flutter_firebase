import 'dart:io';

import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/utils/date_format_utils.dart';
import 'package:chatapp_firebase/core/utils/image_picker_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_bottom_sheet.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/messages_module/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/widgets/chat_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';
import '../../widgets/chat_bubble.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args = ModalRoute.of(context)?.settings.arguments;

      final currentUserProfile = await context.read<AuthRepository>().getCurrentUserProfile();

      if (!mounted) return;

      if (args is String) {
        context.read<ChatDetailBloc>().add(
          ChatDetailFetchRequested(groupChatId: args, currentUserProfile: currentUserProfile),
        );
      } else if (args is UserModel) {
        context.read<ChatDetailBloc>().add(
          ChatDetailFetchRequested(otherUserProfile: args, currentUserProfile: currentUserProfile),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
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
            if (state.status == .loaded) {
              final isGroup = state.currentChat?.isGroup ?? false;

              final headerTitle = isGroup
                  ? (state.currentChat?.groupName ?? '')
                  : (state.otherUserProfile?.name ?? '');

              final headerImgUrl = isGroup
                  ? (state.currentChat?.groupProfileUrl ?? '')
                  : (state.otherUserProfile?.photoUrl ?? '');

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.profileScreen,
                    arguments: [
                      ...(isGroup ? [] : [state.otherUserProfile]),
                      state.currentChat,
                    ],
                  );
                },
                child: ChatHeader(imgUrl: headerImgUrl, status: 'Active Now', userName: headerTitle),
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
      body: BlocConsumer<ChatDetailBloc, ChatDetailState>(
        listener: (context, state) {
          if (state.status == .loaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent + 50,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        },
        builder: (context, state) {
          if (state.status == .loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.status == .error) {
            return Center(child: Text(state.errorMsg));
          }

          if (state.status == .loaded) {
            final messages = state.currentChat?.messages ?? [];

            final isGroup = state.currentChat?.isGroup ?? false;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      child: messages.isNotEmpty
                          ? ListView.separated(
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                final MessageModel msg = messages[index];

                                final DateTime currentMsgTime = msg.createdAt!;
                                String currentLabel = DateFormatUtils.getChatDayLabel(currentMsgTime);

                                bool showLabel = false;
                                bool isSameSender = false;

                                if (index == 0) {
                                  showLabel = true;
                                } else {
                                  final MessageModel prevMsg = messages[index - 1];

                                  final DateTime prevMsgTime = prevMsg.createdAt!;

                                  final bool isSameDay =
                                      currentMsgTime.year == prevMsgTime.year &&
                                      currentMsgTime.month == prevMsgTime.month &&
                                      currentMsgTime.day == prevMsgTime.day;

                                  isSameSender = prevMsg.senderId == msg.senderId;

                                  if (!isSameDay) {
                                    showLabel = true;
                                    isSameSender = false;
                                  }
                                }

                                bool isMe = msg.senderId == state.currentUserProfile?.uid;

                                return Column(
                                  children: [
                                    if (showLabel) ...[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.bgGrey,
                                            borderRadius: BorderRadius.circular(4),
                                          ),

                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                                            child: Text(
                                              currentLabel,
                                              style: AppTextStyles.heading(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    ChatBubble(
                                      isMe: isMe,
                                      message: msg,
                                      isGroup: isGroup,
                                      isSameSender: isSameSender,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) => const SizedBox(height: 5),
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
                              List<XFile> selectedAttachment = await showModalBottomSheet(
                                backgroundColor: AppColors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return CommonBottomSheet(
                                    onMediaPressed: () async {
                                      List<XFile> selectedStatusImage = await ImagePickerUtils.pickImage(
                                        isMultiSelect: true,
                                      );
                                      if (context.mounted) {
                                        Navigator.pop(context, selectedStatusImage);
                                      }
                                    },
                                  );
                                },
                              );

                              if (selectedAttachment.isNotEmpty) {
                                print(
                                  'this is an attachment selected in chat screen${selectedAttachment[0].name}',
                                );

                                final currentBloc = BlocProvider.of<ChatDetailBloc>(context);

                                // images preview dialog box
                                showDialog(
                                  useSafeArea: false,
                                  context: context,
                                  builder: (dialogContext) {
                                    return BlocProvider.value(
                                      value: currentBloc,
                                      child: Dialog.fullscreen(
                                        child: SafeArea(
                                          child: Column(
                                            crossAxisAlignment: .start,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(dialogContext);
                                                },
                                                icon: Icon(Icons.close, color: AppColors.black),
                                              ),

                                              Expanded(
                                                child: PageView.builder(
                                                  itemBuilder: (context, index) {
                                                    final selectedImage = selectedAttachment[index];

                                                    return Image.file(File(selectedImage.path));
                                                  },
                                                  itemCount: selectedAttachment.length,
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsetsGeometry.all(10),
                                                child: Row(
                                                  spacing: 10,
                                                  children: [
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
                                                    BlocConsumer<ChatDetailBloc, ChatDetailState>(
                                                      listenWhen: (previous, current) =>
                                                          previous.status != .loaded &&
                                                          current.status == .loaded,
                                                      listener: (context, state) {
                                                        if (Navigator.canPop(dialogContext)) {
                                                          Navigator.pop(dialogContext);
                                                        }
                                                      },
                                                      builder: (context, state) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            context.read<ChatDetailBloc>().add(
                                                              SendMessagePressed(
                                                                msgText: _msgController.text.trim(),
                                                                selectedAttachment: selectedAttachment,
                                                              ),
                                                            );
                                                            _msgController.clear();
                                                          },
                                                          child: state.status == .loading
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
                                      ),
                                    );
                                  },
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
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                isDense: true,
                                hintText: AppStrings.chatMessageHintText,
                                hintStyle: AppTextStyles.body(
                                  fontWeight: .w400,
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_msgController.text.isNotEmpty) {
                                context.read<ChatDetailBloc>().add(
                                  SendMessagePressed(msgText: _msgController.text.trim()),
                                );
                                _msgController.clear();
                              }
                            },
                            child: CommonSvgContainer(
                              containerSize: 42,
                              iconPath: AppAssets.messageSendIcon,
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
