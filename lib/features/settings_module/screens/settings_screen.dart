import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/widgets/common_avatar.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/pressable_option_tile.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/settings_module/bloc/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(SettingProfileFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          actionsPadding: EdgeInsets.only(right: 24),
          leadingWidth: 65,
          backgroundColor: Colors.transparent,
          title: Text(
            AppStrings.settingsScreenTitle,
            style: AppTextStyles.heading(fontSize: 20, color: AppColors.white),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: CommonBackButton(arrowColor: AppColors.white),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),

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

                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BlocBuilder<SettingBloc, SettingState>(
                        builder: (context, state) {
                          final user = state.userProfile;
                          final String displayName = user?.name?.isNotEmpty == true
                              ? user!.name!
                              : (state.status == SettingStatus.loading ? 'Loading...' : 'User');
                          final String bioOrEmail = user?.bioText?.isNotEmpty == true
                              ? user!.bioText!
                              : (user?.email ?? 'Life is going good af...');
                          final String photoUrl = user?.photoUrl ?? '';

                          return Row(
                            children: [
                              CommonAvatar(
                                imgPath: photoUrl,
                                size: 60,
                                borderColor: Colors.transparent,
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      displayName,
                                      style: AppTextStyles.heading(fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      bioOrEmail,
                                      style: AppTextStyles.body(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                icon: const Icon(Icons.logout),
                                onPressed: () {
                                  context.read<AuthRepository>().logOut();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.onboardingScreen,
                                    (route) => false,
                                  );
                                },
                                color: AppColors.bgError,
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    Divider(),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        child: ListView.separated(
                          clipBehavior: .none,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final option = AppStrings.settingsOptions[index];
                            return PressableOptionTile(
                              iconPath: option['leadingIcon'],
                              optionTitle: option['optionText'],
                              optionDescription: option['subtitle'],
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  option['navigateTo'],
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 25),
                          itemCount: AppStrings.settingsOptions.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
