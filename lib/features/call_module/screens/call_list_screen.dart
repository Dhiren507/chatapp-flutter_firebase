import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/call_module/widgets/call_list_tile.dart';
import 'package:flutter/material.dart';

class CallListScreen extends StatelessWidget {
  const CallListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        leadingWidth: 65,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.callsScreenTitle,
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
        actions: [
          CommonSvgContainer(
            iconPath: AppAssets.callUserIcon,
            iconSize: 22,
            containerSize: 44,
            iconColor: AppColors.white,
            borderColor: AppColors.borderGrey,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: Text(
                        AppStrings.callsRecentSectionTitle,
                        style: AppTextStyles.heading(fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      itemBuilder: (context, index) {
                        return CallListTile();
                      },
                      separatorBuilder: (context, index) => const Divider(indent: 65),
                      itemCount: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
