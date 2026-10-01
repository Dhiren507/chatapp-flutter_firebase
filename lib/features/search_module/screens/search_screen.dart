import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_svg_container.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:chatapp_firebase/features/contacts_module/widgets/contact_list_tile.dart';
import 'package:chatapp_firebase/features/search_module/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchBloc>().add(
        SearchInitiated(
          currentUserid: context.read<AuthRepository>().getCurrentUserId()!,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchError) {
                    Center(child: Text(state.errorMsg));
                  }

                  if (state is SearchSuccess) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final contact = state.contacts[index];

                        bool isSelected = state.selectedUsers.contains(contact);
                        return GestureDetector(
                          behavior: .opaque,
                          onTap: () {
                            context.read<SearchBloc>().add(
                              ContactSelectionToggled(selectedUser: contact),
                            );
                          },
                          child: Container(
                            color: isSelected
                                ? AppColors.black
                                : AppColors.white,
                            child: ContactListTile(
                              contactName: contact.name ?? '',
                              profileUrl: contact.photoUrl ?? '',
                              contactBio: contact.bioText ?? '',
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: state.contacts.length,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
