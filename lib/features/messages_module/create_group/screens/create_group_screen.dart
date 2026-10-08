import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/utils/id_utils.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/group_module/create_group/bloc/create_group_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/models/user_model.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final currentUserProfile = await context.read<AuthRepository>().getCurrentUserProfile();

      if (!mounted) return;

      context.read<CreateGroupBloc>().add(CreateGroupStarted(adminProfile: currentUserProfile));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          AppStrings.createGroupScreenTitle,
          style: AppTextStyles.heading(fontSize: 20, color: AppColors.black),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CommonBackButton(arrowColor: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              AppStrings.createGroupDescriptionLabel,
              style: AppTextStyles.heading(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _titleController,
              keyboardType: .multiline,
              maxLines: 2,
              style: AppTextStyles.body(fontWeight: .w500, fontSize: 40, color: AppColors.textPrimary),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: AppStrings.createGroupTitleHintText,
                hintStyle: AppTextStyles.body(
                  fontWeight: .w400,
                  fontSize: 40,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgGreenLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text('Group Work', style: AppTextStyles.body(color: AppColors.textPrimary)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgGreenLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text('Team Relationship', style: AppTextStyles.body(color: AppColors.textPrimary)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              AppStrings.createGroupAdminLabel,
              style: AppTextStyles.heading(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 5),

            BlocBuilder<CreateGroupBloc, CreateGroupState>(
              builder: (context, state) {
                if (state is CreateGroupLoading) {
                  return CircularProgressIndicator.adaptive();
                }
                if (state is CreateGroupLoaded) {
                  return Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          CommonAvatar(imgPath: state.adminProfile.photoUrl ?? '', size: 52),
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                state.adminProfile.name ?? '',
                                style: AppTextStyles.heading(),
                                overflow: .ellipsis,
                              ),
                              Text(
                                AppStrings.createGroupAdminRoleText,
                                style: AppTextStyles.body(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Text(
                        AppStrings.createGroupInvitedMembersLabel,
                        style: AppTextStyles.heading(color: AppColors.textSecondary),
                      ),

                      SizedBox(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          itemBuilder: (context, index) {
                            if (index == state.members.length) {
                              return GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    AppRoutes.searchScreen,
                                    arguments: state.members,
                                  );

                                  if (result is List<UserModel> && context.mounted) {
                                    context.read<CreateGroupBloc>().add(
                                      CreateGroupMembersChanged(members: result),
                                    );
                                  }
                                },
                                child: Center(
                                  child: DottedBorder(
                                    options: CircularDottedBorderOptions(
                                      color: AppColors.dottedBorderGrey,
                                      strokeWidth: 2,
                                      dashPattern: [12, 7],
                                      padding: const EdgeInsets.all(6),
                                    ),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                      child: Icon(Icons.add, color: AppColors.textSecondary),
                                    ),
                                  ),
                                ),
                              );
                            }

                            final List<UserModel> invitedMembers = state.members;
                            final member = invitedMembers[index];
                            return Stack(
                              clipBehavior: .none,
                              children: [
                                CommonAvatar(imgPath: member.photoUrl ?? '', size: 70),

                                Positioned(
                                  top: -1,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      final updatedMembers = List<UserModel>.from(invitedMembers)..removeAt(index);
                                      context.read<CreateGroupBloc>().add(
                                        CreateGroupMembersChanged(members: updatedMembers),
                                      );
                                    },
                                    child: CommonSvgContainer(
                                      containerSize: 24,
                                      backgroundColor: AppColors.errorText,
                                      iconPath: AppAssets.removeIcon,
                                      iconColor: AppColors.white,
                                      iconSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: state.members.length + 1,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            Wrap(children: []),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocConsumer<CreateGroupBloc, CreateGroupState>(
          listener: (context, state) {
            if (state is CreateGroupInitial) {
              Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
            }
          },
          builder: (context, state) {
            if (state is CreateGroupLoaded || state is CreateGroupLoading) {
              final bool isLoading = state is CreateGroupLoading;
              final bool isButtonEnabled = state is CreateGroupLoaded && state.members.length > 1 && !isLoading;

              return Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
                child: CommonButton(
                  label: AppStrings.createGroupButtonText,
                  isLoading: isLoading,
                  onPressed: isButtonEnabled
                      ? () {
                          if (_titleController.text.isNotEmpty) {
                            context.read<CreateGroupBloc>().add(
                              CreateGroupSubmitted(
                                groupId: IdUtils.v4id,
                                groupTitle: _titleController.text.trim(),
                                groupAdminProfile: state.adminProfile,
                                members: state.members,
                              ),
                            );
                          }
                        }
                      : null,
                  backgroundColor: AppColors.bgGreen,
                  textColor: AppColors.white,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
