import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/features/call_module/screens/call_list_screen.dart';
import 'package:chatapp_firebase/features/chat_module/chat_listing/screens/chat_list_screen.dart';
import 'package:chatapp_firebase/features/contacts_module/screens/contact_list_screen.dart';
import 'package:chatapp_firebase/features/settings_module/screens/settings_screen.dart';
import 'package:chatapp_firebase/features/tab_bar/cubit/tab_bar_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_strings.dart';

class TabBarBaseScreen extends StatefulWidget {
  const TabBarBaseScreen({super.key});

  @override
  State<TabBarBaseScreen> createState() => _TabBarBaseScreenState();
}

class _TabBarBaseScreenState extends State<TabBarBaseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _tabController.addListener(() {
        if (!_tabController.indexIsChanging) {
          context.read<TabBarIndexCubit>().changeTabBarIndex(
            _tabController.index,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<TabBarIndexCubit, int>(
        builder: (context, activeIndex) {
          return SafeArea(
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: SizedBox(
                  height: 60,
                  child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelColor: AppColors.green,
                    unselectedLabelColor: AppColors.textSecondary,
                    dividerColor: Colors.transparent,
                    labelStyle: AppTextStyles.heading(),
                    indicator: BoxDecoration(color: Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    tabs: [
                      Tab(
                        icon: SvgPicture.asset(
                          AppAssets.messageIcon,
                          height: 28,
                          width: 28,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            activeIndex == 0
                                ? AppColors.green
                                : AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                        text: AppStrings.tabBarLabelOne,
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppAssets.callIcon,
                          height: 28,
                          width: 28,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            activeIndex == 1
                                ? AppColors.green
                                : AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                        text: AppStrings.tabBarLabelTwo,
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppAssets.contactIcon,
                          height: 28,
                          width: 28,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            activeIndex == 2
                                ? AppColors.green
                                : AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                        text: AppStrings.tabBarLabelThree,
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          AppAssets.settingsIcon,
                          height: 28,
                          width: 28,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                            activeIndex == 3
                                ? AppColors.green
                                : AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                        text: AppStrings.tabBarLabelFour,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ChatListScreen(),
          CallListScreen(),
          ContactListScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
