import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/contacts_module/widgets/contact_list_tile.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: CommonBackButton(),
          backgroundColor: AppColors.white,
          title: Text(
            AppStrings.searchScreenTitle,
            style: AppTextStyles.heading(fontSize: 20, color: AppColors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: AppTextStyles.body(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.bgDisables,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: CommonSvgContainer(
                      iconPath: AppAssets.searchIcon,
                      iconSize: 24,
                      containerSize: 24,
                      borderColor: Colors.transparent,
                      iconColor: AppColors.black,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 24,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close, color: AppColors.textPrimary),
                  ),
                  hintText: AppStrings.searchHintText,
                  hintStyle: AppTextStyles.body(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                AppStrings.searchPeopleSectionTitle,
                style: AppTextStyles.heading(),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) {
                    return const ContactListTile();
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
